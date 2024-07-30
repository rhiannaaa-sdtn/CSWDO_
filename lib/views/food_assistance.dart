import 'package:cwsdo/widget/custom/custom_widget.dart';
import 'package:cwsdo/widget/navigation_bar/footer.dart';
import 'package:flutter/material.dart';
import 'package:cwsdo/widget/navigation_bar/navigation_bar.dart';

class Foodassistance extends StatefulWidget {
  const Foodassistance({super.key});

  @override
  State<Foodassistance> createState() => _FoodassistanceState();
}

class _FoodassistanceState extends State<Foodassistance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          //MAIN
          const NavBar(),
          //about
          //Home
          Container(
              // height: MediaQuery.of(context).size.height * .9,
              // height: double.maxFinite,
              width: 100,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/bg1.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(100.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Row(children: [
                        CustomWidg(txt: 'Food Assistance', fsize: 30),
                      ]),
                      const SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.height * 1,
                        child: Image.asset(
                          width: 700,
                          "images/food_info.png",
                        ),
                      )
                    ]),
              )),
          // const About(),
          const Footer(),
        ],
      ),
    );
  }
}
