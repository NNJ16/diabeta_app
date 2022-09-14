import 'package:diabeta_app/components/constants.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:diabeta_app/screens/diabetes/components/q_card.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';

import '../../../model/diabetes_questions.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  bool isLoading = false;

  void setResult(){
    setState(() {
      isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[100],
      appBar: AppBar(
        title: const Text("Diabetes Prediction"),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: !isLoading
          ? Container(
              height: 500,
              child: Swiper(
                loop: false,
                itemCount: DiabeticQuestions.sampleQuiz1.length,
                itemHeight: 400.0,
                itemWidth: 600,
                onIndexChanged: (index) {},
                layout: SwiperLayout.STACK,
                pagination: const SwiperPagination(),
                itemBuilder: (BuildContext context, int index) {
                  return QCard(ques: DiabeticQuestions.sampleQuiz1[index], callBack: setResult);
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
