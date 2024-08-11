import 'package:cwsdo/widget/custom/custom_widget.dart';
import 'package:flutter/material.dart';

class Sidebuttons extends StatelessWidget {
  const Sidebuttons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment:
          MainAxisAlignment.start, //Center Column contents vertically,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment
                      .start, //Center Column contents vertically,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("images/SpcLogo.png",
                        width: 60, height: 60, fit: BoxFit.cover),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'CNAMS',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  color: Colors.white,
                  thickness: 2,
                  // endIndent: 300,
                ),
                const Sbutton(
                  btndesc: 'Dashboard',
                  btnlogo: 'images/SpcLogo.png',
                  btnlink: 'Dashboard link',
                ),
                const Sbutton(
                  btndesc: 'Total Tally',
                  btnlogo: 'images/SpcLogo.png',
                  btnlink: 'Total Tally link',
                ),
                const Sbutton(
                  btndesc: 'Add Benificiary',
                  btnlogo: 'images/SpcLogo.png',
                  btnlink: 'Add Benificiary link',
                ),
                const Sbutton(
                  btndesc: 'Relief Request',
                  btnlogo: 'images/SpcLogo.png',
                  btnlink: 'Relief Request link',
                ),
                const Sbutton(
                  btndesc: 'Search Beneficiaary',
                  btnlogo: 'images/SpcLogo.png',
                  btnlink: 'Search Beneficiary link',
                ),
                const Sbutton(
                  btndesc: 'Heat Map',
                  btnlogo: 'images/SpcLogo.png',
                  btnlink: 'Heat Map link',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}