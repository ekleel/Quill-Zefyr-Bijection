library quill_zefyr_bijection;

import 'dart:convert';

import 'package:quill_delta/quill_delta.dart';
import 'package:quill_zefyr_bijection/models/m.helper.dart';
import 'package:quill_zefyr_bijection/quill_to_zefyr.dart';
import 'package:quill_zefyr_bijection/zefyr_to_quill.dart';

export 'package:quill_zefyr_bijection/models/m.helper.dart';

/// A converter from quill and zefyr.
class QuillZefyrBijection {
  /// Returns zefyr delta for the given valid quill json string `{"ops":[]}`
  static Delta convertJSONToZefyrDelta(
    String jsonString, {
    QuillZefyrBijectionHelper helper,
  }) {
    try {
      var decodedJson = jsonDecode(jsonString);
      var quillOps = decodedJson['ops'] as Iterable;
      return convertIterableToDelta(
        quillOps,
        helper: helper,
      );
    } catch (e) {
      rethrow;
    }
  }

  /// Returns zefyr delta for the given valid already parsed json `[{"insert":""},"attributes":{}]`
  static Delta convertIterableToZefyrDelta(
    Iterable list, {
    QuillZefyrBijectionHelper helper,
  }) {
    try {
      return convertIterableToDelta(
        list,
        helper: helper,
      );
    } catch (e) {
      rethrow;
    }
  }

  /// Returns quill json from zefyr delta
  static String convertDeltaIterableToQuillJSON(
    Delta delta, {
    QuillZefyrBijectionHelper helper,
  }) {
    try {
      return convertIterableToQuillJSON(
        delta,
        helper: helper,
      );
    } catch (e) {
      rethrow;
    }
  }
}
