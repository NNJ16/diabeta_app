import 'package:diabeta_app/screens/food/components/food_cal_card.dart';
import 'package:diabeta_app/services/food_calc_service.dart';
import "package:flutter/material.dart";
import 'package:outline_search_bar/outline_search_bar.dart';
import '../../components/constants.dart';

class FoodCalculatorScreen extends StatefulWidget {
  const FoodCalculatorScreen({Key? key}) : super(key: key);

  @override
  State<FoodCalculatorScreen> createState() => _FoodCalculatorScreenState();
}

class _FoodCalculatorScreenState extends State<FoodCalculatorScreen> {
  String _query = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 35,
            child: OutlineSearchBar(
              borderColor: kPrimaryColor,
              borderRadius: BorderRadius.circular(10),
              cursorColor: kPrimaryColor,
              searchButtonIconColor: kPrimaryColor,
              onClearButtonPressed: (String e) {
                setState(() {
                  _query = "";
                });
              },
              onSearchButtonPressed: (String searchFor) {
                setState(() {
                  _query = searchFor;
                });
              },
            ),
          ),
        ),
        _query != ""
            ? FutureBuilder(
                future: FoodCalcService.getFoodNutritions(_query),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    int length = snapshot.data!.length;
                    print(length);
                    return ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: List.generate(length, (index) {
                        return Center(
                          child: FoodCalCard(foodCal: snapshot.data![index]),
                        );
                      }),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              )
            : Column(
              children: [
                const SizedBox(
                  height: 48,
                ),
                Container(
                    height: 150,
                    width: 150,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/search.jpg"),
                        fit: BoxFit.fill,
                        alignment: Alignment.topCenter,
                      ),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                    ),
                    child: Center(),
                  ),
                  const Text("Search for foods", style: TextStyle(fontSize: 16, color: Colors.black38),)
              ],
            ),
      ],
    );
  }
}
