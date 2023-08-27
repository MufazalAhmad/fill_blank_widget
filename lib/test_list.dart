import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/main.dart';
import 'package:untitled/provider/fill_blanks_question_provider.dart';

import 'fill_the_blank_question_widget/fill_blank_questions_list.dart';

class TestList extends ConsumerWidget {
  const TestList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Tests"),
        centerTitle: false,
      ),
      body: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              InkWell(
                onTap: () {
                  ref.read(showAllAnswer.notifier).state = false;

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Test1(
                                title: "Training Test",
                                isTraining: false,
                              )));
                },
                child: Container(
                  height: 55,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.deepPurpleAccent.withOpacity(0.2),
                  ),
                  child: const Text("Seru Mock Test"),
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  ref.read(showAllAnswer.notifier).state = false;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Test1(
                                title: "Training Test",
                                isTraining: true,
                              )));
                },
                child: Container(
                  height: 55,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.deepPurpleAccent.withOpacity(0.2),
                  ),
                  child: const Text("Seru training Test"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
