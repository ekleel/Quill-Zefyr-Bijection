import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/sunburst.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:quill_zefyr_bijection/quill_zefyr_bijection.dart';
import 'package:zefyr/zefyr.dart';
import 'package:zefyr_quill/images.dart';

import 'constants.dart';

const code = '''main() {
  print("Hello, World!");
}
''';

class EditorPage extends StatefulWidget {
  @override
  EditorPageState createState() => EditorPageState();
}

class EditorPageState extends State<EditorPage> {
  ZefyrController _controller;

  FocusNode _focusNode;

  bool _debugJson = false;

  String _debugCode;

  @override
  void initState() {
    super.initState();

    final document = _loadDocument();
    _controller = ZefyrController(document);
    _focusNode = FocusNode();

    _controller.document.changes.listen((change) {
      print('change: ${change.change}');
    });
  }

  void _updateDebugCode() async {
    String str;

    if (_debugJson) {
      final jsonStr = await QuillZefyrBijection.convertDeltaIterableToQuillJSON(
        _controller.document.toDelta(),
        helper: QuillZefyrBijectionHelper(
          handleToQuillEmbeds: (node, source) async {
            /// Image embed which can be a video or tweet.
            if (node['image'] != null) {
              /// Video
              if (source.startsWith('video:')) {
                node = {'video': source.replaceAll('video:', '')};
              }

              /// Tweet
              else if (source.startsWith('tweet:')) {
                node = {'tweet': source.replaceAll('tweet:', '')};
              }

              /// Image
              else if (source.startsWith('image:')) {
                node = {'image': source.replaceAll('image:', '')};
              }
            }

            return node;
          },
        ),
      );
      final obj = jsonDecode(jsonStr);
      JsonEncoder encoder = const JsonEncoder.withIndent('    ');
      str = encoder.convert(obj);
    } else {
      final delta = _controller.document.toDelta();
      final list = delta.toList();

      JsonEncoder encoder = const JsonEncoder.withIndent('    ');
      str = encoder.convert(list);
    }

    setState(() {
      _debugCode = str;
    });
  }

  Delta _getSampleDelta() {
    return Delta.fromJson(NOTUS_DOC_SAMPLE);
    return QuillZefyrBijection.convertJSONToZefyrDelta(
      jsonEncode(QUILL_TO_ZEFYR_HAS_ISSUE),
      // QUILL_TO_ZEFYR_SAMPLE,
      helper: QuillZefyrBijectionHelper(
        handleToZefyrItem: (item, node, index) {
          final indexKey = QuillZefyrBijection.getEmbedIndex(index);

          /// Image
          if (node['image'] != null && node['image'] is Map) {
            item = {
              'insert': '​\n',
              'attributes': {
                'embed': {
                  'type': 'image',
                  'source':
                      'image:https://firebasestorage.googleapis.com/v0/b/kilmaapp.appspot.com/o/users%2F9ukEt3oZUGUdzHz2JhElKKkGuw42%2Fimages%2FoJ%40VaWlNu%23un(qbvAboqHkBg)%401000.jpeg?alt=media',
                }
              },
            };
          }

          /// Video
          if (node['video'] != null) {
            item = {
              'insert': '​\n',
              'attributes': {
                'embed': {
                  'type': 'image',
                  'source': 'video:${node['video']}$indexKey',
                }
              },
            };
          }

          /// Tweet
          if (node['tweet'] != null) {
            item = {
              'insert': '​\n',
              'attributes': {
                'embed': {
                  'type': 'image',
                  'source': 'tweet:${node['tweet']}$indexKey',
                }
              },
            };
          }

          // return {
          //   'insert': '​\n',
          //   'attributes': {
          //     'embed': {
          //       'type': 'image',
          //       'source': 'temp',
          //     }
          //   }
          // };

          return item;
        },
      ),
    );
  }

  NotusDocument _loadDocument() {
    try {
      Delta d = _getSampleDelta();
      return NotusDocument.fromDelta(d);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editor page'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ZefyrScaffold(
                  child: ZefyrEditor(
                    imageDelegate: CustomImageDelegate(),
                    padding: const EdgeInsets.all(16),
                    controller: _controller,
                    focusNode: _focusNode,
                  ),
                ),
              ),
              Container(
                width: constraints.maxWidth / 2.25,
                color: Colors.black,
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                        child: Row(
                          children: [
                            FlatButton(
                              color: Colors.blueGrey[800],
                              textColor: Colors.white,
                              onPressed: () {
                                setState(() => _debugJson = true);
                                _updateDebugCode();
                              },
                              child: const Text('Quill'),
                            ),
                            const SizedBox(width: 10.0),
                            FlatButton(
                              color: Colors.blueGrey[800],
                              textColor: Colors.white,
                              onPressed: () {
                                setState(() => _debugJson = false);
                                _updateDebugCode();
                              },
                              child: const Text('Zefyr'),
                            ),
                            const SizedBox(width: 10.0),
                            FlatButton(
                              color: Colors.blueGrey[800],
                              textColor: Colors.white,
                              onPressed: () {
                                Clipboard.setData(
                                  ClipboardData(
                                    text: _debugCode ?? 'No Code',
                                  ),
                                );
                              },
                              child: const Text('Copy'),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: HighlightView(
                            _debugCode ?? 'No Code',
                            theme: sunburstTheme,
                            language: 'dart',
                            padding: const EdgeInsets.all(15.0),
                            textStyle: const TextStyle(
                              fontFamily: 'My awesome monospace font',
                              fontSize: 14.0,
                              height: 1.1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
