import 'package:cwsdo/constatns/navitem.dart';
import 'package:cwsdo/views/admin/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class TotalTallyMain extends StatefulWidget {
  const TotalTallyMain({super.key});

  @override
  State<TotalTallyMain> createState() => _TotalTallyMainState();
}

class _TotalTallyMainState extends State<TotalTallyMain> {
  @override
  Widget build(BuildContext context) {
    return const Sidebar(content: TotalTally());
  }
}

class TotalTally extends StatefulWidget {
  const TotalTally({super.key});

  @override
  State<TotalTally> createState() => _TotalTallyState();
}

class _TotalTallyState extends State<TotalTally> {
  // Controller for the search bar
  TextEditingController searchController = TextEditingController();
  final ValueNotifier<String> searchQueryNotifier = ValueNotifier<String>('');

  @override
  void dispose() {
    searchController.dispose();
    searchQueryNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s1 = FirebaseFirestore.instance.collection('beneficiaries').snapshots();
    final s2 = FirebaseFirestore.instance.collection('residents').snapshots();

    return StreamBuilder<List<QuerySnapshot>>(
      stream: Rx.combineLatest2(
        s1,
        s2,
        (QuerySnapshot snap1, QuerySnapshot snap2) => [snap1, snap2],
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
          return Center(child: Text('No data available'));
        }

        final docs1 = snapshot.data![0].docs;
        final docs2 = snapshot.data![1].docs;

        return ValueListenableBuilder<String>(
          valueListenable: searchQueryNotifier,
          builder: (context, searchQuery, _) {
            // Filter barangay list based on search query
            List<String> filteredBarangayList = bgrgyList
                .where((barangay) => barangay.toLowerCase().contains(searchQuery.toLowerCase()))
                .toList();

            return Padding(
              padding: const EdgeInsets.only(left: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row for Title and Search Bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'Total Tally',
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 20), // Space between title and search bar
                      // Search Bar
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 300, // You can adjust this width
                          child: TextField(
                            controller: searchController,
                            onChanged: (value) {
                              searchQueryNotifier.value = value;  // Update the search query without using setState()
                            },
                            decoration: InputDecoration(
                              labelText: 'Search by Barangay',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              suffixIcon: Icon(Icons.search),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .78,
                    color: const Color.fromARGB(255, 22, 97, 152),
                    height: 50,
                  ),
                  Column(
                    children: [
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * .78,
                        color: Colors.white,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Table(
                            border: TableBorder.all(),
                            columnWidths: <int, TableColumnWidth>{
                              0: FlexColumnWidth(1),
                              1: FlexColumnWidth(1),
                              2: FlexColumnWidth(1),
                              3: FlexColumnWidth(1),
                              4: FlexColumnWidth(1),
                              5: FlexColumnWidth(1),
                            },
                            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                            children: <TableRow>[
                              const TableRow(
                                children: <Widget>[
                                  TcellHeader(txtcell: 'BARANGAY NO.', heightcell: 50),
                                  TcellHeader(txtcell: 'NAME OF BARANGAY', heightcell: 50),
                                  TcellHeader(txtcell: 'TOTAL BENEFICIARY', heightcell: 50),
                                  TcellHeader(txtcell: 'FOOD ASSISTANCE', heightcell: 50),
                                  TcellHeader(txtcell: 'MEDICAL ASSISTANCE', heightcell: 50),
                                  TcellHeader(txtcell: 'Other ASSISTANCE', heightcell: 50),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * .55,
                        width: MediaQuery.of(context).size.width * .78,
                        color: Colors.white,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Table(
                            border: TableBorder.all(),
                            columnWidths: <int, TableColumnWidth>{
                              0: FlexColumnWidth(1),
                              1: FlexColumnWidth(1),
                              2: FlexColumnWidth(1),
                              3: FlexColumnWidth(1),
                              4: FlexColumnWidth(1),
                              5: FlexColumnWidth(1),
                              5: FlexColumnWidth(1),
                            },
                            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                            children: <TableRow>[
                              const TableRow(
                                children: <Widget>[
                                  TcellHeader(txtcell: 'BARANGAY NO.', heightcell: 0),
                                  TcellHeader(txtcell: 'NAME OF BARANGAY', heightcell: 0),
                                  TcellHeader(txtcell: 'TOTAL BENEFICIARY', heightcell: 0),
                                  TcellHeader(txtcell: 'FOOD ASSISTANCE', heightcell: 0),
                                  TcellHeader(txtcell: 'MEDICAL ASSISTANCE', heightcell: 0),
                                  TcellHeader(txtcell: 'Other ASSISTANCE', heightcell: 0),
                                ],
                              ),
                              for (int i = 0; i < filteredBarangayList.length; i++)
                                TableRow(
                                  children: <Widget>[
                                    TcellData(
                                      txtcell: (i + 1).toString(),
                                      heightcell: 50,
                                      pad: 15,
                                      fsize: 15,
                                    ),
                                    TcellData(
                                      txtcell: filteredBarangayList[i],
                                      heightcell: 50,
                                      pad: 15,
                                      fsize: 15,
                                    ),
                                    TcellData(
                                      txtcell:
                                          '${docs2.where((doc) => doc['barangay'] == filteredBarangayList[i]).length}',
                                      heightcell: 50,
                                      pad: 15,
                                      fsize: 15,
                                    ),
                                    TcellData(
                                      txtcell:
                                          '${docs1.where((doc) => doc['needs'] == 'Food Assistance').where((doc) => doc['barangay'] == filteredBarangayList[i]).length}',
                                      heightcell: 50,
                                      pad: 15,
                                      fsize: 15,
                                    ),
                                    TcellData(
                                      txtcell:
                                          '${docs1.where((doc) => doc['needs'] == 'Medical Assistance').where((doc) => doc['barangay'] == filteredBarangayList[i]).length}',
                                      heightcell: 50,
                                      pad: 15,
                                      fsize: 15,
                                    ),TcellData(
                                      txtcell:
                                          '${docs1.where((doc) => doc['needs'] == 'Other Assistance').where((doc) => doc['barangay'] == filteredBarangayList[i]).length}',
                                      heightcell: 50,
                                      pad: 15,
                                      fsize: 15,
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
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

class TcellHeader extends StatelessWidget {
  final String txtcell;
  final double heightcell;

  const TcellHeader({
    super.key,
    required this.txtcell,
    required this.heightcell,
  });

  @override
  Widget build(BuildContext context) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Container(
        height: heightcell,
        color: const Color.fromARGB(255, 45, 127, 226),
        child: Center(
            child: Text(
          txtcell,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        )),
      ),
    );
  }
}

class TcellData extends StatelessWidget {
  final String txtcell;
  final double heightcell, pad, fsize;

  const TcellData({
    super.key,
    required this.txtcell,
    required this.heightcell,
    required this.pad,
    required this.fsize,
  });

  @override
  Widget build(BuildContext context) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Container(
        height: heightcell,
        color: const Color.fromRGBO(255, 255, 255, 1),
        child: Padding(
          padding: EdgeInsets.all(pad),
          child: Text(
            txtcell,
            style: TextStyle(fontSize: fsize),
          ),
        ),
      ),
    );
  }
}
