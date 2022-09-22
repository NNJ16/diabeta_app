import 'dart:convert';
import 'package:diabeta_app/model/diabetes_ques_ans.dart';
import 'package:diabeta_app/model/health_ques_ans.dart';
import 'package:dio/dio.dart';

class HealthPredictService {
  static String api_url = "https://diabeta-backend.herokuapp.com";

  static Future<String> getHeartPrediction() async {
    var data = {
      "Age": HealthQuestions.heartQuiz[0].defaultValue,
    };

    var response = await Dio().post(api_url + "/heart/predict",
        options: Options(
          headers: {"Content-Type": "application/json"},
        ),
        data: jsonEncode(data));
    return response.data;
  }

  static Future<String> getEyePrediction() async {
    var data = {
      "Age": HealthQuestions.eyeQuiz[0].defaultValue,
    };

    var response = await Dio().post(api_url + "/eye/predict",
        options: Options(
          headers: {"Content-Type": "application/json"},
        ),
        data: jsonEncode(data));
    return response.data;
  }
  
  static Future<String> getKidneyPrediction() async {
    var data = {
      "Age": HealthQuestions.kidneyQuiz[0].defaultValue,
    };

    var response = await Dio().post(api_url + "/kidney/predict",
        options: Options(
          headers: {"Content-Type": "application/json"},
        ),
        data: jsonEncode(data));
    return response.data;
  }
}
