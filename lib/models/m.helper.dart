class QuillZefyrBijectionHelper {
  const QuillZefyrBijectionHelper({
    this.handleToZefyrItem,
    this.handleToQuillEmbeds,
  });

  ///
  final Map<String, dynamic> Function(
    Map<String, dynamic> item,
    dynamic node,
    int index,
  ) handleToZefyrItem;

  ///
  final dynamic Function(
    dynamic node,
    String type,
    String source,
  ) handleToQuillEmbeds;
}
