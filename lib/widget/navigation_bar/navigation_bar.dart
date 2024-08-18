import 'package:cwsdo/constatns/navitem.dart';
import 'package:cwsdo/views/admin/side_bar.dart';
import 'package:cwsdo/views/login.dart';
import 'package:flutter/material.dart';
import 'package:cwsdo/widget/custom/custom_widget.dart';
import 'dart:developer';

// import 'package:flutter/src/widgets/navigator.dart';
// import 'package:cswdo/constants/navitem.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .1,
      // margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
      width: double.maxFinite,
      // decoration: BoxDecoration(
      //     gradient: const LinearGradient(
      //         colors: [Colors.blueGrey, Colors.lightBlue]),
      //     borderRadius: BorderRadius.circular(100)),
      color: const Color(0xff08436d),

      child: Row(children: [
        const Spacer(),
        for (int i = 0; i < navTitles.length; i++)
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => const Footer()),
                  // );
                  if (navTitles[i] == 'Admin') //
                  {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const Sidebar()),
                    );
                  } else
                    Navigator.pushNamed(context, navLinks[i]);
                },
                child: CustomWidg(txt: navTitles[i], fsize: 30)),
          )
      ]),
    );
  }
}
