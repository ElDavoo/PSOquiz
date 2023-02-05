// Widget that shows a question and the answers

import 'package:flutter/material.dart';
import 'package:pso_quiz/question.dart';


class QuestionWidget extends StatelessWidget {
  final Question question;

  const QuestionWidget({super.key,
    required this.question,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(question.questionText),
        ...question.answers
            .asMap()
            .entries
            .map((entry) => QuizButton(
                  text: entry.value.answerText,
                  isCorrect: entry.value.isCorrect,
                ))
            .toList(),
      ],
    );
  }
}

class QuizButton extends StatefulWidget {
  final String text;
  final bool isCorrect;

  const QuizButton({super.key, required this.text, required this.isCorrect});

  @override
  State<StatefulWidget> createState() => _QuizButtonState();
}

class _QuizButtonState extends State<QuizButton> {
  bool _isPressed = false;

  @override void didUpdateWidget(covariant QuizButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      setState(() {
        _isPressed = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _isPressed = true;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: _isPressed ? (widget.isCorrect ? Colors.green : Colors.red) : Colors.blue,
      ),
      child: Text(widget.text),
    );
  }
}
