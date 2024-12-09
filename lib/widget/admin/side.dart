import 'package:cwsdo/widget/custom/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:html' as html; // Import dart:html for web storage
import 'dart:io'; // For platform-specific checks
import 'package:flutter/foundation.dart'; // For web-specific checks

class Sidebuttons extends StatelessWidget {
  const Sidebuttons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start, // Center Column contents vertically,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15, top: 15),
          child: SizedBox(
            child: Column(
              children: [
                Row(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start, // Center Column contents vertically,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset("images/SpcLogo.svg", width: 50, height: 50, fit: BoxFit.cover),
                        const SizedBox(width: 10),
                        const Text(
                          'CNAMS',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                const Divider(color: Colors.white, thickness: 2),

                // Conditional rendering based on localStorage
                if (html.window.localStorage['office'] == "CWSDO") ...[
                 const Sbutton(
                    btndesc: 'Dashboard',
                    btnlogo: 'images/Dashboard.png',
                    btnlink: '/dashboard',
                  ),
                 const Sbutton(
                    btndesc: 'Assistance Overview',
                    btnlogo: 'images/TotalTally.png',
                    btnlink: '/totaltally',
                  ),
                 const Sbutton(
                    btndesc: 'Manage Request',
                    btnlogo: 'images/AddBeneficiary.png',
                    btnlink: '/addbeneficiary',
                  ),
                 const Sbutton(
                    btndesc: 'List of Resident',
                    btnlogo: 'images/TotalTally.png',
                    btnlink: '/listbns',
                  ),
                  // Uncomment if needed
                  // Sbutton(
                  //   btndesc: 'Relief Request',
                  //   btnlogo: 'images/ReliefRequest.png',
                  //   btnlink: '/reliefrequest',
                  // ),
                //  const Sbutton(
                //     btndesc: 'Heat Map',
                //     btnlogo: 'images/HeatMap.png',
                //     btnlink: '/heatmap',
                //   ),
                 const Sbutton(
                    btndesc: 'User Setting',
                    btnlogo: 'images/Union.png',
                    btnlink: '/usersetting',
                  ),
                 const Sbutton(
                    btndesc: 'Carousel',
                    btnlogo: 'carousel',
                    btnlink: '/carousel',
                  ),
                ] 
                 else ...[
                    const Sbutton(
                    btndesc: 'List of Resident',
                    btnlogo: 'images/Dashboard.png',
                    btnlink: '/resident',
                  ),
                 const Sbutton(
                    btndesc: 'Request Assistance',
                    btnlogo: 'images/AddBeneficiary.png',
                    btnlink: '/assistancerequest',
                  ),const Sbutton(
                    btndesc: 'List of Request',
                    btnlogo: 'images/TotalTally.png',
                    btnlink: '/listrequest',
                  ),  
                  ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
