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
    Map<String, dynamic> item = {};
    final index = _list.indexOf(node);
    var nodeInsert = node['insert'];
    var nodeAttrs = node['attributes'];

    /// Handle attributes
    if (nodeAttrs != null && nodeAttrs is Map) {
      var attrs = {};

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

    /// Handle inserts
    if (nodeInsert != null) {
      /// String embed
      if (nodeInsert is String) {
        item['insert'] = nodeInsert;
      }

      /// Map embed
      else if (nodeInsert is Map) {
        /// Divider
        if (nodeInsert.containsKey('divider')) {
          item = {
            'insert': {
              '_type': 'hr',
              '_inline': false,
            },
          };
        }
      }

      /// Call helper
      if (helper != null && item['insert'] == null) {
        item = helper.handleToZefyrItem(item, nodeInsert, index);
      }

      if (item['insert'] != null) {
        /// Add index to fix duplicate inline inserts
        if (item['insert'] is Map) {
          item['insert']['index'] = index;
        }
        items.add(item);
      } else {
        console('ToDelta - Not Valid: $nodeInsert');
      }
    }
  }

  final delta = Delta.fromJson(items);
  // check if delta does not end with a line break
  if (!(delta.last.data is String) || !delta.last.value.endsWith('\n')) {
    delta.insert('\n');
  }

  final dList = delta.toList();
  final fDelta = Delta();

  if (dList.isNotEmpty) {
    for (final op in dList) {
      final index = dList.indexOf(op);
      bool addNext = false;

      /// Append or Prepend line break
      /// * Prepend when:
      ///   * Previous line exists.
      ///   * Previous delta node does not end with break.
      ///   * Previous line is an inline embed or does not end with break.
      /// * Append when:
      ///   * Next line exists.
      ///   * Next line is an inline embed or does not start with break.
      ///
      if (op.data is Map) {
        final prev = index > 0 ? dList[index - 1] : null;
        final next = dList.length >= index + 1 ? dList[index + 1] : null;

        final lastEmpty = fDelta != null && fDelta.isNotEmpty ? fDelta.last.value != '\n' : false;

        final prepend = prev != null && lastEmpty && (prev.value is Map || !prev.value.endsWith('\n'));
        final append = next != null && (next.value is Map || (!next.value.startsWith('\n')));

        if (prepend) {
          fDelta.insert('\n');
        }
        if (append) {
          addNext = true;
        }

        // console('ToDelta - inject:', map: {
        //   'prepend': prepend,
        //   'append': append,
        //   'lastEmpty': lastEmpty,
        //   'prev': prev?.value,
        //   'current': op.value,
        //   'next': next?.value,
        // });
      }

      fDelta.push(op);

      if (addNext) {
        fDelta.insert('\n');
      }
    }
  }

  console('ToDelta - final:', map: {
    'delta': fDelta ?? delta,
  });

  return fDelta ?? delta;
}

// console('ToDelta - attribute:', map: {
//   'index': index,
//   'prev_cond': prev.isEmpty.toString(),
//   'prev_value': prev.data,
//   'current': op.attributes,
// });
