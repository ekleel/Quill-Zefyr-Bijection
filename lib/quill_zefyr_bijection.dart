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
  static Future<String> convertDeltaIterableToQuillJSON(
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

  static String get embedIndexStart => '|-[';
  static String get embedIndexEnd => ']-|';

  /// Adds embed index which is added to fix duplicate
  /// embeds that don't have a previous line break.
  static String getEmbedIndex(int index) {
    return '$embedIndexStart$index$embedIndexEnd';
  }

  /// Removes embed index injection which is added to
  /// fix duplicate embeds that don't have a previous line break.
  static String cleanEmbedIndex(String key) {
    if (key.contains(embedIndexStart)) {
      final start = key.indexOf(embedIndexStart);
      final end = key.indexOf(embedIndexEnd) + embedIndexEnd.length;
      key = key.replaceRange(start, end, '');
    }
    return key;
  }
}
