// A widget that lets the user choose which quiz to play.
// List of checkboxes, one for each quiz.

import 'package:flutter/material.dart';
import 'package:pso_quiz/question.dart';

class QuizChooseWidget extends StatefulWidget {
  final List<Quiz> quizzes;
  final Function(List<Quiz>) onQuizSelected;

  const QuizChooseWidget({
    super.key,
    required this.quizzes,
    required this.onQuizSelected,
  });

  @override
  State<QuizChooseWidget> createState() => _QuizChooseWidgetState();
}

class _QuizChooseWidgetState extends State<QuizChooseWidget> {
  final _selectedQuizzes = <Quiz>[];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...widget.quizzes
            .asMap()
            .entries
            .map((entry) => CheckboxListTile(
                  title: Text(entry.value.name),
                  value: _selectedQuizzes.contains(entry.value),
                  onChanged: (value) {
                    setState(() {
                      if (value == true) {
                        _selectedQuizzes.add(entry.value);
                      } else {
                        _selectedQuizzes.remove(entry.value);
                      }
                    });
                  },
                ))
            .toList(),
        ElevatedButton(
          onPressed: () => widget.onQuizSelected(_selectedQuizzes),
          child: const Text("Play"),
        ),
      ],
    );
  }
}
