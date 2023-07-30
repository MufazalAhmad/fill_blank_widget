import 'package:flutter/material.dart';
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // DynamicMCQQuestion(
            //   questionText:
            //       "This is \${[my]} school. This \${[school]} has four rooms.",
            //   answerChoices: ["my", "is", "school", "cow"],
            //   onAnswerSelected: (int selectedAnswer) {
            //     // Do something with the selected answer
            //   },
            // ),
            MCQQuestion(
              question:
                  '6.If your {[help]} is ill, or has a disability, and asks you to help them enter or leave your vehicle, make sure you check exactly what {[arm]} they are asking you for, for example to take hold of your{[passenger]}to support them.  ',
              options: const ['Help', 'Arm', 'Passenger'],
              onOptionSelected: (selectedOption) {
                // Handle the selected option
                print('Selected option: $selectedOption');
              },
            )

            // Add more DynamicMCQWidget widgets as needed for other questions
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
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
            style: DefaultTextStyle.of(context).style,
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

      textSpans.add(TextSpan(text: textBeforeMatch));
      textSpans.add(
        const WidgetSpan(
          alignment: PlaceholderAlignment.bottom,
          child: FillBlankWidget(),
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
          .map((option) => Draggable(
                data: option,
                feedback: Material(
                  child: Container(
                    width: 100,
                    height: 30,
                    color: Colors.blue,
                    child: Center(child: Text(option)),
                  ),
                ),
                child: Material(
                  child: Container(
                    width: 100,
                    height: 30,
                    color: Colors.blue,
                    child: Center(child: Text(option)),
                  ),
                ),
                childWhenDragging: Container(),
              ))
          .toList(),
    );
  }
}

class FillBlankWidget extends StatefulWidget {
  const FillBlankWidget({super.key});

  @override
  State<FillBlankWidget> createState() => _FillBlankWidgetState();
}

class _FillBlankWidgetState extends State<FillBlankWidget> {
  String? droppedOption;

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
