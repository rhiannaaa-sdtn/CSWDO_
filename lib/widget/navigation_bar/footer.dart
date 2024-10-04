// import 'package:cwsdo/constatns/navitem.dart';
import 'package:flutter/material.dart';
// import 'package:cwsdo/widget/custom/custom_widget.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      color: const Color.fromRGBO(78, 115, 222, 1),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.center, //Center Column contents vertically,
        crossAxisAlignment: CrossAxisAlignment.center, //Center Co
        children: [
          Image.asset("images/SpcLogo.png",
              width: 100, height: 100, fit: BoxFit.cover),
          const SizedBox(
            width: 20,
          ),
          const Text(
            '© SAN PABLO CITY GOVERNMENT',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          )
        ],
      ),
    );
  }
}
