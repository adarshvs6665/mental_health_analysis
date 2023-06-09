import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:mental_health_analysis/models/Question.dart';
import 'package:mental_health_analysis/screens/score/score_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mental_health_analysis/utils/constants.dart';

class QuestionController extends GetxController
    with SingleGetTickerProviderMixin {
  late AnimationController _animationController;
  late Animation _animation;
  Animation get animation => this._animation;

  late PageController _pageController;
  PageController get pageController => this._pageController;

  var questionsList = [].obs;
  List chosenAnswersList = [].obs;

  bool _isAnswered = false;
  bool get isAnswered => this._isAnswered;

  late int _selectedAns;
  int get selectedAns => this._selectedAns;

  RxInt _questionNumber = 1.obs;
  RxInt get questionNumber => this._questionNumber;

  @override
  void onInit() {
    super.onInit();

    _animationController = AnimationController(
      duration: Duration(seconds: 60),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        update();
      });

    _pageController = PageController();

    _animationController.forward().whenComplete(nextQuestion);
  }

  @override
  void onClose() {
    // _animationController.dispose();
    // _pageController.dispose();
    super.onClose();
  }

  void setQuestions(List<Question> questions) {
    questionsList.value = questions;
  }

  void checkAns(Question question, int selectedIndex) {
    _isAnswered = true;
    _selectedAns = selectedIndex;
    _animationController.stop();
    update();
    chosenAnswersList.add(selectedIndex);
    Future.delayed(Duration(seconds: 1), () {
      nextQuestion();
    });
    pageController.nextPage(
        duration: Duration(milliseconds: 300), curve: Curves.ease);
  }

  void nextQuestion() {
    if (_questionNumber.value != questionsList.length) {
      _isAnswered = false;
      _pageController.nextPage(
        duration: Duration(milliseconds: 250),
        curve: Curves.ease,
      );

      _animationController.reset();
      _animationController.forward().whenComplete(nextQuestion);
    } else {
      _questionNumber.value = 1;
      _isAnswered = false;
      _animationController.stop();
      Get.to(ScoreScreen());
    }
  }

  void updateTheQnNum(int index) {
    _questionNumber.value = index + 1;
  }
}
