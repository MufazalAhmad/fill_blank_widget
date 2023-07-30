import 'package:flutter/material.dart';

class DynamicMCQQuestion extends StatelessWidget {
  final String questionText;
  final List<String> answerChoices;
  final Function(int) onAnswerSelected;

  DynamicMCQQuestion({
    required this.questionText,
    required this.answerChoices,
    required this.onAnswerSelected,
  });

  @override
  Widget build(BuildContext context) {
    final placeholderPattern = RegExp(r'\${(\[\w+\])}');
    final matches = placeholderPattern.allMatches(questionText);

    List<InlineSpan> questionSpans = [];
    int index = 0;

    for (var match in matches) {
      final placeholder =
          match.group(1); // Extract the placeholder content (e.g., "[my]")
      final prefix = questionText.substring(index, match.start);
      questionSpans.add(TextSpan(text: prefix));

      questionSpans.add(WidgetSpan(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            placeholder!,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ));

      index = match.end;
    }

    final remainingText = questionText.substring(index);
    questionSpans.add(TextSpan(text: remainingText));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.black, fontSize: 16),
              children: questionSpans,
            ),
          ),
        ),
        SizedBox(height: 10),
        for (int i = 0; i < answerChoices.length; i++)
          ListTile(
            onTap: () => onAnswerSelected(i),
            title: Text(answerChoices[i]),
            leading: Radio<int>(
              value: i,
              groupValue:
                  -1, // You can use a real group value if you're managing selected answers
              onChanged: (_) {},
            ),
          ),
      ],
    );
  }
}
