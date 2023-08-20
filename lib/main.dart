import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:untitled/data.dart';

import 'fill_blank_question.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Test1'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              final result = questions
                  .where((element) =>
                      element.isCorrect != null && element.isCorrect == true)
                  .toList();

              showDialog(
                context: context,
                builder: (context) => Dialog(
                  child: Container(
                    height: 200,
                    width: 200,
                    child: Center(
                        child: Text("${result.length} / ${questions.length}")),
                  ),
                ),
              );
            },
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            const SizedBox(height: 30),
            for (int i = 0; i < questions.length; i++)
              FillTheBlankQuestion(
                question: questions[i],
                index: i,
                onOptionSelected: (selectedOption) {
                  // Handle the selected option
                  print('Selected option: $selectedOption');
                },
              ),
          ]),
        ),
      ),
    );
  }
}

class FillTheBlankQuestion extends StatefulWidget {
  final FillBlankQuestion question;
  final int index;
  final void Function(String) onOptionSelected;

  const FillTheBlankQuestion({
    super.key,
    required this.question,
    required this.index,
    required this.onOptionSelected,
  });

  @override
  State<FillTheBlankQuestion> createState() => _FillTheBlankQuestionState();
}

class _FillTheBlankQuestionState extends State<FillTheBlankQuestion> {
  bool showAnswer = false;

  List<bool> fillBlanksAnswers = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: _buildQuestionTextSpans(),
          ),
        ),
        const SizedBox(height: 20),

        /// [fill the blank options]
        FillBlanksOption(options: widget.question.options),
        Align(
          alignment: Alignment.centerRight,

          /// [check question answer]
          child: FloatingActionButton(
            onPressed: () {
              setState(() {
                showAnswer = true;
              });
            },
            child: const Icon(Icons.check),
          ),
        )
      ],
    );
  }

  List<InlineSpan> _buildQuestionTextSpans() {
    List<InlineSpan> textSpans = [];

    TextSpan textSpan = TextSpan();

    final pattern = RegExp(r"{\[.*?\]}");

    int currentIndex = 0;
    pattern.allMatches(widget.question.text).forEach((match) {
      String textBeforeMatch =
          widget.question.text.substring(currentIndex, match.start);
      String matchedText =
          match.group(0)!.replaceAll("{[", "").replaceAll("]}", "");
      currentIndex = match.end;

      textSpans.add(
        TextSpan(
          text: textBeforeMatch,
          style: const TextStyle(color: Colors.black, fontSize: 18),
        ),
      );
      textSpans.add(
        WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: FillBlankBoxWidget(
            answer: matchedText,
            showAnswer: showAnswer,
            onDroppedOption: (value) {
              if (matchedText == value) {
                fillBlanksAnswers.add(true);
              } else {
                fillBlanksAnswers.add(false);
              }

              if (fillBlanksAnswers.length == 3) {
                final isCorrect = fillBlanksAnswers.toSet();
                if (isCorrect.length == 1 && isCorrect.first == true) {
                  questions[widget.index] =
                      widget.question.copyWith(isCorrect: true);
                }
              }
            },
          ),
        ),
      );
    });

    if (currentIndex < widget.question.text.length) {
      String textAfterLastMatch = widget.question.text.substring(currentIndex);
      textSpans.add(TextSpan(text: textAfterLastMatch));
    }

    return textSpans;
  }
}

class FillBlanksOption extends StatefulWidget {
  final List<String> options;
  const FillBlanksOption({
    super.key,
    required this.options,
  });

  @override
  State<FillBlanksOption> createState() => _FillBlanksOptionState();
}

class _FillBlanksOptionState extends State<FillBlanksOption> {
  List<String> options = [];
  @override
  void initState() {
    super.initState();

    options = widget.options;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: options
          .map(
            (option) => Row(
              children: [
                const SizedBox(width: 20),
                Draggable(
                  data: option,
                  feedback: Material(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      width: 100,
                      height: 30,
                      child: Text(option),
                    ),
                  ),
                  childWhenDragging: Material(
                    child: SizedBox(
                      width: 100,
                      height: 30,
                      child: Center(
                        child: Text(option),
                      ),
                    ),
                  ),
                  child: Material(
                    child: SizedBox(
                      width: 100,
                      height: 30,
                      child: Text(option),
                    ),
                  ),
                  onDragCompleted: () {
                    setState(() {
                      options = options
                          .where((element) => element != option)
                          .toList();
                    });
                  },
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}

class FillBlankBoxWidget extends StatefulWidget {
  final String answer;
  final bool showAnswer;

  final void Function(String) onDroppedOption;
  const FillBlankBoxWidget({
    super.key,
    required this.showAnswer,
    required this.answer,
    required this.onDroppedOption,
  });

  @override
  State<FillBlankBoxWidget> createState() => _FillBlankBoxWidgetState();
}

class _FillBlankBoxWidgetState extends State<FillBlankBoxWidget> {
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
    return DragTarget<String>(
      builder: (context, candidateData, rejectedData) {
        return Row(
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

            if (showAnswerAndCheckItsCorrect())
              Container(
                alignment: Alignment.centerLeft,
                width: 100,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.2),
                  border: Border.all(color: Colors.green),
                ),
                child: Center(
                  child: Text(widget.answer),
                ),
              )
          ],
        );
      },
      onWillAccept: (data) {
        return true;
      },
      onAccept: (data) {
        widget.onDroppedOption(data);
        setState(() {
          droppedOption = data;
        });
      },
      onLeave: (data) {},
    );
  }
}
