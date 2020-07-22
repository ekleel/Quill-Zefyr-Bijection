import 'package:quill_delta/quill_delta.dart';
import 'package:quill_zefyr_bijection/models/m.helper.dart';

Delta convertIterableToDelta(
  Iterable list, {
  QuillZefyrBijectionHelper helper,
}) {
  try {
    var finalZefyrData = [];
    list.toList().forEach((quillNode) {
      var item = {};
      // print(quillNode);
      var insertNode = quillNode['insert'];
      var attrNode = quillNode['attributes'];
      if (attrNode != null) {
        var finalZefyrAttributes = {};
        if (attrNode is Map) {
          attrNode.keys.forEach((attrKey) {
            /// Already supported
            if ([
              'b',
              'i',
              'block',
              'heading',
              'a',
            ].contains(attrKey)) {
              finalZefyrAttributes[attrKey] = attrNode[attrKey];
            }

            /// Known but not supported
            else if (['background', 'align'].contains(attrKey)) {
              print('not sure how to implement background and align' + attrKey);
            } else {
              /// General styling
              if (attrKey == 'bold') {
                finalZefyrAttributes['b'] = true;
              } else if (attrKey == 'italic') {
                finalZefyrAttributes['i'] = true;
              } else if (attrKey == 'blockquote') {
                finalZefyrAttributes['block'] = 'quote';
              } else if (attrKey == 'embed' && attrNode[attrKey]['type'] == 'dots') {
                finalZefyrAttributes['embed'] = {'type': 'hr'};
              }

              /// Headers
              else if (attrKey == 'header') {
                finalZefyrAttributes['heading'] = attrNode[attrKey] ?? 1;
              } else if (attrKey == 'h1') {
                finalZefyrAttributes['heading'] = 1;
              } else if (attrKey == 'h2') {
                finalZefyrAttributes['heading'] = 2;
              } else if (attrKey == 'h3') {
                finalZefyrAttributes['heading'] = 3;
              } else if (attrKey == 'h4') {
                finalZefyrAttributes['heading'] = 3;
              } else if (attrKey == 'h5') {
                finalZefyrAttributes['heading'] = 3;
              } else if (attrKey == 'h6') {
                finalZefyrAttributes['heading'] = 3;
              }

              /// Link
              else if (attrKey == 'link') {
                finalZefyrAttributes['a'] = attrNode[attrKey] ?? 'n/a';
              }

              /// List
              else if (attrKey == 'list') {
                finalZefyrAttributes['block'] = attrNode[attrKey] == 'bullet' ? 'ul' : 'ol';
              }

              /// Not supported
              else {
                print('ignoring ' + attrKey);
              }
            }
          });
          if (finalZefyrAttributes.keys.isNotEmpty) item['attributes'] = finalZefyrAttributes;
        }
      }
      if (insertNode != null) {
        bool addPreBreak = false;
        bool addBreak = false;

        /// Map embed
        if (insertNode is Map) {
          /// Image
          if (insertNode.containsKey('image')) {
            final image = insertNode['image'];
            if (image is String) {
              item = {
                'insert': '​',
                'attributes': {
                  'embed': {
                    'type': 'image',
                    'source': image,
                  }
                }
              };
              addBreak = true;
            }
          }

          /// Divider
          else if (insertNode.containsKey('divider')) {
            item = {
              'insert': '​',
              'attributes': {
                'embed': {'type': 'hr'}
              }
            };
            addBreak = true;
          }
        }

        /// String embed
        else {
          item['insert'] = insertNode;
        }

        if (item['insert'] == null && helper != null) {
          item = helper.insertNode(insertNode, item);
          addBreak = true;
        }

        if (item['insert'] != null) {
          if (addPreBreak) {
            finalZefyrData.add({'insert': ''});
          }

          finalZefyrData.add(item);

          if (addBreak) {
            finalZefyrData.add({'insert': '\n'});
          }
        } else {
          print('Not Valid: $insertNode');
        }
      }
    });

    // print('finalZefyrData: $finalZefyrData');

    return Delta.fromJson(finalZefyrData)..insert('\n');
  } catch (e) {
    rethrow;
  }
}
