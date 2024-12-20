import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/fill_the_blank_question_widget/fill_blank_options.dart';
import 'package:untitled/fill_the_blank_question_widget/fill_blank_question_text_span.dart';
import 'package:untitled/provider/fill_blanks_question_provider.dart';

import '../fill_blank_question_model.dart';

class FillTheBlankQuestion extends ConsumerStatefulWidget {
  final FillBlankQuestion question;
  final int index;
  final bool isTraining;

  const FillTheBlankQuestion({
    super.key,
    required this.question,
    required this.index,
    required this.isTraining,
  });

  @override
  ConsumerState<FillTheBlankQuestion> createState() =>
      _FillTheBlankQuestionState();
}

class _FillTheBlankQuestionState extends ConsumerState<FillTheBlankQuestion> {
  bool showAnswer = false;

  late List<String> selectedOption;

  List<bool> fillBlanksAnswers = [];

  void onMatchOption(bool value) {
    if (value) {
      fillBlanksAnswers.add(true);
    } else {
      fillBlanksAnswers.add(false);
    }
    if (fillBlanksAnswers.length == 3) {
      final userAnswers = fillBlanksAnswers;
      final isCorrect = userAnswers.toSet();
      if (isCorrect.length == 1 && isCorrect.first == true) {
        ref
            .read(fillBlanksQuestionProvider.notifier)
            .setIsCorrect(widget.question.id, true);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    selectedOption = List.from(widget.question.options);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),

          FillBlankQuestionTextSpan(
            questionText: widget.question.text,
            id: widget.question.id,
            reset: widget.question.reset,
            showAnswer: showAnswer,
            onMatchedOption: onMatchOption,
          ),

          const SizedBox(height: 20),

          /// [fill the blank options]
          FillBlanksOption(
            reset: widget.question.reset,
            questionOptions: selectedOption,
            onDragComplete: (value) {
              setState(() {
                selectedOption.remove(value);
              });
            },
          ),

          if (widget.isTraining)
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  /// [reset]
                  InkWell(
                    onTap: () {
                      ref
                          .read(fillBlanksQuestionProvider.notifier)
                          .reset(widget.question.id);
                      selectedOption = List.from(widget.question.options);
                      showAnswer = false;
                      fillBlanksAnswers.clear();

                      setState(() {});
                    },
                    child: const CircleAvatar(
                      child: Icon(Icons.restart_alt_outlined),
                    ),
                  ),
                  const SizedBox(width: 30),

                  /// [check question answer]

                  InkWell(
                    onTap: () {
                      if (fillBlanksAnswers.length == 3) {
                        showAnswer = true;
                        setState(() {});
                      }
                    },
                    child: CircleAvatar(
                      child: Icon(
                        showAnswer
                            ? Icons.remove_red_eye
                            : Icons.remove_red_eye_outlined,
                      ),
                    ),
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
