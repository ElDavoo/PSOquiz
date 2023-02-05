// Widget that shows a question and the answers

import 'package:flutter/material.dart';
import 'package:pso_quiz/question.dart';


class QuestionWidget extends StatelessWidget {
  final Question question;
  final Function(int) onAnswer;

  const QuestionWidget({super.key,
    required this.question,
    required this.onAnswer,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(question.questionText),
        ...question.answers
            .asMap()
            .entries
            .map((entry) => ElevatedButton(
                  onPressed: () => onAnswer(entry.key),
                  child: Text(entry.value.answerText),
                ))
            .toList(),
      ],
    );
  }
}