// Widget that shows a question and the answers

import 'package:flutter/material.dart';
import 'package:pso_quiz/question.dart';

class QuestionWidget extends StatelessWidget {
  final Question question;
  final Function(bool) onAnswer;

  const QuestionWidget(
      {super.key, required this.question, required this.onAnswer});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(question.questionText, style: const TextStyle(fontSize: 20)),
          ...question.answers
              .asMap()
              .entries
              .map((entry) => QuizButton(
                    text: entry.value.answerText,
                    isCorrect: entry.value.isCorrect,
                    onAnswer: onAnswer,
                  ))
              .toList(),

        ],
      ),
    );
  }
}

class QuizButton extends StatefulWidget {
  final String text;
  final bool isCorrect;
  final Function(bool) onAnswer;

  const QuizButton(
      {super.key,
      required this.text,
      required this.isCorrect,
      required this.onAnswer});

  @override
  State<StatefulWidget> createState() => _QuizButtonState();
}

class _QuizButtonState extends State<QuizButton>
    with AutomaticKeepAliveClientMixin {
  bool _isPressed = false;

  @override
  void didUpdateWidget(covariant QuizButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      setState(() {
        _isPressed = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          if (_isPressed) {
            return;
          }
          setState(() {
            _isPressed = true;
          });
          widget.onAnswer(widget.isCorrect);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: _isPressed
              ? (widget.isCorrect ? Colors.green : Colors.red)
              : Colors.blue,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(widget.text,
                style: const TextStyle(fontSize: 18, color: Colors.white)

      ),
          ),
        ),),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
