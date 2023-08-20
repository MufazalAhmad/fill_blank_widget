class FillBlankQuestion {
  final String text;
  final List<String> options;
  bool? isCorrect;

  FillBlankQuestion({
    required this.text,
    required this.options,
    this.isCorrect,
  });

  FillBlankQuestion copyWith({
    String? text,
    List<String>? option,
    bool? isCorrect,
  }) {
    return FillBlankQuestion(
      text: text ?? this.text,
      options: option ?? this.options,
      isCorrect: isCorrect ?? this.isCorrect,
    );
  }
}
