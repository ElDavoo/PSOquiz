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
  // add a timer
  final Stopwatch _stopwatch = Stopwatch();
  // add a stream of Duration that takes the value from _stopwatch every second
  late final Stream<Duration> _timerStream;


  @override
  void initState() {
    super.initState();
    _questions.addAll(widget.quizzes.expand((quiz) => quiz.questions));
    _questions.shuffle();
    // shuffle all the answers
    for (var question in _questions) {
      question.answers.shuffle();
    }
    // start the timer
    _stopwatch.start();
    _timerStream = Stream.periodic(const Duration(seconds: 1), (x) => x)
        .map((event) => _stopwatch.elapsed);
  }

  // Put every question in a pageview and use controller to navigate between them
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Get current question and get quiz title
          title: Text(_questions[_currentQuestionIndex].quizName)
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text("${C.points}: $_score", style: const TextStyle(fontSize: 20)),
            Text(
                "${C.question} ${_currentQuestionIndex + 1}/${_questions.length}",
                style: const TextStyle(fontSize: 20)),
            const Padding(padding: EdgeInsets.all(8.0)),
            // Add a stream builder to show the timer
            StreamBuilder<Duration>(
              stream: _timerStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final duration = snapshot.data!;
                  // Pad in a nice way
                  final minutes = duration.inMinutes.toString().padLeft(2, '0');
                  final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
                  return Text("Tempo: $minutes:$seconds", style: const TextStyle(fontSize: 20));
                } else {
                  return const Text("Tempo: 00:00", style: TextStyle(fontSize: 20));
                }
              },
            ),
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
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
      children:[
      FloatingActionButton(
        heroTag: "back",
        onPressed: () {
          if (_currentQuestionIndex > 0) {
            setState(() {
              _currentQuestionIndex--;
              _pageController.animateToPage(
                _currentQuestionIndex,
                duration: const Duration(milliseconds: 100),
                curve: Curves.ease,
              );
            });
          }
        },
        child: const Icon(Icons.arrow_back),
      ),
      const Padding(padding: EdgeInsets.all(8.0)),
      FloatingActionButton(
        heroTag: "next",
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
    ],
    ),);
  }
}
