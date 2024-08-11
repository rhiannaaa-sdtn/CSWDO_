import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

class CustomWidg extends StatelessWidget {
  final String txt;
  final double fsize;

  const CustomWidg({super.key, required this.txt, required this.fsize});

  @override
  Widget build(BuildContext context) {
    return Text(
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
    );
  }
}

class Sbutton extends StatelessWidget {
  final String btndesc, btnlogo, btnlink;

  const Sbutton(
      {super.key,
      required this.btndesc,
      required this.btnlogo,
      required this.btnlink});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Alert Dialog Example'),
                content: Text(btnlink),
                actions: <Widget>[
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('OK')),
                ],
              );
            });
      },
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment:
                MainAxisAlignment.start, //Center Column contents vertically,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(btnlogo, width: 40, height: 40, fit: BoxFit.cover),
              const SizedBox(
                width: 10,
              ),
              Text(
                btndesc,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.white),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          const Divider(
            color: Colors.white,
            thickness: 2,
            // endIndent: 300,
          ),
        ],
      ),
    );
  }
}

class InptBX extends StatelessWidget {
  final String txtdesc, txtinput;
  // final String txtinput;

  const InptBX({
    super.key,
    required this.txtdesc,
    required this.txtinput,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(txtdesc,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                    decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: txtinput,
                )),
              ),
            ],
          ),
        )
      ],
    );
  }
}