import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/data.dart';
import 'package:untitled/fill_blank_question_model.dart';

class FillBlankQuestionNotifier extends StateNotifier<List<FillBlankQuestion>> {
  FillBlankQuestionNotifier() : super(questions);

  void reset(int id) {
    state = state
        .map((element) => element.id == id
            ? element.copyWith(reset: element.reset ? false : true)
            : element)
        .toList();

    final list = state;
    log(list.toString());
  }

  void setIsCorrect(int id, bool isCorrect) {
    state = state
        .map((element) =>
            element.id == id ? element.copyWith(isCorrect: isCorrect) : element)
        .toList();
  }

  void showAnswer(int id) {
    state = state
        .map((element) =>
            element.id == id ? element.copyWith(reset: true) : element)
        .toList();
  }
}

final fillBlanksQuestionProvider =
    StateNotifierProvider<FillBlankQuestionNotifier, List<FillBlankQuestion>>(
        (ref) => FillBlankQuestionNotifier());

final getResultProvider = StateProvider<int>((ref) {
  final questions = ref.watch(fillBlanksQuestionProvider);
  final result = questions
      .where(
          (element) => element.isCorrect != null && element.isCorrect == true)
      .toList();

  return result.length;
});

final showAllAnswer = StateProvider<bool>((ref) {
  return false;
});
