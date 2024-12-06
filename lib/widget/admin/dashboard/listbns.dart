import 'package:cwsdo/views/admin/side_bar.dart';
import 'package:cwsdo/widget/custom/numberInput.dart';
import 'package:flutter/material.dart';
import 'package:cwsdo/widget/admin/nextStep.dart';
import 'package:cwsdo/widget/admin/totaltally.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:html' as html; // Import dart:html for web storage
import 'dart:io'; // For platform-specific checks
import 'package:flutter/foundation.dart'; // For web-specific checks
import 'package:firebase_core/firebase_core.dart'; // For Firebase initialization
import 'package:cwsdo/constatns/navitem.dart'; // Import navitem.dart for barangay list

class Listbns extends StatefulWidget {
  const Listbns({super.key});

  @override
  State<Listbns> createState() => _ListbnsState();
}

class _ListbnsState extends State<Listbns> {
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
  String selectedBarangay = 'All'; // Default to "All" to show all barangays

  // Function to show the Add Resident Dialog
  void _showAddResidentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Resident'),
          content: AddResidentForm(barangay: selectedBarangay),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
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
                      // Row with search bar and Add Resident dropdown
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Row(
                          children: [
                            // Search Bar
                            Expanded(
                              child: TextField(
                                onChanged: (query) {
                                  setState(() {
                                    searchQuery = query;
                                    currentPage = 0; // Reset to first page when search query changes
                                  });
                                },
                                decoration: InputDecoration(
                                  labelText: "Search by Fullname",
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.search),
                                ),
                              ),
                            ),
                            SizedBox(width: 10), // Space between search bar and dropdown
                            // Add Resident Dropdown for Barangay Selection (filtering)
                            DropdownButton<String>(
                              value: selectedBarangay,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedBarangay = newValue!;
                                });
                              },
                              items: ['All', ...bgrgyList].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                      // Pass searchQuery, currentPage, selectedBarangay, and recordsPerPage to TableDataList
                      TableDataList(
                        searchQuery: searchQuery,
                        currentPage: currentPage,
                        recordsPerPage: recordsPerPage,
                        selectedBarangay: selectedBarangay, // Pass selected barangay for filtering
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

class AddResidentForm extends StatefulWidget {
  final String barangay; // This will hold the selected barangay

  const AddResidentForm({super.key, required this.barangay});

  @override
  _AddResidentFormState createState() => _AddResidentFormState();
}

class _AddResidentFormState extends State<AddResidentForm> {
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController occupationController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController civilStatusController = TextEditingController();
  final TextEditingController incomeController = TextEditingController();
  String gender = "Male"; // Default gender value

  // Function to handle form submission and add the new resident to Firestore
  void _submitForm() async {
    final fullname = fullnameController.text.trim();
    final occupation = occupationController.text.trim();
    final birthday = birthdayController.text.trim();
    final civilStatus = civilStatusController.text.trim();
    final income = incomeController.text.trim();
    final barangay = widget.barangay; // Get the selected barangay

    if (fullname.isNotEmpty &&
        occupation.isNotEmpty &&
        birthday.isNotEmpty &&
        civilStatus.isNotEmpty &&
        income.isNotEmpty) {
      try {
        // Add data to Firestore
        await FirebaseFirestore.instance.collection('residents').add({
          'fullname': fullname,
          'occupation': occupation,
          'birthday': birthday,
          'civilStatus': civilStatus,
          'income': income,
          'gender': gender,
          'barangay': barangay, // Use the selected barangay
          'createdAt': FieldValue.serverTimestamp(), // Timestamp for record creation
        });

        // Close the dialog
        Navigator.of(context).pop();
      } catch (e) {
        // If an error occurs while adding to Firestore
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } else {
      // Show error if fields are empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: fullnameController,
          decoration: const InputDecoration(
            labelText: 'Fullname',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: occupationController,
          decoration: const InputDecoration(
            labelText: 'Occupation',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: birthdayController,
          decoration: const InputDecoration(
            labelText: 'Birthday',
            border: OutlineInputBorder(),
            hintText: 'YYYY-MM-DD',
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: civilStatusController,
          decoration: const InputDecoration(
            labelText: 'Civil Status',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: incomeController,
          decoration: const InputDecoration(
            labelText: 'Income',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 10),
        // Gender Dropdown
        DropdownButton<String>(
          value: gender,
          onChanged: (String? newValue) {
            setState(() {
              gender = newValue!;
            });
          },
          items: <String>['Male', 'Female', 'Other']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _submitForm,
          child: const Text('Add Resident'),
        ),
      ],
    );
  }
}

class TableDataList extends StatelessWidget {
  final String searchQuery;
  final int currentPage;
  final int recordsPerPage;
  final String selectedBarangay; // New parameter for barangay filter
  final Function(int) onPageChange;

  const TableDataList({
    super.key,
    required this.searchQuery,
    required this.currentPage,
    required this.recordsPerPage,
    required this.selectedBarangay, // Accept selected barangay
    required this.onPageChange,
  });

  @override
  Widget build(BuildContext context) {
    // Firestore query with conditional filtering
    Stream<QuerySnapshot> queryStream;
    if (selectedBarangay == 'All') {
      queryStream = FirebaseFirestore.instance
          .collection('residents')
          .snapshots();
    } else {
      queryStream = FirebaseFirestore.instance
          .collection('residents')
          .where('barangay', isEqualTo: selectedBarangay)
          .snapshots();
    }

    return StreamBuilder<QuerySnapshot>(
      stream: queryStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text("Error loading data"));
        }

        final residents = snapshot.data?.docs.toList() ?? [];
        var filteredResidents = residents;

        // Apply search filter
        if (searchQuery.isNotEmpty) {
          filteredResidents = residents.where((resident) {
            return resident['fullname']
                .toString()
                .toLowerCase()
                .contains(searchQuery.toLowerCase());
          }).toList();
        }

        // Calculate total pages
        final totalPages = (filteredResidents.length / recordsPerPage).ceil();

        // Get the data for the current page
        final startIndex = currentPage * recordsPerPage;
        final endIndex = startIndex + recordsPerPage;
        final currentPageData = filteredResidents
            .sublist(startIndex, endIndex > filteredResidents.length
                ? filteredResidents.length
                : endIndex);

        return Column(
          children: [
            // Table for displaying resident data
            DataTable(
              columns: const [
                DataColumn(label: Text('Full Name')),
                DataColumn(label: Text('Occupation')),
                DataColumn(label: Text('Birthday')),
                DataColumn(label: Text('Civil Status')),
                DataColumn(label: Text('Income')),
                DataColumn(label: Text('Barangay')),
              ],
              rows: currentPageData
                  .map((resident) => DataRow(cells: [
                        DataCell(Text(resident['fullname'])),
                        DataCell(Text(resident['occupation'])),
                        DataCell(Text(resident['birthday'])),
                        DataCell(Text(resident['civilStatus'])),
                        DataCell(Text(resident['income'])),
                        DataCell(Text(resident['barangay'])),
                      ]))
                  .toList(),
            ),
            // Pagination controls
            Row(
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
                Text('Page ${currentPage + 1} of $totalPages'),
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
          ],
        );
      },
    );
  }
}
