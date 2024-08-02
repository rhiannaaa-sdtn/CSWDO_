import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

class CustomWidg extends StatelessWidget {
  final String txt;
  final double fsize;

  const CustomWidg({super.key, required this.txt, required this.fsize});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => const Footer()),
        // );
        Navigator.pushNamed(context, '/');
      },
      child: Text(
        txt,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: fsize,
          // fontFamily: GoogleFonts.notoSansKayahLi().fontFamily,
          // foreground: Paint()
          //   ..style = PaintingStyle.stroke
          //   ..strokeWidth = 1
          //   ..color = const Color.fromARGB(255, 0, 0, 0),
          // fontWeight: FontWeight.w500,
          shadows: const [
            Shadow(
                // bottomLeft
                offset: Offset(.5, -.5),
                color: Colors.green),
            Shadow(
                // bottomRight
                offset: Offset(.5, -.5),
                color: Colors.black),
            Shadow(
                // topRight
                offset: Offset(.5, .5),
                color: Colors.black),
            Shadow(
                // topLeft
                offset: Offset(-.5, .5),
                color: Colors.black),
          ],
          color: const Color.fromARGB(255, 255, 255, 255),
        ),
      ),
    );
  }
}
