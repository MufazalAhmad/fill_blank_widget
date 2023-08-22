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
    List<String>? options,
    bool? isCorrect,
  }) {
    return FillBlankQuestion(
      text: text ?? this.text,
      options: options ?? this.options,
      isCorrect: isCorrect ?? this.isCorrect,
    );
  }

  @override
  String toString() {
    return 'FillBlankQuestion{options: $options, isCorrect: $isCorrect}';
  }
}
