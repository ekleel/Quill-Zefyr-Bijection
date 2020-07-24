import 'package:quill_delta/quill_delta.dart';
import 'package:quill_zefyr_bijection/models/m.helper.dart';
import 'package:quill_zefyr_bijection/utils.dart';

Delta convertIterableToDelta(
  Iterable list, {
  QuillZefyrBijectionHelper helper,
}) {
  var items = [];
  for (final node in list.toList()) {
    var item = {};

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
            item = {
              'insert': '​\n',
              'attributes': {
                'embed': {
                  'type': 'image',
                  'source': image,
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
        item = helper.handleToZefyrItem(item, nodeInsert);
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

  return delta;
}
