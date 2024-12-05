import 'package:cwsdo/views/admin/side_bar.dart';
import 'package:cwsdo/widget/custom/numberInput.dart';
import 'package:flutter/material.dart';
import 'package:cwsdo/widget/admin/nextStep.dart';
import 'package:cwsdo/widget/admin/totaltally.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:html' as html; // Import dart:html for web storage
import 'dart:io'; // For platform-specific checks
import 'package:flutter/foundation.dart'; // For web-specific checks

class RequestList extends StatefulWidget {
  const RequestList({super.key});

  @override
  State<RequestList> createState() => _RequestListState();
}

class _RequestListState extends State<RequestList> {
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
  String searchQuery = "";
  int currentPage = 0;
  int recordsPerPage = 5;

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
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: TextField(
                          onChanged: (query) {
                            setState(() {
                              searchQuery = query;
                              currentPage = 0;  // Reset to first page when search query changes
                            });
                          },
                          decoration: InputDecoration(
                            labelText: "Search by Fullname",
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.search),
                          ),
                        ),
                      ),
                      // Pass searchQuery, currentPage, and recordsPerPage to TableDataList
                      TableDataList(
                        searchQuery: searchQuery,
                        currentPage: currentPage,
                        recordsPerPage: recordsPerPage,
                        onPageChange: (page) {
                          setState(() {
                            currentPage = page;
                          });
                        },
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
  }
}

class TableDataList extends StatelessWidget {
  final String searchQuery;
  final int currentPage;
  final int recordsPerPage;
  final Function(int) onPageChange;

  const TableDataList({
    super.key,
    required this.searchQuery,
    required this.currentPage,
    required this.recordsPerPage,
    required this.onPageChange,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('beneficiaries')
          .where('barangay', isEqualTo: html.window.localStorage['office'].toString())
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text("Error loading data"));
        }

        final clients = snapshot.data?.docs.toList() ?? [];
        var filteredClients = clients;

        // Apply search filter
        if (searchQuery.isNotEmpty) {
          filteredClients = clients.where((client) {
            return client['fullname'].toString().toLowerCase().contains(searchQuery.toLowerCase());
          }).toList();
        }

        // Calculate total pages
        final totalPages = (filteredClients.length / recordsPerPage).ceil();

        // Ensure pagination works even with an empty list or small list size
        final startIndex = currentPage * recordsPerPage;
        final endIndex = startIndex + recordsPerPage;
        final paginatedClients = filteredClients.isNotEmpty
            ? filteredClients.sublist(
                startIndex,
                endIndex > filteredClients.length ? filteredClients.length : endIndex,
              )
            : [];  // If there are no clients, return an empty list

        List<TableRow> clientWidgets = [
          const TableRow(
            children: <Widget>[
              TcellHeader(
                txtcell: 'Beneficiary No.',
                heightcell: 50,
              ),
              TcellHeader(
                txtcell: 'Fullname',
                heightcell: 50,
              ),
              TcellHeader(
                txtcell: 'Needs',
                heightcell: 50,
              ),
            ],
          )
        ];

        for (var client in paginatedClients) {
          var index = clients.indexOf(client) + 1;
          final clientWidget = TableRow(
            children: <Widget>[
              TcellData(txtcell: client.id, heightcell: 50, pad: 15, fsize: 15),
              TcellData(txtcell: client['fullname'], heightcell: 50, pad: 15, fsize: 15),
              TcellData(txtcell: client['needs'], heightcell: 50, pad: 15, fsize: 15),
            ],
          );
          clientWidgets.add(clientWidget);
        }

        return Column(
          children: [
            Table(
              border: TableBorder.all(),
              columnWidths: const <int, TableColumnWidth>{
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(1),
                2: FlexColumnWidth(1),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: clientWidgets,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: currentPage > 0
                        ? () {
                            onPageChange(currentPage - 1);
                          }
                        : null,
                  ),
                  Text('Page ${currentPage + 1}'),
                  IconButton(
                    icon: Icon(Icons.arrow_forward),
                    onPressed: currentPage < totalPages - 1
                        ? () {
                            onPageChange(currentPage + 1);
                          }
                        : null,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
