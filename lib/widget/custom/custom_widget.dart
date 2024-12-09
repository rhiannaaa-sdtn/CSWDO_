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
        // showDialog(
        //     context: context,
        //     builder: (context) {
        //       return AlertDialog(
        //         title: const Text('Alert Dialog Example'),
        //         content: Text(btnlink),
        //         actions: <Widget>[
        //           TextButton(
        //               onPressed: () => Navigator.of(context).pop(),
        //               child: const Text('OK')),
        //         ],
        //       );
        //     });
        Navigator.pushNamed(context, btnlink);
        Navigator.pushReplacementNamed(context, btnlink);
      },
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment:
                MainAxisAlignment.start, //Center Column contents vertically,
            crossAxisAlignment: CrossAxisAlignment.center,
children: [
  // Conditionally render the Image.asset or Icon based on btnlogo
  if (btnlogo != "carousel")
    Image.asset(
      btnlogo,
      width: 40,
      height: 40,
      fit: BoxFit.fill,
    )
  else
    Icon(
      Icons.image,
      color: Colors.white,
      size: 30.0,
    ),
  const SizedBox(width: 10),  // Add space between the icon/image and the text
  // Text widget that displays the description
  Text(
    btndesc,
    style: const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
      color: Colors.white,
    ),
  ),
]
          ),
          const SizedBox(
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

class InptBox extends StatefulWidget {
  final String txtdesc, txtinput;
  final TextEditingController inputText;
  // final String txtinput;

  const InptBox({
    super.key,
    required this.txtdesc,
    required this.txtinput,
    required this.inputText,
  });
  @override
  State<InptBox> createState() => _InptBoxState();
}

class _InptBoxState extends State<InptBox> {
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
                child: Text(widget.txtdesc,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                    controller: widget.inputText,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: widget.txtinput,
                    )),
              ),
            ],
          ),
        )
      ],
    );
  }
}
