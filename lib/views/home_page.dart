import 'package:cwsdo/widget/home/about.dart';
import 'package:cwsdo/widget/navigation_bar/footer.dart';
import 'package:flutter/material.dart';
import 'package:cwsdo/widget/custom/custom_widget.dart';
import 'package:cwsdo/widget/navigation_bar/navigation_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              height: MediaQuery.of(context).size.height * .9,
              width: double.maxFinite,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/bg1.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomWidg(txt: 'Community Needs Assesment', fsize: 50),
                    CustomWidg(txt: 'Management System', fsize: 50),
                    SizedBox(height: 20),
                    CustomWidg(txt: 'City of San Pablo', fsize: 30),
                    CustomWidg(
                        txt: 'City Social Welfare and Development Office',
                        fsize: 30),
                  ])),
          const About(),
          const Footer(),
        ],
      ),
    );
  }
}
