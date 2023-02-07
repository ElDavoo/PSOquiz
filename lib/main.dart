import 'package:flutter/material.dart';
import 'package:pso_quiz/question.dart';
import 'package:pso_quiz/quiz_choose_widget.dart';
import 'package:pso_quiz/quiz_page.dart';

import 'constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const MyHomePage(),
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
        title: Text(C.appName),
      ),
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: QuizChooseWidget(
                quizzes: snapshot.data as List<Quiz>,
                onQuizSelected: (quizzes) {
                  if (quizzes.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(C.chooseSomethingText),
                      ),
                    );
                    return;
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizPage(
                        quizzes: quizzes,
                      ),
                    ),
                  );
                },
              ),
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
