import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/provider/fill_blanks_question_provider.dart';

class FillBlankBoxWidget extends ConsumerStatefulWidget {
  final String answer;
  final bool reset;
  final int id;
  final bool showAnswer;

  final void Function(String) onDroppedOption;
  const FillBlankBoxWidget({
    super.key,
    required this.showAnswer,
    required this.id,
    required this.answer,
    required this.reset,
    required this.onDroppedOption,
  });

  @override
  ConsumerState<FillBlankBoxWidget> createState() => _FillBlankBoxWidgetState();
}

class _FillBlankBoxWidgetState extends ConsumerState<FillBlankBoxWidget> {
  String? droppedOption;

  @override
  void initState() {
    super.initState();
  }

  bool showAnswerAndCheckItsCorrect() {
    if (widget.showAnswer &&
        droppedOption != null &&
        (widget.answer != droppedOption)) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.reset) {
      droppedOption = "";
    }
    return DragTarget<String>(
      builder: (context, candidateData, rejectedData) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 100,
              height: 30,
              decoration: BoxDecoration(
                color: !widget.showAnswer
                    ? Colors.grey.withOpacity(0.2)
                    : showAnswerAndCheckItsCorrect()
                        ? Colors.red.withOpacity(0.5)
                        : Colors.green.withOpacity(0.2),
                border: Border.all(color: Colors.blue),
              ),
              child: Center(
                child: Text(
                  droppedOption ?? "",
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),

            /// [show answer if selected answer is false]
            const SizedBox(width: 5),

            if (showAnswerAndCheckItsCorrect())
              Container(
                alignment: Alignment.centerLeft,
                width: 100,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.2),
                  border: Border.all(color: Colors.green),
                ),
                child: Center(child: Text(widget.answer)),
              )
          ],
        );
      },
      onWillAccept: (data) {
        if (droppedOption != null && (droppedOption?.isNotEmpty ?? false)) {
          return false;
        }
        if (widget.reset) {
          ref.read(fillBlanksQuestionProvider.notifier).reset(widget.id);
        }
        return true;
      },
      onAccept: (data) {
        widget.onDroppedOption(data);
        droppedOption = data;

        setState(() {});
      },
      onLeave: (data) {},
    );
  }
}
