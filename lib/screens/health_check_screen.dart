import 'package:diabeta_app/components/category_card.dart';
import 'package:diabeta_app/components/constants.dart';
import 'package:diabeta_app/screens/diabetes/screens/quiz_screen.dart';
import 'package:diabeta_app/screens/health/eye_risk_screen.dart';
import 'package:diabeta_app/screens/health/heart_risk_screen.dart';
import 'package:diabeta_app/screens/health/kidney_risk_screen.dart';
import 'package:flutter/material.dart';

import 'diabetes/screens/quiz_screen1.dart';

class HealthCheckScreen extends StatefulWidget {
  const HealthCheckScreen({Key? key}) : super(key: key);

  @override
  State<HealthCheckScreen> createState() => _HealthCheckScreenState();
}

class _HealthCheckScreenState extends State<HealthCheckScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[100],
      body: ListView(
        children: [
          const SizedBox(
            height: 8,
          ),
          InkWell(
            child: const CategoryCard(
              title: "Diabetes Risk",
              imgPath: "assets/images/diabetes.jpeg",
            ),
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return Container(
                        height: 300,
                        decoration: BoxDecoration(
                            color: Colors.teal[100],
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(40.0),
                              topRight: Radius.circular(40.0),
                            )),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const QuizScreen1()),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 32),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Could You Have Prediabetes?',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 16.0),
                                  child: Container(
                                    height: 40,
                                    width: 200,
                                    decoration: const BoxDecoration(
                                        color: kPrimaryColor,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        )),
                                    child: const Center(
                                        child: Text(
                                      'TAKE THE TEST',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )),
                                  ),
                                ),
                                const Text(
                                  'Could You Have Type 2 Diabetes?',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const QuizScreen()),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, bottom: 16.0),
                                    child: Container(
                                      height: 40,
                                      width: 200,
                                      decoration: const BoxDecoration(
                                          color: kPrimaryColor,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10.0),
                                          )),
                                      child: const Center(
                                          child: Text(
                                        'TAKE THE TEST',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      )),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ));
                  });
              // showDialog(
              //   context: context,
              //   builder: (BuildContext buildContext) => (DiabetesTestType(
              //       buildContext: context,)),
              // );
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const QuizScreen()),
              // );
            },
          ),
          InkWell(
            child: const CategoryCard(
              title: "Heart Risk",
              imgPath: "assets/images/heart.jpeg",
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HeartRiskScreen()),
              );
            },
          ),
          InkWell(
            child: const CategoryCard(
              title: "Eye Risk",
              imgPath: "assets/images/eye.jpeg",
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EyeRiskScreen()),
              );
            },
          ),
          InkWell(
            child: const CategoryCard(
              title: "Kidney Risk",
              imgPath: "assets/images/kidney.jpeg",
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const KidneyRiskScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
