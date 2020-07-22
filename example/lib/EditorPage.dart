import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:quill_zefyr_bijection/quill_zefyr_bijection.dart';
import 'package:zefyr/zefyr.dart';
import 'package:zefyr_quill/images.dart';

import 'constants.dart';

class EditorPage extends StatefulWidget {
  @override
  EditorPageState createState() => EditorPageState();
}

class EditorPageState extends State<EditorPage> {
  /// Allows to control the editor and the document.
  ZefyrController _controller;

  /// Zefyr editor like any other input field requires a focus node.
  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    // Here we must load the document and pass it to Zefyr controller.
    final document = _loadDocument();
    _controller = ZefyrController(document);
    _focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    // Note that the editor requires special `ZefyrScaffold` widget to be
    // one of its parents.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editor page'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              var res = QuillZefyrBijection.convertDeltaIterableToQuillJSON(_controller.document.toDelta());
              Scaffold.of(context).showBottomSheet(
                (context) => SingleChildScrollView(
                  child: Text(
                    res,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: ZefyrScaffold(
        child: ZefyrEditor(
          imageDelegate: CustomImageDelegate(),
          padding: const EdgeInsets.all(16),
          controller: _controller,
          focusNode: _focusNode,
        ),
      ),
    );
  }

  /// Loads the document to be edited in Zefyr.
  NotusDocument _loadDocument() {
    try {
      Delta d = QuillZefyrBijection.convertJSONToZefyrDelta(
        jsonEncode(QUILL_TO_ZEFYR_COMPLEX_JSON_2),
        // QUILL_TO_ZEFYR_SAMPLE,
        helper: QuillZefyrBijectionHelper(
          insertNode: (node, list) {
            // print('loadDocument Node: $node');
            // var attrs = {
            //   'embed': {
            //     'type': 'image',
            //     'source':
            //         'image:https://firebasestorage.googleapis.com/v0/b/kilmaapp.appspot.com/o/users%2F9ukEt3oZUGUdzHz2JhElKKkGuw42%2Fimages%2FoJ%40VaWlNu%23un(qbvAboqHkBg)%401000.jpeg?alt=media',
            //   }
            // };
            // list['insert'] = '\n';
            // list['attributes'] = attrs;
            list = {
              'insert': '​',
              'attributes': {
                'embed': {
                  'type': 'image',
                  'source':
                      'image:https://firebasestorage.googleapis.com/v0/b/kilmaapp.appspot.com/o/users%2F9ukEt3oZUGUdzHz2JhElKKkGuw42%2Fimages%2FoJ%40VaWlNu%23un(qbvAboqHkBg)%401000.jpeg?alt=media',
                }
              }
            };
            return list;
          },
        ),
      );
      return NotusDocument.fromDelta(d);

      // return NotusDocument.fromJson(NOTUS_DOC_SAMPLE);
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
