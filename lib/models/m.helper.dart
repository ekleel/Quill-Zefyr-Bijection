class QuillZefyrBijectionHelper {
  const QuillZefyrBijectionHelper({
    this.handleToZefyrItem,
    this.handleToQuillEmbeds,
  });

  ///
  final Map<dynamic, dynamic> Function(
    Map<dynamic, dynamic> item,
    dynamic node,
    int index,
  ) handleToZefyrItem;

  ///
  final dynamic Function(
    dynamic node,
    String source,
  ) handleToQuillEmbeds;
}
