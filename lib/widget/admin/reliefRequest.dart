import 'package:cwsdo/views/admin/side_bar.dart';
import 'package:cwsdo/widget/custom/numberInput.dart';
import 'package:cwsdo/widget/custom/table.dart';
import 'package:flutter/material.dart';
import 'package:cwsdo/widget/admin/nextStep.dart';

import 'package:cwsdo/widget/admin/totaltally.dart';

import 'package:cloud_firestore/cloud_firestore.dart';



class ReliefrequestMain extends StatefulWidget {
  const ReliefrequestMain({super.key});

  @override
  State<ReliefrequestMain> createState() => _ReliefrequestMainState();
}

class _ReliefrequestMainState extends State<ReliefrequestMain> {
  @override
  Widget build(BuildContext context) {
    return const Sidebar(content: Reliefrequest());
  }
}

class Reliefrequest extends StatelessWidget {
  const Reliefrequest({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Relief Requests',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            TableSample(),
          ],
        ),
      ),
    );
  }
}

class TableSample extends StatefulWidget {
  const TableSample({super.key});

  @override
  State<TableSample> createState() => _TableSampleState();
}

class _TableSampleState extends State<TableSample> {
  int _rowsPerPage = 5; // Rows per page
  int _currentPage = 0;  // Current page index

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Request').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final clients = snapshot.data?.docs ?? [];
        final totalRows = clients.length;

        // Calculate start and end indices for pagination
        int startIndex = _currentPage * _rowsPerPage;
        int endIndex = (startIndex + _rowsPerPage > totalRows)
            ? totalRows
            : startIndex + _rowsPerPage;

        return Column(
          children: [
            Table(
              border: TableBorder.all(),
              children: [
                const TableRow(
                  children: <Widget>[
                    TcellHeader(txtcell: 'S No', heightcell: 50),
                    TcellHeader(txtcell: 'Family Order No', heightcell: 50),
                    TcellHeader(txtcell: 'Acting Representative of Family', heightcell: 50),
                    TcellHeader(txtcell: 'No. of Family Member', heightcell: 50),
                    TcellHeader(txtcell: 'Mobile Number', heightcell: 50),
                    TcellHeader(txtcell: 'Needs Type', heightcell: 50),
                    TcellHeader(txtcell: 'Date Registered', heightcell: 50),
                    TcellHeader(txtcell: 'Action', heightcell: 50),
                  ],
                ),
                for (int i = startIndex; i < endIndex; i++)
                  TableRow(
                    children: <Widget>[
                      TcellData(txtcell: '${i + 1}', heightcell: 50, pad: 10, fsize: 12),
                      TcellData(txtcell: clients[i].id, heightcell: 50, pad: 10, fsize: 12),
                      TcellData(txtcell: clients[i]['fullname'], heightcell: 50, pad: 10, fsize: 12),
                      TcellData(txtcell: clients[i]['familynum'], heightcell: 50, pad: 10, fsize: 12),
                      TcellData(txtcell: clients[i]['mobileNum'], heightcell: 50, pad: 10, fsize: 12),
                      TcellData(txtcell: clients[i]['needs'], heightcell: 50, pad: 10, fsize: 12),
                      TcellData(txtcell: clients[i]['timeStamp'].toDate().toString(), heightcell: 50, pad: 10, fsize: 12),
                      ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          )),
                          backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(33, 79, 215, 1)),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => NextStepMain(requestID: clients[i].id)),
                          );
                        },
                        child: const Text('View', style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Page ${_currentPage + 1} of ${((totalRows / _rowsPerPage).ceil())}'),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_left),
                      onPressed: _currentPage > 0
                          ? () {
                              setState(() {
                                _currentPage--;
                              });
                            }
                          : null,
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_right),
                      onPressed: endIndex < totalRows
                          ? () {
                              setState(() {
                                _currentPage++;
                              });
                            }
                          : null,
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
