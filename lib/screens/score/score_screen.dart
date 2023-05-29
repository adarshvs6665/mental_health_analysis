import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mental_health_analysis/utils/constants.dart';
import 'package:mental_health_analysis/controllers/question_controller.dart';
import 'package:flutter_svg/svg.dart';

class ScoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    QuestionController _qnController = Get.put(QuestionController());
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset("assets/images/bg.svg", fit: BoxFit.fill),
          Column(
            children: [
              Spacer(flex: 3),
              Text(
                "Score",
                style: Theme.of(context)
                    .textTheme
                    .headline3
                    ?.copyWith(color: kSecondaryColor),
              ),
              Spacer(),
              Text(
                "${1 * 10}/${4 * 10}",
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    ?.copyWith(color: kSecondaryColor),
              ),
              Spacer(flex: 3),
            ],
          )
        ],
      ),
    );
  }
}
