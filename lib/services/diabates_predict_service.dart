import 'dart:convert';
import 'package:diabeta_app/model/diabetes_questions.dart';
import 'package:dio/dio.dart';

class DiabatesPredictService {
  static String api_url = "https://diabeta-backend.herokuapp.com";

  static Future<String> getPrediabatesPrediction() async {
    var data = {
      "Age": DiabeticQuestions.sampleQuiz2[0].defaultValue,
      "Gender": DiabeticQuestions.sampleQuiz2[1].defaultValue,
      "Polyuria": DiabeticQuestions.sampleQuiz2[2].defaultValue,
      "Polydipsia": DiabeticQuestions.sampleQuiz2[3].defaultValue,
      "SuddenWeightLoss": DiabeticQuestions.sampleQuiz2[5].defaultValue,
      "Irritability": DiabeticQuestions.sampleQuiz2[6].defaultValue,
      "DelayedHealing": DiabeticQuestions.sampleQuiz2[7].defaultValue,
      "PartialParesis": DiabeticQuestions.sampleQuiz2[4].defaultValue,
      "Alopecia": DiabeticQuestions.sampleQuiz2[8].defaultValue,
      "VisualBlurring": DiabeticQuestions.sampleQuiz2[9].defaultValue
    };

    var response = await Dio().post(api_url + "/diabetes/predict",
        options: Options(
          headers: {"Content-Type": "application/json"},
        ),
        data: jsonEncode(data));
    return response.data;
  }
}
