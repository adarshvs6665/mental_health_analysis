import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mental_health_analysis/models/Question.dart';
import 'package:mental_health_analysis/screens/score/score_screen.dart';

class QuestionController2 extends GetxController {
  late PageController pageController;
  final RxList<Question> questions = <Question>[].obs;
  final RxInt currentQuestionIndex = 1.obs;
  bool isAnswered = false;
  int selectedAns = -1;
  int totalScore = 0;
  int totalQuestions = 0;

  void setQuestions(List<Question> newQuestions) {
    questions.clear();
    questions.addAll(newQuestions);
    totalQuestions = newQuestions.length;
    currentQuestionIndex.value = 1;
    isAnswered = false;
    selectedAns = -1;
    totalScore = 0;
    pageController = PageController();
  }

  void selectOption(int index, int score) {
    selectedAns = index;
    totalScore = totalScore + score;
    update();
    if (currentQuestionIndex.value <= questions.length - 1) {
      isAnswered = true;
      Future.delayed(Duration(seconds: 1), () {
        currentQuestionIndex.value++;
        selectedAns = -1;
        pageController.nextPage(
            duration: Duration(milliseconds: 300), curve: Curves.ease);
      });
    } else {
      Future.delayed(Duration(seconds: 1), () {
        Get.to(ScoreScreen());
      });
    }
  }
}
