import 'package:flutter/material.dart';

import '../data.dart';
import 'fill_blank_question_widget.dart';

class Test1 extends StatefulWidget {
  const Test1({
    super.key,
    required this.title,
    required this.isTraining,
  });

  final String title;
  final bool isTraining;

  @override
  State<Test1> createState() => _Test1State();
}

class _Test1State extends State<Test1> {
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
                  child: SizedBox(
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
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          const SizedBox(height: 30),
          Expanded(
            child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  final question = questions[index];
                  return Column(
                    children: [
                      FillTheBlankQuestion(
                        isTraining: widget.isTraining,
                        question: question,
                        index: index,
                      ),
                      SizedBox(height: 20)
                    ],
                  );
                }),
          )
        ]),
      ),
    );
  }
}
