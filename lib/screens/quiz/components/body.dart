import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mental_health_analysis/utils/constants.dart';
import 'package:mental_health_analysis/controllers/question_controller.dart';
import 'package:mental_health_analysis/models/Questions.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'progress_bar.dart';
import 'question_card.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late QuestionController _questionController;
  List<Question> questionsLocal = [];

  @override
  void initState() {
    _questionController = Get.put(QuestionController());
    fetchQuestions();
    super.initState();
  }

  void fetchQuestions() async {
    String url = '${baseUrl}/fetch-analysis-questions';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final List<dynamic> data = responseData['data'];
        List<Question> fetchedQuestions = data
            .map(
              (question) => Question(
                id: question['id'],
                question: question['question'],
                options: List<String>.from(question['options']),
              ),
            )
            .toList();

        setState(() {
          questionsLocal = fetchedQuestions;
        });
        _questionController.setQuestions(fetchedQuestions);
      } else {
        // Handle API error
      }
    } catch (e) {
      // Handle exception/error
    }
  }

  @override
  void dispose() {
    _questionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset("assets/images/bg.svg", fit: BoxFit.fill),
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: ProgressBar(),
              ),
              const SizedBox(height: kDefaultPadding),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Text.rich(
                  TextSpan(
                    text:
                        "Question ${_questionController.questionNumber.value}",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(color: kSecondaryColor),
                    children: [
                      TextSpan(
                        text: "/${questionsLocal.length}",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(color: kSecondaryColor),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(thickness: 1.5),
              const SizedBox(height: kDefaultPadding),
              Expanded(
                child: PageView.builder(
                  // Block swipe to next qn
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _questionController.pageController,
                  onPageChanged: _questionController.updateTheQnNum,
                  itemCount: questionsLocal.length,
                  itemBuilder: (context, index) =>
                      QuestionCard(question: questionsLocal[index]),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
