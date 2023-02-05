import 'package:flutter/material.dart';
import 'package:pso_quiz/question.dart';
import 'package:pso_quiz/question_widget.dart';
import 'package:pso_quiz/quiz_choose_widget.dart';
import 'package:pso_quiz/quiz_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PSOQuiz"),
      ),
      body:
          FutureBuilder(builder:
            (context, snapshot) {
              if (snapshot.hasData) {
                return QuizChooseWidget(
                  quizzes: snapshot.data as List<Quiz>,
                  onQuizSelected: (quizzes) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuizPage(
                          quizzes: quizzes,
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
            future: loadQuiz(),
          ),
    );
  }
}
