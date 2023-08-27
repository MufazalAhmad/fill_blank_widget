import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:untitled/data.dart';

class FillBlanksOption extends StatelessWidget {
  final bool reset;
  final void Function(String value) onDragComplete;
  final List<String> questionOptions;
  const FillBlanksOption({
    super.key,
    required this.questionOptions,
    required this.reset,
    required this.onDragComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < questionOptions.length; i++)
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
                child: Text(
                  "${i + 1})",
                ),
              ),
              const SizedBox(width: 10),
              Draggable(
                data: questionOptions[i],
                feedback: Material(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    width: 100,
                    height: 30,
                    child: Center(child: Text(questionOptions[i])),
                  ),
                ),
                child: Material(
                  child: SizedBox(
                    width: 100,
                    height: 30,
                    child: Text(questionOptions[i]),
                  ),
                ),
                onDragCompleted: () {
                  onDragComplete(questionOptions[i]);
                },
              ),
            ],
          )
      ],
    );
  }
}
