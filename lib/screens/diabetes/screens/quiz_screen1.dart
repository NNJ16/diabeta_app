import 'package:diabeta_app/components/constants.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:diabeta_app/screens/diabetes/components/q_card1.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';

import '../../../model/diabetes_questions.dart';
import '../../../services/diabates_predict_service.dart';

class QuizScreen1 extends StatefulWidget {
  const QuizScreen1({Key? key}) : super(key: key);

  @override
  State<QuizScreen1> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen1> {
  bool isLoading = false;

  void setResult()async{
    setState(() {
      isLoading = true;
    });
    String result = await DiabatesPredictService.getPrediabatesPrediction();
    print(result);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[100],
      appBar: AppBar(
        title: const Text("Prediabates Test"),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: !isLoading
          ? Container(
              height: 500,
              child: Swiper(
                loop: false,
                itemCount: DiabeticQuestions.sampleQuiz2.length,
                itemHeight: 400.0,
                itemWidth: 600,
                onIndexChanged: (index) {},
                layout: SwiperLayout.STACK,
                pagination: const SwiperPagination(),
                itemBuilder: (BuildContext context, int index) {
                  return QCard1(ques: DiabeticQuestions.sampleQuiz2[index], callBack: setResult);
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
