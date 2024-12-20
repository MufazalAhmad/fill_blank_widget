import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/provider/fill_blanks_question_provider.dart';

import '../data.dart';
import 'fill_blank_question_widget.dart';

class Test1 extends ConsumerStatefulWidget {
  Test1({
    super.key,
    required this.title,
    required this.isTraining,
  });

  final String title;
  final bool isTraining;

  @override
  ConsumerState<Test1> createState() => _Test1State();
}

class _Test1State extends ConsumerState<Test1> {
  int index = -1;

  final PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(""),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              final result = ref.read(getResultProvider.notifier).state;
              ref.read(showAllAnswer.notifier).state = true;
              showDialog(
                context: context,
                builder: (context) => Dialog(
                  child: SizedBox(
                    height: 200,
                    width: 200,
                    child:
                        Center(child: Text("${result} / ${questions.length}")),
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
          Consumer(builder: (context, ref, child) {
            final questions = ref.watch(fillBlanksQuestionProvider);
            return Expanded(
              child: PageView(
                controller: pageController,
                children: questions.map((e) {
                  index++;
                  final question = e;
                  return FillTheBlankQuestion(
                    isTraining: widget.isTraining,
                    question: question,
                    index: index,
                  );
                }).toList(),
              ),
            );
          })
        ]),
      ),
    );
  }
}
