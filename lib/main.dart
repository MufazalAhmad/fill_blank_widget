import 'package:flutter/material.dart';
import 'package:untitled/data.dart';
import 'package:untitled/question.dart';

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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          const SizedBox(height: 30),
          ...questions
              .map((e) => MCQQuestion(
                    question: e.text ?? "",
                    options: e.option ?? [],
                    onOptionSelected: (selectedOption) {
                      // Handle the selected option
                      print('Selected option: $selectedOption');
                    },
                  ))
              .toList(),
        ]

            // Add more DynamicMCQWidget widgets as needed for other questions
            ),
      ),
    );
  }
}

class MCQQuestion extends StatefulWidget {
  final String question;
  final List<String> options;
  final void Function(String) onOptionSelected;

  MCQQuestion({
    required this.question,
    required this.options,
    required this.onOptionSelected,
  });

  @override
  State<MCQQuestion> createState() => _MCQQuestionState();
}

class _MCQQuestionState extends State<MCQQuestion> {
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
        _buildOptions(),
      ],
    );
  }

  List<InlineSpan> _buildQuestionTextSpans() {
    List<InlineSpan> textSpans = [];
    final pattern = RegExp(r"{\[.*?\]}");

    int currentIndex = 0;
    pattern.allMatches(widget.question).forEach((match) {
      String textBeforeMatch =
          widget.question.substring(currentIndex, match.start);
      String matchedText =
          match.group(0)!.replaceAll("{[", "").replaceAll("]}", "");
      currentIndex = match.end;

      textSpans.add(
        TextSpan(
          text: textBeforeMatch,
          style: const TextStyle(color: Colors.black),
        ),
      );
      textSpans.add(
        WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: FillBlankWidget(
            answer: matchedText,
          ),
        ),
      );
    });

    if (currentIndex < widget.question.length) {
      String textAfterLastMatch = widget.question.substring(currentIndex);
      textSpans.add(TextSpan(text: textAfterLastMatch));
    }

    return textSpans;
  }

  Widget _buildOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.options
          .map((option) => Row(
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
                    childWhenDragging: Container(),
                    child: Material(
                      child: SizedBox(
                        width: 100,
                        height: 30,
                        child: Text(option),
                      ),
                    ),
                  ),
                ],
              ))
          .toList(),
    );
  }
}

class FillBlankWidget extends StatefulWidget {
  final String answer;
  const FillBlankWidget({
    super.key,
    required this.answer,
  });

  @override
  State<FillBlankWidget> createState() => _FillBlankWidgetState();
}

class _FillBlankWidgetState extends State<FillBlankWidget> {
  String? droppedOption;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget<String>(
      builder: (context, candidateData, rejectedData) {
        return Container(
          width: 100,
          height: 30,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue),
          ),
          child: Center(
            child: Text(
              droppedOption ?? "",
              style: TextStyle(color: Colors.blue),
            ),
          ),
        );
      },
      onWillAccept: (data) {
        return true;
      },
      onAccept: (data) {
        setState(() {
          droppedOption = data;
        });
      },
      onLeave: (data) {},
    );
  }
}
