import 'package:diabeta_app/components/constants.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:diabeta_app/model/health_ques_ans.dart';
import 'package:diabeta_app/screens/diabetes/components/q_card.dart';
import 'package:diabeta_app/screens/diabetes/components/q_card_health1.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';

import '../../model/diabetes_ques_ans.dart';
import '../../services/health_predict_service.dart';

class EyeRiskScreen extends StatefulWidget {
  const EyeRiskScreen({Key? key}) : super(key: key);

  @override
  State<EyeRiskScreen> createState() => _EyeRiskScreenState();
}

class _EyeRiskScreenState extends State<EyeRiskScreen> {
  bool isLoading = false;

  void setResult(){
    var result = HealthPredictService.getEyePrediction();
    print(result);
    setState(() {
      isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[100],
      appBar: AppBar(
        title: const Text("Eye Risk Prediction"),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: !isLoading
          ? Container(
              height: 500,
              child: Swiper(
                loop: false,
                itemCount: HealthQuestions.eyeQuiz.length,
                itemHeight: 400.0,
                itemWidth: 600,
                onIndexChanged: (index) {},
                layout: SwiperLayout.STACK,
                pagination: const SwiperPagination(),
                itemBuilder: (BuildContext context, int index) {
                  return QHealth1Card(ques: HealthQuestions.eyeQuiz[index], callBack: setResult);
                },
              ),
            )
          : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoadingFlipping.circle(
                  borderColor: kPrimaryColor,
                  // borderSize: 3.0,
                  size: 60.0,
                  backgroundColor: kPrimaryColor,
                  duration: const Duration(milliseconds: 2000),
                ),
              const SizedBox(
                height: 8,
              ),
              const Text('Loading result...')
            ],
          ),
    );
  }
}
