
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
      appBar: AppBar(
        title: const Text("PSOQuiz"),
      ),
      body: Column(
      children:[
      const Text("Score:"),
      Text(_score.toString()),
      const Text("Question:"),
      Text("${_currentQuestionIndex + 1}/${_questions.length}"),
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
        ),
      ),
      ],),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_currentQuestionIndex < _questions.length - 1) {
            setState(() {
              _currentQuestionIndex++;
              _pageController.animateToPage(
                _currentQuestionIndex,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn,
              );
            });
          } else {
            Navigator.pop(context, _score);
          }
        },
        child: (_currentQuestionIndex < _questions.length - 1) ?
          const Icon(Icons.arrow_forward)
        :
          const Icon(Icons.check),
      ),
    );
  }
}