import 'package:cwsdo/views/admin/side_bar.dart';
import 'package:cwsdo/widget/custom/numberInput.dart';
import 'package:flutter/material.dart';
import 'package:cwsdo/widget/admin/nextStep.dart';
import 'package:cwsdo/widget/admin/totaltally.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TotalOngoingMain extends StatefulWidget {
  const TotalOngoingMain({super.key});

  @override
  State<TotalOngoingMain> createState() => _TotalOngoingMainState();
}

class _TotalOngoingMainState extends State<TotalOngoingMain> {
  @override
  Widget build(BuildContext context) {
    return const Sidebar(content: OngoingList(),title: "Ongoing",);
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
  int _currentPage = 1; // Store the current page here
  final int _itemsPerPage = 5;
  String? _selectedNeed = null; // This will hold the selected need filter

  void _onPageChanged(int newPage) {
    setState(() {
      _currentPage = newPage; // Update the current page
    });
  }

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
                      // Search Bar and Filter Dropdown
                      Row(
                        children: [
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
                          const SizedBox(width: 10),
                          // Add the dropdown filter for "Needs"
                          DropdownButton<String>(
                            hint: Text("Select Needs"),
                            value: _selectedNeed,
                            onChanged: (newValue) {
                              setState(() {
                                _selectedNeed = newValue;
                              });
                            },
                            items: <String>[
                              'Medical Assistance',
                              'Food Assistance',
                              'Other Assistance'
                            ]
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      TableDataList(
                        searchQuery: _searchQuery,
                        currentPage: _currentPage,
                        itemsPerPage: _itemsPerPage,
                        selectedNeed: _selectedNeed, // Pass selectedNeed to filter
                        onPageChanged: _onPageChanged, // Use the callback
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
    required this.selectedNeed, // Add selectedNeed parameter
    required this.onPageChanged, // Add onPageChanged callback
  });

  final String searchQuery;
  final int currentPage;
  final int itemsPerPage;
  final String? selectedNeed;
  final ValueChanged<int> onPageChanged; // This is a callback

  @override
  State<TableDataList> createState() => _TableDataListState();
}

class _TableDataListState extends State<TableDataList> {
  late List<DocumentSnapshot> filteredClients = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('beneficiaries')
          .where('status', isNotEqualTo: 'Completed')
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
        filteredClients = clients!.where((client) {
          final name = client['fullname'].toString().toLowerCase();
          final barangay = client['barangay'].toString().toLowerCase();
          final needs = client['needs'].toString().toLowerCase();
          bool matchesSearchQuery = name.contains(widget.searchQuery) || barangay.contains(widget.searchQuery);

          // Filter by selected need if not null
          bool matchesNeed = widget.selectedNeed == null || needs.contains(widget.selectedNeed!.toLowerCase());

          return matchesSearchQuery && matchesNeed;
        }).toList();

        final totalPages = (filteredClients.length / widget.itemsPerPage).ceil();

        final startIndex = (widget.currentPage - 1) * widget.itemsPerPage;
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
              TcellData(txtcell: client.id, heightcell: 50, pad: 15, fsize: 12),
              TcellData(
                  txtcell: client['barangay'], // Shows the value of barangay
                  heightcell: 50,
                  pad: 15,
                  fsize: 12),
              TcellData(
                  txtcell: client['fullname'],
                  heightcell: 50,
                  pad: 15,
                  fsize: 12),
              TcellData(
                  txtcell: client['gender'],
                  heightcell: 50,
                  pad: 15,
                  fsize: 12),
              TcellData(
                  txtcell: client['civilStatus'],
                  heightcell: 50,
                  pad: 15,
                  fsize: 12),
              TcellData(
                  txtcell: client['dob'],
                  heightcell: 50,
                  pad: 15,
                  fsize: 12),
              TcellData(
                  txtcell: client['mobilenum'],
                  heightcell: 50,
                  pad: 15,
                  fsize: 12),
              TcellData(
                  txtcell: client['needs'],
                  heightcell: 50,
                  pad: 15,
                  fsize: 12),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: const WidgetStatePropertyAll(
                      Color.fromRGBO(33, 79, 215, 1)),
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ))),
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

        return Column(
          children: [
            Table(
              border: TableBorder.all(),
              columnWidths: const <int, TableColumnWidth> {
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
            ),
            PaginationControls(
              currentPage: widget.currentPage,
              itemsPerPage: widget.itemsPerPage,
              searchQuery: widget.searchQuery,
              filteredClients: filteredClients,  // Pass the filtered clients here
              onPageChanged: widget.onPageChanged, // Use the callback to update page
            ),
          ],
        );
      },
    );
  }
}

class PaginationControls extends StatelessWidget {
  const PaginationControls({
    Key? key,
    required this.currentPage,
    required this.itemsPerPage,
    required this.searchQuery,
    required this.onPageChanged,
    required this.filteredClients,  // Add filteredClients here
  }) : super(key: key);

  final int currentPage;
  final int itemsPerPage;
  final String searchQuery;
  final Function(int) onPageChanged;
  final List<DocumentSnapshot> filteredClients;  // Accept filteredClients here

  @override
  Widget build(BuildContext context) {
    // Calculate total number of pages based on filtered clients.
    final totalPages = (filteredClients.length / itemsPerPage).ceil();

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
          onPressed: currentPage < totalPages
              ? () => onPageChanged(currentPage + 1)
              : null,
        ),
      ],
    );
  }
}
