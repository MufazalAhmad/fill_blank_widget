import 'package:flutter/material.dart';
import 'package:untitled/fill_the_blank_question_widget/blank_box_widget.dart';

class FillBlankQuestionTextSpan extends StatelessWidget {
  const FillBlankQuestionTextSpan({
    super.key,
    required this.reset,
    required this.index,
    required this.onMatchedOption,
    required this.showAnswer,
    required this.questionText,
  });
  final bool showAnswer;
  final bool reset;
  final int index;
  final String questionText;
  final void Function(bool value) onMatchedOption;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "${index + 1}) ",
            style: TextStyle(
              color: Colors.purple.withOpacity(0.8),
              fontSize: 20,
            ),
          ),
          ..._buildQuestionTextSpans()
        ],
      ),
    );
  }

  List<InlineSpan> _buildQuestionTextSpans() {
    List<InlineSpan> textSpans = [];
    final pattern = RegExp(r"{\[.*?\]}");

    int currentIndex = 0;
    pattern.allMatches(questionText).forEach((match) {
      String textBeforeMatch =
          questionText.substring(currentIndex, match.start);
      String matchedText =
          match.group(0)!.replaceAll("{[", "").replaceAll("]}", "");
      currentIndex = match.end;

      textSpans.add(
        TextSpan(
          text: textBeforeMatch,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
      );
      textSpans.add(
        WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: FillBlankBoxWidget(
              answer: matchedText,
              reset: reset,
              showAnswer: showAnswer,
              onDroppedOption: (value) {
                final isMatched = matchedText == value;
                onMatchedOption(isMatched);
              },
            ),
          ),
        ),
      );
    });

    if (currentIndex < questionText.length) {
      String textAfterLastMatch = questionText.substring(currentIndex);
      textSpans.add(TextSpan(
          text: textAfterLastMatch,
          style: const TextStyle(fontSize: 18, color: Colors.black)));
    }

    return textSpans;
  }
}
