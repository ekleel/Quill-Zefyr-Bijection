class QuillZefyrBijectionHelper {
  const QuillZefyrBijectionHelper({
    this.handleToZefyrItem,
    this.handleToQuillEmbeds,
  });

  ///
  final Map<dynamic, dynamic> Function(
    Map<dynamic, dynamic> item,
    dynamic node,
  ) handleToZefyrItem;

  ///
  final Future<dynamic> Function(
    dynamic node,
    String source,
  ) handleToQuillEmbeds;
}
