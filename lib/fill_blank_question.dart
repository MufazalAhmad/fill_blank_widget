class FillBlankQuestion {
  String? text;
  List<String>? option;
  List<String>? answer;

  FillBlankQuestion({
    this.text,
    this.option,
    this.answer,
  });

  FillBlankQuestion copyWith({
    String? question,
    List<String>? option,
    List<String>? answer,
  }) {
    return FillBlankQuestion(
      text: question ?? this.text,
      option: option ?? this.option,
      answer: answer ?? this.answer,
    );
  }
}
