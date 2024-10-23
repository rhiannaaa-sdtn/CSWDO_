import 'package:cwsdo/widget/home/about.dart';
import 'package:cwsdo/widget/navigation_bar/footer.dart';
import 'package:flutter/material.dart';
import 'package:cwsdo/widget/custom/custom_widget.dart';
import 'package:cwsdo/widget/navigation_bar/navigation_bar.dart';
import 'package:cwsdo/constatns/navitem.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        controller: _scrollController,
        scrollDirection: Axis.vertical,
        children: [
          // NAVBAR
          Container(
            height: MediaQuery.of(context).size.height * .1,
            width: double.maxFinite,
            color: const Color(0xff08436d),
            child: Row(
              children: [
                const Spacer(),
                for (int i = 0; i < navTitles.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: GestureDetector(
                      onTap: () {
                        if (navTitles[i] == 'About') {
                          _scrollController.animateTo(
                            MediaQuery.of(context).size.height * 1.5,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        } else if (navTitles[i] == 'Contact') {
                          _scrollController.animateTo(
                            MediaQuery.of(context).size.height * 2.5,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        } else if (navTitles[i] == 'Admin') {
                          Navigator.pushNamed(context, '/login');
                        } else {
                          Navigator.pushNamed(context, navLinks[i]);
                        }
                      },
                      child: CustomWidg(txt: navTitles[i], fsize: 30),
                    ),
                  )
              ],
            ),
          ),
          // MAIN CONTENT
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
                CustomWidg(txt: 'Community Needs Assessment', fsize: 50),
                CustomWidg(txt: 'Management System', fsize: 50),
                SizedBox(height: 20),
                CustomWidg(txt: 'City of San Pablo', fsize: 30),
                CustomWidg(
                    txt: 'City Social Welfare and Development Office',
                    fsize: 30),
              ],
            ),
          ),
          const About(),
          const Footer(),
        ],
      ),
    );
  }
}
