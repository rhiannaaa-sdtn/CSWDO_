import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cwsdo/widget/admin/totaltally.dart'; // Assuming TcellData and TcellHeader are defined here

// Global variable to store the request text
String requestText = '';

// Constant style for reusable text styles
const TextStyle boldTitleStyle = TextStyle(
  fontSize: 40,
  fontWeight: FontWeight.bold,
);
const TextStyle boldTitleStyle2 = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

const TextStyle bodyTextStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('ABOUT US', style: boldTitleStyle),
          const SizedBox(height: 20),
          const Text(
            'The City Social Welfare and Development Office (CWSDO) is the local social welfare arm of '
            'the City Government of San Pablo mandated to provide basic social welfare programs to its '
            'disadvantage citizenry. CWSDO was devolved and decentralized to the City Government of San Pablo '
            'on October 1, 1992, in pursuant to RA 7160 and City Ordinance No. 2374 Series of 1994.',
            style: bodyTextStyle,
            textAlign: TextAlign.justify,
          ),
          const Text('Program Objectives', style: boldTitleStyle),
          const SizedBox(height: 20),
          const Text(
            'The objectives of the City Social Welfare and Development Office (CWSDO) are to help and provide '
            'food and medical assistance for disadvantaged citizens of San Pablo.',
            style: bodyTextStyle,
            textAlign: TextAlign.justify,
          ),
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              // crossAxisAlignment: CrossAxisAlignment.,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'CWSDO ASSISTANCE OFFERS',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 30),
                    _buildAssistanceOption(
                        'Medical Assistance', 'images/medicalassist.png'),
                    _buildAssistanceOption(
                        'Food Assistance', 'images/foodassist.png'),
                    _buildAssistanceOption(
                        'Other Assistance...', 'images/otherassist.png'),
                    const SizedBox(height: 30),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Track you request here!',
                      style: const TextStyle(
                          fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    _buildRequestTrackerButton(context),
                  ],
                ),
              ],
            ),
          ),
          Row2(),
          SizedBox(height: 50),
          Contact(),
          SizedBox(height: 150),
        ],
      ),
    );
  }

  // Helper function to avoid repetition in assistance options
  Widget _buildAssistanceOption(String title, String imgurl) {
    return Row(
      children: [
        Container(
            // height: MediaQuery.of(context).size.height * .9,
            // height: double.maxFinite,
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              image: DecorationImage(
                alignment: Alignment.topCenter,
                image: AssetImage(imgurl),
                fit: BoxFit.fitWidth,
              ),
            )),
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
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
          backgroundColor:
              const MaterialStatePropertyAll(Color.fromRGBO(78, 115, 222, 1)),
        ),
        child: const Center(
          child: Text(
            'Request Tracker',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        onPressed: () {
          print('Opening Request Tracker Dialog'); // Debugging line
          showDialog(
            context: context,
            builder: (context) => const RequestTrackerDialog(),
          );
        },
      ),
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
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// First row section with Assistance offers and Request Tracker button

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
                SvgPicture.asset("images/SpcLogo.svg",
                    width: 200, height: 200, fit: BoxFit.cover),
                const SizedBox(width: 20),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Community Needs', style: boldTitleStyle2),
                    Text('Assessment Management', style: boldTitleStyle2),
                    Text('System (CNAMS)', style: boldTitleStyle2),
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
                    // Only update the request text and trigger the search on button click
                    if (_controller.text.isNotEmpty) {
                      setState(() {
                        // Set the global variable when the user clicks the arrow button
                        requestText = _controller.text;
                      });

                      print('User request: $requestText');
                    }
                  },
                ),
              ],
            ),
            RemarkTable(), // Pass the global requestText
          ],
        ),
      ),
    );
  }
}

class RemarkTable extends StatelessWidget {
  const RemarkTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Remarks')
          .where('cleintID', isEqualTo: requestText)
          .snapshots(),
      builder: (context, snapshot) {
        // Show a loading indicator while waiting for data
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // Show error message if there's an error fetching the data
        if (snapshot.hasError) {
          return const Center(child: Text('Error loading data'));
        }

        // Show a message when no data is found
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No remarks found.'));
        }

        // Sort the documents by timestamp
        final remarks = snapshot.data!.docs.toList()
          ..sort((a, b) => b['timeStamp'].compareTo(a['timeStamp']));

        // Create table rows with the remarks data
        List<TableRow> remarkTable = [
          const TableRow(
            children: <Widget>[
              TcellHeader(txtcell: 'REMARK', heightcell: 30),
              TcellHeader(txtcell: 'STATUS', heightcell: 30),
              TcellHeader(txtcell: 'REMARK DATE', heightcell: 30),
            ],
          ),
        ];

        // Add the data rows for each remark
        for (var remark in remarks) {
          remarkTable.add(
            TableRow(
              children: <Widget>[
                TcellData(
                  txtcell: remark['remarks'],
                  heightcell: 50,
                  pad: 10,
                  fsize: 15,
                ),
                TcellData(
                  txtcell: remark['status'],
                  heightcell: 50,
                  pad: 10,
                  fsize: 15,
                ),
                TcellData(
                  txtcell: remark['timeStamp'].toDate().toString(),
                  heightcell: 50,
                  pad: 10,
                  fsize: 15,
                ),
              ],
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.only(left: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * .8,
                height: 380,
                child: ListView(
                  children: [
                    Container(
                      height: 40,
                      color: const Color.fromARGB(255, 44, 68, 227),
                      child: const Center(
                        child: Text(
                          'Remarks Information',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(5),
                      child: Table(
                        border: TableBorder.all(),
                        columnWidths: const <int, TableColumnWidth>{
                          0: FlexColumnWidth(1),
                          1: FlexColumnWidth(1),
                          2: FlexColumnWidth(1),
                        },
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        children: remarkTable,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
