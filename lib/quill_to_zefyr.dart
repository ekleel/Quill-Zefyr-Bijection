import 'package:quill_delta/quill_delta.dart';
import 'package:quill_zefyr_bijection/models/m.helper.dart';
import 'package:quill_zefyr_bijection/utils.dart';

Delta convertIterableToDelta(
  Iterable list, {
  QuillZefyrBijectionHelper helper,
}) {
  var items = [];
  final _list = list.toList();
  for (final node in _list) {
    var item = {};
    final index = _list.indexOf(node);
    var nodeInsert = node['insert'];
    var nodeAttrs = node['attributes'];

    if (nodeAttrs != null) {
      var attrs = {};
      if (nodeAttrs is Map) {
        for (final key in nodeAttrs.keys) {
          /// Already supported
          if ([
            'b',
            'i',
            'block',
            'heading',
            'a',
          ].contains(key)) {
            attrs[key] = nodeAttrs[key];
          }

          /// Known but not supported
          else if (['background', 'align'].contains(key)) {
            console('ToDelta - background and align not implemented.' + key);
          } else {
            /// General styling
            if (key == 'bold') {
              attrs['b'] = true;
            } else if (key == 'italic') {
              attrs['i'] = true;
            } else if (key == 'blockquote') {
              attrs['block'] = 'quote';
            } else if (key == 'embed' && nodeAttrs[key]['type'] == 'dots') {
              attrs['embed'] = {'type': 'hr'};
            }

            /// Headers
            else if (key == 'header') {
              attrs['heading'] = nodeAttrs[key] ?? 1;
            } else if (key == 'h1') {
              attrs['heading'] = 1;
            } else if (key == 'h2') {
              attrs['heading'] = 2;
            } else if (key == 'h3') {
              attrs['heading'] = 3;
            } else if (key == 'h4') {
              attrs['heading'] = 3;
            } else if (key == 'h5') {
              attrs['heading'] = 3;
            } else if (key == 'h6') {
              attrs['heading'] = 3;
            }

            /// Link
            else if (key == 'link') {
              attrs['a'] = nodeAttrs[key] ?? 'n/a';
            }

            /// List
            else if (key == 'list') {
              attrs['block'] = nodeAttrs[key] == 'bullet' ? 'ul' : 'ol';
            }

            /// Not supported
            else {
              console('ToDelta - ignoring: $key');
            }
          }
        }

        if (attrs.keys.isNotEmpty) {
          item['attributes'] = attrs;
        }
      }
    }
    if (nodeInsert != null) {
      /// Map embed
      if (nodeInsert is Map) {
        /// Image
        if (nodeInsert.containsKey('image')) {
          final image = nodeInsert['image'];
          if (image is String) {
            /// Adds an index to fix duplicate embeds
            /// that don't have a previous line break.
            item = {
              'insert': '​\n',
              'attributes': {
                'embed': {
                  'type': 'image',
                  'source': '$image|-[$index]-|',
                }
              }
            };
          }
        }

        /// Divider
        else if (nodeInsert.containsKey('divider')) {
          item = {
            'insert': '​\n',
            'attributes': {
              'embed': {'type': 'hr'}
            }
          };
        }
      }

      /// String embed
      else {
        item['insert'] = nodeInsert;
      }

      /// Call helper
      if (helper != null && item['insert'] == null) {
        item = helper.handleToZefyrItem(item, nodeInsert, index);
      }

      if (item['insert'] != null) {
        items.add(item);
      } else {
        console('ToDelta - Not Valid: $nodeInsert');
      }
    }
  }

  final delta = Delta.fromJson(items);
  // check if delta does not end with a line break
  if (!delta.last.data.endsWith('\n')) delta.insert('\n');

  final dList = delta.toList();
  Delta fDelta;

  if (dList.length > 1) {
    fDelta = Delta();
    for (final op in dList) {
      final index = dList.indexOf(op);

      /// Check if item is an embed and the previous item
      /// does not end with a line break.
      if (index > 1) {
        if (op.hasAttribute('embed')) {
          final prev = dList[index - 1];
          if (prev.isEmpty || !prev.data.endsWith('\n')) {
            fDelta.insert('\n');
          }
        }
      }

      /// Adds a line break at the end of the previous item.
      if (op.hasAttribute('embed')) {
        if (op.attributes["embed"]["type"] != null && op.attributes["embed"]["type"] == 'hr') {
          final list = fDelta.toList();
          if (list.isNotEmpty) {
            final prev = list[list.length - 1];
            if (prev.isNotEmpty && !prev.data.endsWith('\n')) {
              fDelta.insert('\n');
            }
          }
        }
      }

      fDelta.push(op);
    }
  }

  return fDelta ?? delta;
}

// console('ToDelta - attribute:', map: {
//   'index': index,
//   'prev_cond': prev.isEmpty.toString(),
//   'prev_value': prev.data,
//   'current': op.attributes,
// });

/// TODO:
/// * Fix duplicate embeds, ex: two tweets after each other.
