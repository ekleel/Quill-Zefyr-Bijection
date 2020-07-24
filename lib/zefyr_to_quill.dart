import 'dart:convert';

import 'package:quill_delta/quill_delta.dart';
import 'package:quill_zefyr_bijection/models/m.helper.dart';
import 'package:quill_zefyr_bijection/utils.dart';

Future<String> convertIterableToQuillJSON(
  Delta list, {
  QuillZefyrBijectionHelper helper,
}) async {
  var items = [];
  for (final op in list.toList()) {
    var item = {};

    dynamic nodeInsert = op.data;
    var nodeAttrs = op.attributes;

    if (nodeAttrs != null) {
      var attrs = {};

      for (final key in nodeAttrs.keys) {
        /// General styling
        if (key == 'b') {
          attrs['bold'] = true;
        } else if (key == 'i') {
          attrs['italic'] = true;
        } else if (key == 'a') {
          attrs['link'] = nodeAttrs[key] ?? 'n/a';
        }

        /// Blocks
        else if (key == 'block') {
          /// Quote
          if (nodeAttrs[key] == 'quote') {
            attrs['blockquote'] = true;
          }

          /// Lists
          else if (nodeAttrs[key] == 'ul' || nodeAttrs[key] == 'ol') {
            nodeInsert = '\n';
            attrs['list'] = nodeAttrs[key] == 'ul' ? 'bullet' : 'ordered';
          }
        }

        /// Heading
        else if (key == 'heading') {
          attrs['h${nodeAttrs[key] ?? 1}'] = true;
        }

        /// Embeds
        else if (key == 'embed') {
          /// Image
          if (nodeAttrs[key]['type'] == 'image') {
            nodeInsert = {'image': nodeAttrs[key]['source']};
          }

          /// Divider
          else if (nodeAttrs[key]['type'] == 'hr') {
            nodeInsert = {'divider': true};
          }

          /// Call helper
          if (helper != null) {
            nodeInsert = await helper.handleToQuillEmbeds(
              nodeInsert,
              nodeAttrs[key]['source'],
            );
          }
        }

        /// Not supported
        else {
          console('ToQuill - ignoring: $key - ${nodeAttrs[key]}');
        }
      }

      if (attrs.keys.isNotEmpty) {
        item['attributes'] = attrs;
      }
    }
    if (nodeInsert != null) {
      item['insert'] = nodeInsert;

      items.add(item);
    }
  }

  final obj = {'ops': items};
  final json = jsonEncode(obj);

  return json;
}
