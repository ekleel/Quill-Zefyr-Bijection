class QuillZefyrBijectionHelper {
  const QuillZefyrBijectionHelper({
    this.insertNode,
  });
  final Map<dynamic, dynamic> Function(dynamic node, Map<dynamic, dynamic> list) insertNode;
}
