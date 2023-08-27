class FillBlankQuestion {
  final int id;
  final String text;
  final List<String> options;
  bool? isCorrect;
  bool reset = false;
  bool? showAnswer;

  FillBlankQuestion(
      {required this.id,
      required this.text,
      required this.options,
      this.isCorrect,
      required this.reset,
      this.showAnswer});

  FillBlankQuestion copyWith({
    String? text,
    List<String>? options,
    bool? isCorrect,
    bool? showAnswer,
    bool? reset,
  }) {
    return FillBlankQuestion(
      id: id,
      text: text ?? this.text,
      options: options ?? this.options,
      isCorrect: isCorrect ?? this.isCorrect,
      reset: reset ?? this.reset,
      showAnswer: showAnswer ?? this.showAnswer,
    );
  }

  @override
  String toString() {
    return 'FillBlankQuestion{id: $id, text: $text, options: $options, isCorrect: $isCorrect, reset: $reset, showAnswer: $showAnswer}';
  }
}
