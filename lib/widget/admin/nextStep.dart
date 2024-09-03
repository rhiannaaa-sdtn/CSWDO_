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

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

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
    final TextEditingController status = TextEditingController();
    final TextEditingController remarks = TextEditingController();
    final FireStoreService fireStoreService = FireStoreService();
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Request')
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
              TcellData(txtcell: label, heightcell: 30, pad: 5, fsize: 15),
              TcellData(txtcell: value, heightcell: 30, pad: 5, fsize: 15),
            ],
          );
          personalWidgets.add(personalWidget);
        }

        void needsinfo(String label, String value) {
          final needsWidget = TableRow(
            children: <Widget>[
              TcellData(txtcell: label, heightcell: 30, pad: 5, fsize: 15),
              TcellData(txtcell: value, heightcell: 30, pad: 5, fsize: 15),
            ],
          );
          needsWidgets.add(needsWidget);
        }

        if (snapshot.hasData) {
          final clients = snapshot.data;

          final clientWidget = TableRow(
            children: <Widget>[
              const TcellData(txtcell: '1', heightcell: 50, pad: 10, fsize: 15),
              TcellData(
                  txtcell: clients!.id, heightcell: 50, pad: 10, fsize: 15),
              TcellData(
                  txtcell: clients['fullname'],
                  heightcell: 50,
                  pad: 10,
                  fsize: 15),
              TcellData(
                  txtcell: clients['familynum'],
                  heightcell: 50,
                  pad: 10,
                  fsize: 15),
            ],
          );
          clientWidgets.add(clientWidget);
          personalinfo('FULLNAME', clients['fullname']);
          personalinfo('MOBILE NUMBER.', clients['mobileNum']);
          personalinfo('DATE OF BIRTH', clients['mobileNum']);
          personalinfo('GOVT. ISSUED ID', clients['mobileNum']);
          personalinfo('GOVT. ISSUED ID NO.', clients['mobileNum']);
          personalinfo('No. OF FAMILIY NUMBER', clients['mobileNum']);
          personalinfo('FULL ADDRESS', clients['mobileNum']);
          personalinfo('BARANGAY', clients['mobileNum']);
          needsinfo('ORDER NUMBER', clients['mobileNum']);
          needsinfo('NEED TYPE', clients['mobileNum']);
          needsinfo('DATE REGISTERED', clients['mobileNum']);
          needsinfo('NEEDS STATUS', clients['mobileNum']);
          needsinfo('REPORT', clients['mobileNum']);
        }

        Future<void> _saveRemarks(
          TextEditingController status,
          String remarks,
        ) async {
          print(status.text);
          print(remarks);
          fireStoreService.addRemarks(requestID, remarks, status.text);
        }

        Future<void> _actionButton() async {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
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
                          ),
                          SizedBox(
                            // width: 100,
                            child: TextField(
                              controller: remarks,
                              maxLength: 500,
                              maxLines: 10,
                              decoration: InputDecoration(
                                // contentPadding: EdgeInsets.symmetric(
                                //   vertical: 150.0,
                                //   horizontal: 10.0,
                                // ),
                                labelText: "Remarks",
                                hintText: "Remarks (Maximum of 500 characters)",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                // focusedBorder: InputBorder.none,
                                // enabledBorder: InputBorder.none,
                                // errorBorder: InputBorder.none,
                                // disabledBorder: InputBorder.none,
                                // hintTextDirection: TextDirection.ltr,
                                fillColor: Colors.white,
                              ),
                            ),
                          )
                        ],
                      )),
                  actions: <Widget>[
                    TextButton(
                        onPressed: () => _saveRemarks(status, remarks.text),
                        child: const Text('OK')),
                  ],
                );
              });
        }

        // return ListView(
        //   scrollDirection: Axis.vertical,
        //   shrinkWrap: true,
        //   children: clie+ntWidgets,
        // );
        return Padding(
          padding: const EdgeInsets.only(
            // top: 50,
            left: 50,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Column(
                children: [
                  const Text(
                    'BENEFICIARY DETAIL:',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              // part2
              Row(
                children: [
                  Expanded(
                    child: Center(
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
                              // height: double.infinity,
                              // height: MediaQuery.of(context).size.height / 1.5,
                              width: 800,
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Table(
                                  border: TableBorder.all(),
                                  columnWidths: const <int, TableColumnWidth>{
                                    0: FlexColumnWidth(1),
                                    1: FlexColumnWidth(1),
                                    2: FlexColumnWidth(1),
                                    3: FlexColumnWidth(1)
                                  },
                                  defaultVerticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  children: personalWidgets,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
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
                              // height: double.infinity,
                              // height: MediaQuery.of(context).size.height / 1.5,
                              width: 800,
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Table(
                                      border: TableBorder.all(),
                                      columnWidths: const <int,
                                          TableColumnWidth>{
                                        0: FlexColumnWidth(1),
                                        1: FlexColumnWidth(1),
                                        2: FlexColumnWidth(1),
                                        3: FlexColumnWidth(1)
                                      },
                                      defaultVerticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      children: needsWidgets,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                      height: 50,
                                      width: 150,
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                            shape: WidgetStatePropertyAll(
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            )),
                                            backgroundColor:
                                                const WidgetStatePropertyAll(
                                                    Color.fromRGBO(
                                                        78, 222, 97, 1))),
                                        child: const Row(
                                          children: [
                                            Text(
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Color.fromRGBO(
                                                      255, 255, 255, 1),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                'Take Action'),
                                          ],
                                        ),
                                        onPressed: () {
                                          _actionButton();
                                          // _selectedFile('type1');
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),

              // part3

              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * .7,
                  height: 200,
                  child: ListView(
                    children: [
                      Container(
                        height: 40,
                        width: 800,
                        color: const Color.fromARGB(255, 44, 68, 227),
                        child: const Center(
                          child: Text(
                            'Tracking History',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        // height: double.infinity,
                        // height: MediaQuery.of(context).size.height / 1.5,
                        width: 800,
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Table(
                            border: TableBorder.all(),
                            columnWidths: const <int, TableColumnWidth>{
                              0: FlexColumnWidth(1),
                              1: FlexColumnWidth(1),
                              2: FlexColumnWidth(1),
                              3: FlexColumnWidth(1)
                            },
                            defaultVerticalAlignment:
                                TableCellVerticalAlignment.middle,
                            children: clientWidgets,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class DropdownButtonExample extends StatefulWidget {
  TextEditingController status;
  DropdownButtonExample({super.key, required this.status});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String dropdownValue = list.first;
  String dropdownvalue = 'Ongoing';
  var items = [
    'Ongoing',
    'Completed',
  ];
  @override
  Widget build(BuildContext context) {
    widget.status.text = 'Ongoing';
    return DropdownButton(
      isExpanded: true,
      // Initial Value
      value: dropdownvalue,

      // Down Arrow Icon
      icon: const Icon(Icons.keyboard_arrow_down),

      // Array list of items
      items: items.map((String items) {
        return DropdownMenuItem(
          value: items,
          child: Text(items),
        );
      }).toList(),
      // After selecting the desired option,it will
      // change button value to selected value
      onChanged: (String? newValue) {
        setState(() {
          dropdownvalue = newValue!;
          widget.status.text = newValue;
          print(widget.status.text);
        });
      },
    );
  }
}