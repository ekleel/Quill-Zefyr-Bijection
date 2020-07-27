import 'dart:convert';

import 'package:quill_delta/quill_delta.dart';
import 'package:quill_zefyr_bijection/models/m.helper.dart';
import 'package:quill_zefyr_bijection/quill_zefyr_bijection.dart';
import 'package:quill_zefyr_bijection/utils.dart';

Future<String> convertIterableToQuillJSON(
  Delta delta, {
  QuillZefyrBijectionHelper helper,
}) async {
  var items = [];
  final list = delta.toList();
  for (final op in list) {
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
          String source = nodeAttrs[key]['source'];
          source = QuillZefyrBijection.cleanEmbedIndex(source);

          /// Image
          if (nodeAttrs[key]['type'] == 'image') {
            nodeInsert = {'image': source};
          }

          /// Divider
          else if (nodeAttrs[key]['type'] == 'hr') {
            nodeInsert = {'divider': true};
          }

          /// Call helper
          if (helper != null) {
            nodeInsert = await helper.handleToQuillEmbeds(
              nodeInsert,
              source,
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
      if (nodeInsert is String && nodeInsert.length > 2 && items.isNotEmpty) {
        final index = items.length - 1;
        final prev = items[index];
        if (prev != null && prev["insert"] != null && prev["insert"] is Map) {
          if (nodeInsert.startsWith('\n')) {
            final divider = prev["insert"]["divider"];
            final hasDivider = divider != null && divider == true;
            if (hasDivider) {
              console('nodeInsert: $nodeInsert');
              nodeInsert = nodeInsert.replaceFirst('\n', '');
            }
          }
        }
      }

      item['insert'] = nodeInsert;

      items.add(item);
    }
  }

  final obj = {'ops': items};
  final json = jsonEncode(obj);

  return json;
}
