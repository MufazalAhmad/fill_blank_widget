import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:untitled/fill_the_blank_question_widget/fill_blank_options.dart';
import 'package:untitled/fill_the_blank_question_widget/fill_blank_question_text_span.dart';

import '../data.dart';
import '../fill_blank_question_model.dart';

class FillTheBlankQuestion extends StatefulWidget {
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
  State<FillTheBlankQuestion> createState() => _FillTheBlankQuestionState();
}

class _FillTheBlankQuestionState extends State<FillTheBlankQuestion> {
  bool showAnswer = false;
  bool reset = false;
  late FillBlankQuestion question;
  List<bool> fillBlanksAnswers = [];

  @override
  void initState() {
    super.initState();
    question = widget.question;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),

        FillBlankQuestionTextSpan(
          questionText: question.text,
          index: widget.index,
          reset: reset,
          showAnswer: showAnswer,
          onMatchedOption: (value) {
            if (value) {
              fillBlanksAnswers.add(true);
            } else {
              fillBlanksAnswers.add(false);
            }

            if (fillBlanksAnswers.length == 3) {
              final userAnswers = fillBlanksAnswers;

              final isCorrect = userAnswers.toSet();
              if (isCorrect.length == 1 && isCorrect.first == true) {
                final updateQuestion = question.copyWith(isCorrect: true);
                questions[widget.index] = updateQuestion;
                print(questions);
              }
            }
          },
        ),

        const SizedBox(height: 20),

        /// [fill the blank options]
        FillBlanksOption(
          reset: reset,
          onChange: (value) {
            reset = value;
            log("reset :${reset.toString()}");
          },
          questionOptions: question.options,
        ),

        /// [check question answer]
        if (widget.isTraining)
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                /// reset
                InkWell(
                  onTap: () {
                    reset = true;
                    fillBlanksAnswers.clear();
                    setState(() {});
                  },
                  child: const CircleAvatar(
                    child: Icon(Icons.restart_alt_outlined),
                  ),
                ),
                const SizedBox(width: 30),
                InkWell(
                  onTap: () {
                    if (fillBlanksAnswers.length == 3) {
                      showAnswer = true;
                      setState(() {});
                    }
                  },
                  child: CircleAvatar(
                    child: Icon(showAnswer
                        ? Icons.remove_red_eye
                        : Icons.remove_red_eye_outlined),
                  ),
                ),
              ],
            ),
          )
      ],
    );
  }
}
