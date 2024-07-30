import 'package:cwsdo/widget/custom/custom_widget.dart';
import 'package:cwsdo/widget/navigation_bar/footer.dart';
import 'package:flutter/material.dart';
import 'package:cwsdo/widget/navigation_bar/navigation_bar.dart';

class MedicalAssistance extends StatelessWidget {
  const MedicalAssistance({super.key});

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
                alignment: Alignment.topCenter,
                image: AssetImage("images/bg1.png"),
                fit: BoxFit.fitWidth,
              ),
            ),
            child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 80,
                  ),
                  FoodHEad(),
                  Padding(
                      padding: EdgeInsets.only(left: 120, top: 50),
                      child: FoodText()),
                  SizedBox(
                    height: 50,
                  ),
                  FoodAssistPic()
                ]),
          ),
          // const About(),
          const Footer(),
        ],
      ),
    );
  }
}
// child: Padding(
//                 padding: const EdgeInsets.only(left: 200, top: 50),

class FoodHEad extends StatelessWidget {
  const FoodHEad({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("images/SpcLogo.png",
              width: 100, height: 100, fit: BoxFit.cover),
          const SizedBox(
            width: 20,
          ),
          const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                'Community Needs'),
            Text(
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                'Assesment Management'),
            Text(
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                'System (CNAMS)')
          ])
        ]);
  }
}

class FoodText extends StatelessWidget {
  const FoodText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(children: [
      Row(children: [
        CustomWidg(txt: 'Medical Assistance', fsize: 50),
      ]),
    ]);
  }
}

class FoodAssistPic extends StatelessWidget {
  const FoodAssistPic({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.height * 1.4,
      child: Image.asset(
        width: 700,
        "images/medical_info.png",
      ),
    );
  }
}
