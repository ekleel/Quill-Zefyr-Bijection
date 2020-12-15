import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/sunburst.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:quill_zefyr_bijection/quill_zefyr_bijection.dart';
import 'package:zefyr/zefyr.dart';

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
      // print('change: ${change.change}');
    });
  }

  void _updateDebugCode() async {
    String str;

    if (_debugJson) {
      final jsonStr = await QuillZefyrBijection.convertDeltaIterableToQuillJSON(
        _controller.document.toDelta(),
        helper: QuillZefyrBijectionHelper(
          handleToQuillEmbeds: (node, type, source) async {
            switch (type) {
              case 'image':
                node = {'image': source.replaceAll('image:', '')};
                break;
              case 'video':
                node = {'video': source.replaceAll('video:', '')};
                break;
              case 'tweet':
                node = {'tweet': source.replaceAll('tweet:', '')};
                break;
              default:
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
    // return Delta.fromJson(NOTUS_ISSOE);

    return QuillZefyrBijection.convertJSONToZefyrDelta(
      jsonEncode(QUILL_TO_ZEFYR_COMPLEX_JSON_3),
      helper: QuillZefyrBijectionHelper(
        handleToZefyrItem: (item, node, index) {
          // final indexKey = QuillZefyrBijection.getEmbedIndex(index);

          /// Image
          if (node['image'] != null && node['image'] is Map) {
            item = {
              'insert': {
                '_type': 'image',
                '_inline': false,
                'index': index,
                'source':
                    'https://firebasestorage.googleapis.com/v0/b/kilmaapp.appspot.com/o/users%2F9ukEt3oZUGUdzHz2JhElKKkGuw42%2Fimages%2FoJ%40VaWlNu%23un(qbvAboqHkBg)%401000.jpeg?alt=media',
              },
            };
          } else if (node['image'] != null) {
            item = {
              'insert': {
                '_type': 'image',
                '_inline': false,
                'index': index,
                'source':
                    'https://firebasestorage.googleapis.com/v0/b/kilmaapp.appspot.com/o/users%2F9ukEt3oZUGUdzHz2JhElKKkGuw42%2Fimages%2FoJ%40VaWlNu%23un(qbvAboqHkBg)%401000.jpeg?alt=media',
              },
            };
          }

          /// Video
          else if (node['video'] != null) {
            item = {
              'insert': {
                '_type': 'video',
                '_inline': false,
                'index': index,
                // 'source': '${node['video']}$indexKey',
                'source': node['video'],
              },
            };
          }

          /// Tweet
          else if (node['tweet'] != null) {
            item = {
              'insert': {
                '_type': 'tweet',
                '_inline': false,
                'index': index,
                // 'source': '${node['tweet']}$indexKey',
                'source': node['tweet'],
              },
            };
          }

          // other
          else {
            print('handleToZefyrItem: $item, $node, $index');
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
        title: const Text('المحرر'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: ZefyrToolbar.basic(controller: _controller),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ZefyrEditor(
                  padding: const EdgeInsets.all(16),
                  controller: _controller,
                  focusNode: _focusNode,
                  embedBuilder: (context, node) {
                    // print('embedBuilder - node: ${node.value.type} - ${node.value.data}');
                    switch (node.value.type) {
                      case 'hr':
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              3,
                              (index) => Container(
                                width: 6.0,
                                height: 6.0,
                                margin: const EdgeInsets.symmetric(horizontal: 2.0),
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(7.0),
                                ),
                              ),
                            ).toList(),
                          ),
                        );
                        break;
                      default:
                    }
                    return Container(
                      padding: const EdgeInsets.all(15.0),
                      color: Colors.grey.withOpacity(0.25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            node.value.type,
                            textAlign: TextAlign.center,
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              print('embedBuilder - clicked: ${node.value.type} - ${node.value.data}');
                            },
                          ),
                        ],
                      ),
                    );
                  },
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
