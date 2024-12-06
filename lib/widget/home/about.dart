import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Constant style for reusable text styles
const TextStyle boldTitleStyle = TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.bold,
);

const TextStyle bodyTextStyle = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.bold,
);

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row1(),
        Row2(),
        SizedBox(height: 50),
        Contact(),
        SizedBox(height: 150),
      ],
    );
  }
}

// About Us section
class Abt extends StatelessWidget {
  const Abt({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Padding(
        padding: EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ABOUT US', style: boldTitleStyle),
            SizedBox(height: 20),
            Text(
              'The City Social Welfare and Development Office (CWSDO) is the local social welfare arm of '
              'the City Government of San Pablo mandated to provide basic social welfare programs to its '
              'disadvantage citizenry. CWSDO was devolved and decentralized to the City Government of San Pablo '
              'on October 1, 1992, in pursuant to RA 7160 and City Ordinance No. 2374 Series of 1994.',
              style: bodyTextStyle,
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 20),
            Text('Program Objectives', style: boldTitleStyle),
            SizedBox(height: 20),
            Text(
              'The objectives of the City Social Welfare and Development Office (CWSDO) are to help and provide '
              'food and medical assistance for disadvantaged citizens of San Pablo.',
              style: bodyTextStyle,
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}

// First row section with Assistance offers and Request Tracker button
class Row1 extends StatelessWidget {
  const Row1({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(
          flex: 5,
          child: Abt(),
        ),
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'CWSDO ASSISTANCE OFFERS',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                _buildAssistanceOption('Medical Assistance'),
                _buildAssistanceOption('Food Assistance'),
                _buildAssistanceOption('Other Assistance...'),
                const SizedBox(height: 30),
                _buildRequestTrackerButton(context),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Helper function to avoid repetition in assistance options
  Widget _buildAssistanceOption(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  // Request Tracker button
  Widget _buildRequestTrackerButton(BuildContext context) {
    return SizedBox(
      height: 100,
      width: MediaQuery.of(context).size.width * .3,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          ),
          backgroundColor: const MaterialStatePropertyAll(Color.fromRGBO(78, 115, 222, 1)),
        ),
        child: const Center(
          child: Text(
            'Request Tracker',
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const RequestTrackerDialog(),
          );
        },
      ),
    );
  }
}

// Second row section with image
class Row2 extends StatelessWidget {
  const Row2({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "images/CSWDOgroupPic.jpg",
          width: MediaQuery.of(context).size.width * .9,
          height: MediaQuery.of(context).size.height * .5,
          fit: BoxFit.cover,
        ),
      ],
    );
  }
}

// Contact section with address, phone, and email
class Contact extends StatelessWidget {
  const Contact({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Row(
              children: [
                SvgPicture.asset("images/SpcLogo.svg", width: 200, height: 200, fit: BoxFit.cover),
                const SizedBox(width: 20),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Community Needs', style: boldTitleStyle),
                    Text('Assessment Management', style: boldTitleStyle),
                    Text('System (CNAMS)', style: boldTitleStyle),
                  ],
                ),
              ],
            ),
          ),
        ),
        const Expanded(
          flex: 4,
          child: Padding(
            padding: EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('CONTACT US', style: boldTitleStyle),
                Divider(color: Colors.black, thickness: 10, endIndent: 300),
                Text('inquiry@cswdo.gov.ph', style: bodyTextStyle),
                Text('cnams.co@cswdo.gov.ph', style: bodyTextStyle),
                Text('8962-2813/8951-7433', style: bodyTextStyle),
                Text('Monday - Friday (except holidays)', style: bodyTextStyle),
                Text('8:00 am - 5:00 pm', style: bodyTextStyle),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// Request Tracker Dialog

class RequestTrackerDialog extends StatefulWidget {
  const RequestTrackerDialog({super.key});

  @override  
  _RequestTrackerDialogState createState() => _RequestTrackerDialogState();
}

class _RequestTrackerDialogState extends State<RequestTrackerDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return AlertDialog(
      title: const Text(
        'Request Tracker',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      content: ConstrainedBox(
        constraints: BoxConstraints(minWidth: screenWidth * 0.8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Please enter your reference number below:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Request Information',
                      hintText: 'Enter your request...',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: () {
                    String requestText = _controller.text;
                    if (requestText.isNotEmpty) {
                      print('User request: $requestText');
                      // You can add any further logic here, like sending the request
                    }
                    // Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}