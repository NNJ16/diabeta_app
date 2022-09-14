import 'package:diabeta_app/components/constants.dart';
import 'package:diabeta_app/screens/diabetes/screens/quiz_screen1.dart';
import 'package:flutter/material.dart';

import '../screens/diabetes/screens/quiz_screen.dart';

class DiabetesTestType extends StatelessWidget {
  final BuildContext buildContext;

  const DiabetesTestType({ Key? key , required this.buildContext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Select Diabetes Test',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      content:Container(
        //height: 50,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const QuizScreen()),
              );
            }, child: Text("Test 1")),
            TextButton(onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const QuizScreen1()),
              );
            }, child: Text("Test 2")),
          ],
        ),
      ),
    );
  }
}