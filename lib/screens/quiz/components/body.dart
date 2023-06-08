import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mental_health_analysis/controllers/questionController.dart';
import 'package:mental_health_analysis/utils/constants.dart';
import 'package:mental_health_analysis/models/Question.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'question_card.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late QuestionController2 questionController;
  List<Question> questionsLocal = [];

  @override
  void initState() {
    print("init");

    setState(() {
      questionController = Get.put(QuestionController2());
    });
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
        // print(data);
        // Map the dynamic objects to Question objects
        final List<Question> fetchedQuestions = data.map((item) {
          return Question(
            id: item['id'],
            question: item['question'],
            options: List<String>.from(item['options']),
            score: List<int>.from(item['score']),
          );
        }).toList();

        setState(() {
          questionsLocal = fetchedQuestions;
        });
        // _questionController.setQuestions(fetchedQuestions);
        questionController.setQuestions(fetchedQuestions);
      } else {
        // Handle API error
      }
    } catch (e) {
      // Handle exception/error
      print(e);
    }
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
              const SizedBox(height: kDefaultPadding),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Obx(
                  () => Text.rich(
                    TextSpan(
                      text:
                          "Question ${questionController.currentQuestionIndex}",
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
              ),
              const Divider(thickness: 1.5),
              const SizedBox(height: kDefaultPadding),
              Expanded(
                child: PageView.builder(
                  // Block swipe to next qn
                  physics: const NeverScrollableScrollPhysics(),
                  controller: questionController.pageController,
                  // onPageChanged: questionController.updateTheQnNum,
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
