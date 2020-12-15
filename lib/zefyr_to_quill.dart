import 'dart:convert';

import 'package:quill_delta/quill_delta.dart';
import 'package:quill_zefyr_bijection/models/m.helper.dart';
import 'package:quill_zefyr_bijection/quill_zefyr_bijection.dart';
import 'package:quill_zefyr_bijection/utils.dart';

import 'utils.dart';

Future<String> convertIterableToQuillJSON(
  Delta delta, {
  QuillZefyrBijectionHelper helper,
}) async {
  // console('convertIterableToQuillJSON - delta:', map: delta);

  var items = [];
  final list = delta.toList();
  for (final op in list) {
    var item = {};

    dynamic nodeInsert = op.data;
    var nodeAttrs = op.attributes;

    // console('convertIterableToQuillJSON - ${op.key}:', map: {
    //   'nodeInsert': nodeInsert,
    //   'nodeAttrs': nodeAttrs,
    // });

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
              nodeInsert = nodeInsert.replaceFirst('\n', '');
            }
          }
        }
      }

      if (nodeInsert is Map) {
        final type = nodeInsert['_type'];
        String source = nodeInsert['source'];

        final prev = items.isNotEmpty ? items[items.length - 1] : null;

        console('convertIterableToQuillJSON:', map: {
          'type': type,
          'source': source,
          'prev': prev,
        });

        if (prev != null && prev['insert'] is String && prev['insert'] == '\n') {
          items.removeAt(items.length - 1);
        }

        /// Divider
        if (type == 'hr') {
          nodeInsert = {'divider': true};
        }

        /// Call helper
        if (helper != null) {
          nodeInsert = await helper.handleToQuillEmbeds(
            nodeInsert,
            type,
            source,
          );
        }
      }

      item['insert'] = nodeInsert;

      items.add(item);
    }
  }

  if (items.isNotEmpty && items.last['insert'] is String) {
    if (items.last['insert'] == '\n') {
      items.removeAt(items.length - 1);
    } else if (items.last['insert'].endsWith('\n')) {
      final value = items[items.length - 1]['insert'] as String;
      final start = value.lastIndexOf('\n');
      items.last['insert'] = value.replaceRange(start, start + 1, '');
      // final matches = '\n\n'.allMatches(value);
      // console('convertIterableToQuillJSON final:', map: {
      //   'value': value,
      //   'start': start,
      //   'matches': matches.map((m) => m.start).map((i) => i).join(', '),
      // });
    }
  }

  final obj = {'ops': items};
  final json = jsonEncode(obj);

  return json;
}
