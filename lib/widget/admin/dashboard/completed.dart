import 'package:cwsdo/views/admin/side_bar.dart';
import 'package:cwsdo/widget/custom/numberInput.dart';
import 'package:flutter/material.dart';
import 'package:cwsdo/widget/admin/nextStep.dart';
import 'package:cwsdo/widget/admin/totaltally.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Completed extends StatefulWidget {
  const Completed({super.key});

  @override
  State<Completed> createState() => _CompletedState();
}

class _CompletedState extends State<Completed> {
  @override
  Widget build(BuildContext context) {
    return const Sidebar(content: OngoingList());
  }
}

class OngoingList extends StatefulWidget {
  const OngoingList({super.key});

  @override
  _OngoingListState createState() => _OngoingListState();
}

class _OngoingListState extends State<OngoingList> {
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";
  int _currentPage = 1;
  final int _itemsPerPage = 10;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 50.0, right: 50, bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                color: Color.fromARGB(255, 45, 127, 226),
                height: 30,
                width: double.infinity,
              ),
              Container(
                color: Colors.white,
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.all(18),
                  child: Column(
                    children: [
                      // Search Bar
                      Row(
                        children: [
                          // const Text('Show'),
                          // NumberInputWidget(),
                          // SizedBox(width: 20),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                labelText: 'Search...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onChanged: (query) {
                                setState(() {
                                  _searchQuery = query.toLowerCase();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      TableDataList(
                        searchQuery: _searchQuery,
                        currentPage: _currentPage,
                        itemsPerPage: _itemsPerPage,
                      ),
                      PaginationControls(
                        currentPage: _currentPage,
                        onPageChanged: (int page) {
                          setState(() {
                            _currentPage = page;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class TableDataList extends StatefulWidget {
  const TableDataList({
    super.key,
    required this.searchQuery,
    required this.currentPage,
    required this.itemsPerPage,
  });

  final String searchQuery;
  final int currentPage;
  final int itemsPerPage;

  @override
  State<TableDataList> createState() => _TableDataListState();
}

class _TableDataListState extends State<TableDataList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('beneficiaries')
          .where('status', isEqualTo: 'Completed')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        List<TableRow> clientWidgets = [
          const TableRow(
            children: <Widget>[
              TcellHeader(
                txtcell: 'Beneficiary No.',
                heightcell: 50,
              ),
              TcellHeader(
                txtcell: 'Barangay',
                heightcell: 50,
              ),
              TcellHeader(
                txtcell: 'Fullname',
                heightcell: 50,
              ),
              TcellHeader(
                txtcell: 'Gender',
                heightcell: 50,
              ),
              TcellHeader(
                txtcell: 'Civil Status',
                heightcell: 50,
              ),
              TcellHeader(
                txtcell: 'Birthday (yyyy-mm-dd)',
                heightcell: 50,
              ),
              TcellHeader(
                txtcell: 'Contact',
                heightcell: 50,
              ),
              TcellHeader(
                txtcell: 'Needs',
                heightcell: 50,
              ),
              TcellHeader(
                txtcell: 'Action',
                heightcell: 50,
              ),
            ],
          )
        ];

        final clients = snapshot.data?.docs.toList();
        final filteredClients = clients!.where((client) {
          final name = client['fullname'].toString().toLowerCase();
          final barangay = client['barangay'].toString().toLowerCase();
          return name.contains(widget.searchQuery) ||
              barangay.contains(widget.searchQuery);
        }).toList();

        final startIndex =
            (widget.currentPage - 1) * widget.itemsPerPage;
        final endIndex = startIndex + widget.itemsPerPage;
        final paginatedClients = filteredClients
            .sublist(startIndex, endIndex > filteredClients.length
                ? filteredClients.length
                : endIndex);

        for (var client in paginatedClients) {
          var index = filteredClients.indexOf(client) + 1;
          var txt = index.toString();
          final clientWidget = TableRow(
            children: <Widget>[
              TcellData(txtcell: client.id, heightcell: 50, pad: 15, fsize: 15),
              TcellData(
                  txtcell: client['barangay'],  // This now just shows the value of barangay
                  heightcell: 50,
                  pad: 15,
                  fsize: 15),
              TcellData(
                  txtcell: client['fullname'],
                  heightcell: 50,
                  pad: 15,
                  fsize: 15),
              TcellData(
                  txtcell: client['gender'],
                  heightcell: 50,
                  pad: 15,
                  fsize: 15),
              TcellData(
                  txtcell: client['civilStatus'],
                  heightcell: 50,
                  pad: 15,
                  fsize: 15),
              TcellData(
                  txtcell: client['dob'],
                  heightcell: 50,
                  pad: 15,
                  fsize: 15),
              TcellData(
                  txtcell: client['mobilenum'],
                  heightcell: 50,
                  pad: 15,
                  fsize: 15),
              TcellData(
                  txtcell: client['needs'],
                  heightcell: 50,
                  pad: 15,
                  fsize: 15),
              ElevatedButton(
                style: ButtonStyle(
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
                    backgroundColor: const WidgetStatePropertyAll(
                        Color.fromRGBO(33, 79, 215, 1))),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) =>
                          NextStepMain(requestID: client.id),
                    ),
                  );
                },
                child: Text(
                  'View',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
          clientWidgets.add(clientWidget);
        }

        return Table(
          border: TableBorder.all(),
          columnWidths: const <int, TableColumnWidth>{
            0: FlexColumnWidth(1),
            1: FlexColumnWidth(1),
            2: FlexColumnWidth(1),
            3: FlexColumnWidth(1),
            4: FlexColumnWidth(1),
            5: FlexColumnWidth(1),
            6: FlexColumnWidth(1),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: clientWidgets,
        );
      },
    );
  }
}


class PaginationControls extends StatelessWidget {
  const PaginationControls({
    Key? key,
    required this.currentPage,
    required this.onPageChanged,
  }) : super(key: key);

  final int currentPage;
  final Function(int) onPageChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: currentPage > 1
              ? () => onPageChanged(currentPage - 1)
              : null,
        ),
        Text('Page $currentPage'),
        IconButton(
          icon: Icon(Icons.arrow_forward),
          onPressed: () => onPageChanged(currentPage + 1),
        ),
      ],
    );
  }
}
