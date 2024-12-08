import 'package:cwsdo/constatns/navitem.dart';
import 'package:cwsdo/views/admin/side_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cwsdo/widget/admin/nextStep.dart';
import 'package:cwsdo/widget/admin/totaltally.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:cwsdo/services/firestore.dart';
import 'package:url_launcher/url_launcher.dart';

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];
String globalvariableindigency = '';
String globalvariableid = '';
class NextStepMain extends StatefulWidget {
  final String requestID;
  const NextStepMain({super.key, required this.requestID});

  @override
  State<NextStepMain> createState() => _NextStepMainState();
}

class _NextStepMainState extends State<NextStepMain> {
  @override
  Widget build(BuildContext context) {
    return Sidebar(
        content: NextStep(
      requestID: widget.requestID,
    ));
  }
}

class NextStep extends StatelessWidget {
  final String requestID;
  const NextStep({super.key, required this.requestID});

  @override
  Widget build(BuildContext context) {
    String status1 = "";
    final TextEditingController status = TextEditingController();
    final TextEditingController remarks = TextEditingController();
    final FireStoreService fireStoreService = FireStoreService();

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('beneficiaries')
          .doc(requestID)
          .snapshots(),
      builder: (context, snapshot) {
        List<TableRow> clientWidgets = [
          const TableRow(
            children: <Widget>[
              TcellHeader(
                txtcell: 'REMARK',
                heightcell: 30,
              ),
              TcellHeader(
                txtcell: 'STATUS',
                heightcell: 30,
              ),
              TcellHeader(
                txtcell: 'REMARK DATE',
                heightcell: 30,
              ),
              TcellHeader(
                txtcell: 'REMARK BY',
                heightcell: 30,
              ),
            ],
          ),
        ];
        List<TableRow> personalWidgets = [
          const TableRow(
            children: <Widget>[
              TcellHeader(
                txtcell: 'REMAEK',
                heightcell: 0,
              ),
              TcellHeader(
                txtcell: 'STATUS',
                heightcell: 0,
              ),
            ],
          ),
        ];
        List<TableRow> needsWidgets = [
          const TableRow(
            children: <Widget>[
              TcellHeader(
                txtcell: 'REMAEK',
                heightcell: 0,
              ),
              TcellHeader(
                txtcell: 'STATUS',
                heightcell: 0,
              ),
            ],
          ),
        ];

        void personalinfo(String label, String value) {
          final personalWidget = TableRow(
            children: <Widget>[
              TcellData(txtcell: label, heightcell: 30, pad: 5, fsize: 12),
              TcellData(txtcell: value, heightcell: 30, pad: 5, fsize: 12),
            ],
          );
          personalWidgets.add(personalWidget);
        }

        void needsinfo(String label, String value) {
          final needsWidget = TableRow(
            children: <Widget>[
              TcellData(txtcell: label, heightcell: 30, pad: 5, fsize: 12),
              TcellData(txtcell: value, heightcell: 30, pad: 5, fsize: 12),
            ],
          );
          needsWidgets.add(needsWidget);
        }

        if (snapshot.hasData) {
          final clients = snapshot.data;

          final clientWidget = TableRow(
            children: <Widget>[
              const TcellData(txtcell: '1', heightcell: 30, pad: 5, fsize: 12),
              TcellData(
                  txtcell: clients!.id, heightcell: 30, pad: 5, fsize: 12),
              TcellData(
                  txtcell: clients['fullname'],
                  heightcell: 30,
                  pad: 5,
                  fsize: 12),
              TcellData(
                  txtcell: clients['fullname'],
                  heightcell: 30,
                  pad: 5,
                  fsize: 12),
            ],
          );
          clientWidgets.add(clientWidget);

          status1 = clients['status'];          
          personalinfo('FULLNAME', clients['fullname']);
          personalinfo('MOBILE NUMBER.', clients['mobilenum']);
          personalinfo('DATE OF BIRTH', clients['dob']);
          personalinfo('Gender', clients['gender']);
          personalinfo('FULL ADDRESS', clients['address']);
          personalinfo('BARANGAY', clients['barangay']);
          needsinfo('ORDER NUMBER', clients.id);
          needsinfo('NEED TYPE', clients['needs']);
          needsinfo('DATE REGISTERED', clients['dateRegistered']);
          needsinfo('NEEDS STATUS', clients['status']);

          globalvariableindigency =  clients['indigency'];
          globalvariableid =  clients['validId'];
        }

        Future<void> _saveRemarks(
          TextEditingController status,
          String remarks,
        ) async {
          print(status.text);
          print(remarks);
         
           if(status1 == "Ongoing"){
          fireStoreService.addRemarks(requestID, remarks, 'Ready');
            } else if(status1 == "Ready"){
          fireStoreService.addRemarks(requestID, remarks, 'Completed');
            }
         
        }

        Future<void> _updateStatus() async {
          final documentRef = FirebaseFirestore.instance.collection('beneficiaries').doc(requestID);

          try {
            if(status1 == "Ongoing"){
              await documentRef.update({'status': 'Ready'});
            } else if(status1 == "Ready"){
              await documentRef.update({'status': 'Completed'});
            }
          } catch (e) {
            print('Error updating status: $e');
          }
        }

        Future<void> _actionButton() async {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                title: Container(
                  height: 80,
                  color: const Color.fromARGB(255, 45, 127, 226),
                  child: Center(child: Text('Take Action')),
                ),
                titlePadding: const EdgeInsets.all(0),
                content: Container(
                  height: MediaQuery.of(context).size.height * .6,
                  width: MediaQuery.of(context).size.width * .6,
                  child: Column(
                    children: [
                      DropdownButtonExample(
                        status: status,
                        status1: status1,
                      ),
                      SizedBox(
                        child: TextField(
                          controller: remarks,
                          maxLength: 500,
                          maxLines: 10,
                          decoration: InputDecoration(
                            labelText: "Remarks",
                            hintText: "Remarks (Maximum of 500 characters)",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      _saveRemarks(status, remarks.text);
                      remarks.text = '';
                      _updateStatus(); 
                      Navigator.pop(context); 
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }

        return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Remarks')
              .where('cleintID', isEqualTo: requestID)
              .snapshots(),
          builder: (context, snapshot) {
            List<TableRow> remarkTable = [
              const TableRow(
                children: <Widget>[
                  TcellHeader(
                    txtcell: 'REMARK',
                    heightcell: 30,
                  ),
                  TcellHeader(
                    txtcell: 'STATUS',
                    heightcell: 30,
                  ),
                  TcellHeader(
                    txtcell: 'REMARK DATE',
                    heightcell: 30,
                  ),
                
                ],
              ),
            ];

            if (snapshot.hasData) {
              final clientss = snapshot.data?.docs.toList();
              clientss?.sort((a, b) => b['timeStamp'].compareTo(a['timeStamp']));
              for (var client in clientss!) {
                final clientWidget = TableRow(
                  children: <Widget>[
                    TcellData(
                        txtcell: client['remarks'], heightcell: 50, pad: 10, fsize: 15),
                    TcellData(
                        txtcell: client['status'],
                        heightcell: 50,
                        pad: 10,
                        fsize: 15),
                    TcellData(
                        txtcell: client['timeStamp'].toDate().toString(),
                        heightcell: 50,
                        pad: 10,
                        fsize: 15),
                  ],
                );
                remarkTable.add(clientWidget);
              }
            }

            return Padding(
              padding: const EdgeInsets.only(left: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10,),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       flex: 8,
                  //       // child: Text(
                  //       //   'Client Remarks',
                  //       //   style: TextStyle(fontSize: 25),
                  //       // ),
                  //     ),
                  //   ],
                  // ),
                  Expanded(
                    flex: 8,
                    child: Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * .4,
                                height: 380,
                                child: ListView(
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 800,
                                      color: const Color.fromARGB(255, 44, 68, 227),
                                      child: const Center(
                                        child: Text(
                                          'Personal Information',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 800,
                                      color: Colors.white,
                                      child: Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Table(
                                          border: TableBorder.all(),
                                          columnWidths: const <int, TableColumnWidth>{
                                            0: FlexColumnWidth(1),
                                            1: FlexColumnWidth(1),
                                            2: FlexColumnWidth(1),
                                            3: FlexColumnWidth(1),
                                          },
                                          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                          children: personalWidgets,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * .4,
                                height: 380,
                                child: ListView(
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 800,
                                      color: const Color.fromARGB(255, 44, 68, 227),
                                      child: const Center(
                                        child: Text(
                                          'Needs Information',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 800,
                                      color: Colors.white,
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          children: [
                                            Table(
                                              border: TableBorder.all(),
                                              columnWidths: const <int, TableColumnWidth>{
                                                0: FlexColumnWidth(1),
                                                1: FlexColumnWidth(1),
                                                2: FlexColumnWidth(1),
                                                3: FlexColumnWidth(1),
                                              },
                                              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                              children: needsWidgets,
                                            ),
                                            SizedBox(height: 5),
                                            if (status1 != 'Completed')
                                              SizedBox(
                                                height: 50,
                                                child: Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,  // Align buttons at opposite sides
  children: [
    ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(
          const Color.fromARGB(255, 71, 42, 230),
        ),
      ),
      child: const Row(
        children: [
          Text(
            style: TextStyle(
              fontSize: 15,
              color: Color.fromRGBO(255, 255, 255, 1),
              fontWeight: FontWeight.bold,
            ),
            "Indigency",
          ),
        ],
      ),
      onPressed: () {
        openIndigencyFile(globalvariableindigency); // Open the URL
      },
    ),

    SizedBox(width: 20,),
    ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(
          const Color.fromARGB(255, 71, 42, 230),
        ),
      ),
      child: const Row(
        children: [
          Text(
            style: TextStyle(
              fontSize: 15,
              color: Color.fromRGBO(255, 255, 255, 1),
              fontWeight: FontWeight.bold,
            ),
            "Document",
          ),
        ],
      ),
      onPressed: () {
        openIndigencyFile(globalvariableid); // Open the URL
      },
    ),
    // Wrapping the "Take Action" button with an Expanded widget to push it to the right
    Expanded(
      child: Align(
        alignment: Alignment.centerRight,  // Align the button to the right
        child: Container(width: 200,
          child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              backgroundColor: MaterialStateProperty.all(
               const Color.fromARGB(255, 45, 127, 226),
              ),
            ),
            child: const Row(
              children: [
                Text(
                  style: TextStyle(
                    fontSize: 15,
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontWeight: FontWeight.bold,
                  ),
                  'Take Action',
                ),
              ],
            ),
            onPressed: () {
              _actionButton();
            },
          ),
        ),
      ),
    ),
  ],
)

                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                 Container(
  height: 250, // Fill the available space
                           color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Table(
                              border: TableBorder.all(),
                              columnWidths: const <int, TableColumnWidth>{
                                0: FlexColumnWidth(1),
                                1: FlexColumnWidth(1),
                                2: FlexColumnWidth(1),
                                3: FlexColumnWidth(1),
                              },
                              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                              children: remarkTable,
                            ),
                          ),
                        ),
                      ],
              ),
            );
          },
        );
      },
    );
  }
}

class DropdownButtonExample extends StatefulWidget {
  TextEditingController status;
  String status1;

  DropdownButtonExample({super.key, required this.status, required this.status1});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String dropdownValue = ''; 
  List<String> items = ['Ongoing', 'Ready', 'Completed'];

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.status1.isNotEmpty ? widget.status1 : items.first;
    widget.status.text = dropdownValue; 
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.status,
      enabled: false, 
      decoration: InputDecoration(
        labelText: 'Status', 
        border: OutlineInputBorder(),
        suffixIcon: Icon(Icons.lock), 
      ),
    );
  }
}
void openIndigencyFile(String url) async {
  if (await canLaunch(url)) {
    await launch(url);  // This opens the URL in the browser.
  } else {
    throw 'Could not launch $url';
  }
}