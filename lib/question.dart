// A Dart class that implements a question.
// A question is made up of a question text and a list of answers.
//

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:pso_quiz/constants.dart';

class Question {
  final String quizName;
  final String questionText;
  final List<Answer> answers;

  // named constructor
  Question({required this.quizName, required this.questionText, required this.answers});
}

// A Dart class that implements an answer.
// An answer is made up of an answer text and a boolean value that indicates
// whether the answer is correct or not.

class Answer {
  final String answerText;
  final bool isCorrect;

  // named constructor
  Answer({required this.answerText, required this.isCorrect});
}

// A Dart class that implements a quiz.
// A quiz is made up of a name and a list of questions.

class Quiz {
  final String name;
  final List<Question> questions;

  // named constructor
  Quiz({required this.name, required this.questions});
}

// Method to load a quiz from a JSON file.
// The JSON file is located in the assets folder.
// The JSON file contains a list of quizzes.
// Each quiz contains a name and a list of questions.

Future<List<Quiz>> loadQuiz() async {
  // Load the JSON file from the assets folder
  final jsonString = await rootBundle.loadString(C.jsonFile);

  // Decode the JSON string into a map
  final jsonMap = json.decode(jsonString) as Map<String, dynamic>;

  // Get the list of quizzes from the map
  final jsonQuizzes = jsonMap[C.jsonKeyQuizzes] as List<dynamic>;

  // Create a list of quizzes
  final quizzes = <Quiz>[];

  // Loop through the list of quizzes
  for (final jsonQuiz in jsonQuizzes) {
    // Get the name of the quiz
    final name = jsonQuiz[C.jsonKeyName] as String;

    // Get the list of questions from the quiz
    final jsonQuestions = jsonQuiz[C.jsonKeyQuestions] as List<dynamic>;

    // Create a list of questions
    final questions = <Question>[];

    // Loop through the list of questions
    for (final jsonQuestion in jsonQuestions) {
      // Get the question text
      final questionText = jsonQuestion[C.jsonKeyQuestionText] as String;

      // Get the list of answers from the question
      final jsonAnswers = jsonQuestion[C.jsonKeyAnswers] as List<dynamic>;

      // Create a list of answers
      final answers = <Answer>[];

      // Loop through the list of answers
      for (final jsonAnswer in jsonAnswers) {
        // Get the answer text
        final answerText = jsonAnswer[C.jsonKeyAnswerText] as String;

        // Get the boolean value that indicates whether the answer is correct or not
        final isCorrect = jsonAnswer[C.jsonKeyIsCorrect] as bool;

        // Create an answer
        final answer = Answer(answerText: answerText, isCorrect: isCorrect);

        // Add the answer to the list of answers
        answers.add(answer);
      }

      // Create a question
      final question = Question(
          quizName: name,
          questionText: questionText,
          answers: answers);

      // Add the question to the list of questions
      questions.add(question);
    }

    // Create a quiz
    final quiz = Quiz(name: name, questions: questions);

    // Add the quiz to the list of quizzes
    quizzes.add(quiz);
  }

  // Return the list of quizzes
  return quizzes;
}
