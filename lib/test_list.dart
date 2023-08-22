import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/main.dart';

import 'fill_the_blank_question_widget/fill_blank_questions_list.dart';

class TestList extends StatelessWidget {
  const TestList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Tests"),
        centerTitle: false,
      ),
      body: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              InkWell(
                onTap: () {
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
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.deepPurpleAccent.withOpacity(0.2),
                  ),
                  child: Text("Seru Mock Test"),
                ),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () {
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
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.deepPurpleAccent.withOpacity(0.2),
                  ),
                  child: Text("Seru training Test"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
