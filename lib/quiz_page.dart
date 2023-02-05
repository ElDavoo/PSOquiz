import 'package:flutter/material.dart';
import 'package:pso_quiz/question.dart';
import 'package:pso_quiz/question_widget.dart';

import 'constants.dart';

class QuizPage extends StatefulWidget {
  final List<Quiz> quizzes;

  const QuizPage({super.key, required this.quizzes});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final _questions = <Question>[];
  int _currentQuestionIndex = 0;
  int _score = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _questions.addAll(widget.quizzes.expand((quiz) => quiz.questions));
    _questions.shuffle();
  }

  // Put every question in a pageview and use controller to navigate between them
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(C.appName)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text("${C.points}:$_score", style: const TextStyle(fontSize: 20)),
            Text(
                "${C.question} ${_currentQuestionIndex + 1}/${_questions.length}",
                style: const TextStyle(fontSize: 20)),
            const Padding(padding: EdgeInsets.all(8.0)),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _questions.length,
                itemBuilder: (context, index) {
                  return QuestionWidget(
                    question: _questions[index],
                    onAnswer: (answer) {
                      setState(() {
                        answer ? _score++ : _score--;
                      });
                    },
                  );
                },
                onPageChanged: (index) {
                  setState(() {
                    _currentQuestionIndex = index;
                  });
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_currentQuestionIndex < _questions.length - 1) {
            setState(() {
              _currentQuestionIndex++;
              _pageController.animateToPage(
                _currentQuestionIndex,
                duration: const Duration(milliseconds: 100),
                curve: Curves.ease,
              );
            });
          } else {
            Navigator.pop(context, _score);
          }
        },
        child: (_currentQuestionIndex < _questions.length - 1)
            ? const Icon(Icons.arrow_forward)
            : const Icon(Icons.check),
      ),
    );
  }
}
