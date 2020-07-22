import 'package:quill_delta/quill_delta.dart';
import 'package:quill_zefyr_bijection/models/m.helper.dart';

Delta convertIterableToDelta(
  Iterable list, {
  QuillZefyrBijectionHelper helper,
}) {
  try {
    var finalZefyrData = [];
    list.toList().forEach((quillNode) {
      var finalZefyrNode = {};
      // print(quillNode);
      var quillInsertNode = quillNode['insert'];
      var quillAttributesNode = quillNode['attributes'];
      if (quillAttributesNode != null) {
        var finalZefyrAttributes = {};
        if (quillAttributesNode is Map) {
          quillAttributesNode.keys.forEach((attrKey) {
            /// Already supported
            if ([
              'b',
              'i',
              'block',
              'heading',
              'a',
            ].contains(attrKey)) {
              finalZefyrAttributes[attrKey] = quillAttributesNode[attrKey];
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
              } else if (attrKey == 'embed' && quillAttributesNode[attrKey]['type'] == 'dots') {
                finalZefyrAttributes['embed'] = {'type': 'hr'};
              }

              /// Headers
              else if (attrKey == 'header') {
                finalZefyrAttributes['heading'] = quillAttributesNode[attrKey] ?? 1;
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
                finalZefyrAttributes['a'] = quillAttributesNode[attrKey] ?? 'n/a';
              }

              /// List
              else if (attrKey == 'list') {
                finalZefyrAttributes['block'] = quillAttributesNode[attrKey] == 'bullet' ? 'ul' : 'ol';
              }

              /// Not supported
              else {
                print('ignoring ' + attrKey);
              }
            }
          });
          if (finalZefyrAttributes.keys.isNotEmpty) finalZefyrNode['attributes'] = finalZefyrAttributes;
        }
      }
      if (quillInsertNode != null) {
        bool addBreak = false;

        /// Map embed
        if (quillInsertNode is Map) {
          /// Image
          if (quillInsertNode.containsKey('image')) {
            final image = quillInsertNode['image'];
            if (image is String) {
              print('image: $image');
              var attrs = {
                'embed': {
                  'type': 'image',
                  'source': image,
                }
              };
              finalZefyrNode['insert'] = '';
              finalZefyrNode['attributes'] = attrs;
              addBreak = true;
            }
          }

          /// Divider
          else if (quillInsertNode.containsKey('divider')) {
            Map<String, dynamic> attrs = {
              'embed': {'type': 'hr'}
            };
            finalZefyrNode['insert'] = '';
            finalZefyrNode['attributes'] = attrs;
          }
        }

        /// String embed
        else {
          finalZefyrNode['insert'] = quillInsertNode;
        }

        if (finalZefyrNode['insert'] == null && helper != null) {
          finalZefyrNode = helper.insertNode(quillInsertNode, finalZefyrNode);
          // print('finalZefyrNode convert: $finalZefyrNode');
          addBreak = true;
        }

        if (finalZefyrNode['insert'] != null) {
          finalZefyrData.add(finalZefyrNode);

          if (addBreak) {
            finalZefyrData.add({'insert': '\n'});
          }
        } else {
          print('Not Valid: $quillInsertNode');
        }
      }
    });

    print('finalZefyrData: $finalZefyrData');
    return Delta.fromJson(finalZefyrData)..insert('\n');
  } catch (e) {
    rethrow;
  }
}
