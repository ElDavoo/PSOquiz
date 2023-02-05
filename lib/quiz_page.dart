
import 'package:flutter/material.dart';
import 'package:pso_quiz/question.dart';
import 'package:pso_quiz/question_widget.dart';
import 'package:pso_quiz/quiz_choose_widget.dart';

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

  @override
  void initState() {
    super.initState();
    _questions.addAll(widget.quizzes.expand((quiz) => quiz.questions));
    _questions.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PSOQuiz"),
      ),
      body: _questions.isEmpty
          ? const Center(
              child: Text("No questions"),
            )
          : QuestionWidget(
              question: _questions[_currentQuestionIndex],
              onAnswer: (answerIndex) {
                if (_questions[_currentQuestionIndex].answers[answerIndex].isCorrect) {
                  _score++;
                }
                setState(() {
                  _currentQuestionIndex++;
                });
              },
            ),
    );
  }
}