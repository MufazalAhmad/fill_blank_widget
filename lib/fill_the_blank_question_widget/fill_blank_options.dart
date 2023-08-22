import 'package:flutter/material.dart';
import 'package:untitled/data.dart';

class FillBlanksOption extends StatefulWidget {
  final bool reset;
  final void Function(bool value) onChange;
  final List<String> questionOptions;
  const FillBlanksOption({
    super.key,
    required this.questionOptions,
    required this.reset,
    required this.onChange,
  });

  @override
  State<FillBlanksOption> createState() => _FillBlanksOptionState();
}

class _FillBlanksOptionState extends State<FillBlanksOption> {
  List<String> options = [];
  bool reset = false;
  @override
  void initState() {
    super.initState();

    options = widget.questionOptions;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.reset) {
      options = widget.questionOptions;
      widget.onChange(!reset);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < options.length; i++)
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
                data: options[i],
                feedback: Material(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    width: 100,
                    height: 30,
                    child: Center(child: Text(options[i])),
                  ),
                ),
                child: Material(
                  child: SizedBox(
                    width: 100,
                    height: 30,
                    child: Text(options[i]),
                  ),
                ),
                onDragCompleted: () {
                  setState(() {
                    options = options
                        .where((element) => element != options[i])
                        .toList();
                    print(questions);
                  });
                },
              ),
            ],
          )
      ],
    );
  }
}
