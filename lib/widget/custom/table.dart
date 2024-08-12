import 'package:flutter/material.dart';

class TableSample extends StatelessWidget {
  const TableSample({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowColor:
            MaterialStateProperty.all<Color>(Color.fromRGBO(78, 115, 222, 1)),
        decoration: BoxDecoration(
            // color: Color.fromRGBO(78, 115, 222, 1),
            border: Border.all(
          color: Colors.black, // Border color for the DataTable
          width: 1, // Border width
        )),
        columns: const [
          DataColumn(label: Text('S No')),
          DataColumn(label: Text('Family Order No')),
          DataColumn(label: Text('Acting Representative')),
          DataColumn(label: Text('No of Family Members')),
          DataColumn(label: Text('Mobile Number')),
          DataColumn(label: Text('Needs Type')),
          DataColumn(label: Text('Date Registered')),
          DataColumn(label: Text('Action')),
        ],
        rows: const [
          DataRow(cells: [
            DataCell(Text('1')),
            DataCell(Text('FO123')),
            DataCell(Text('John Doe')),
            DataCell(Text('3')),
            DataCell(Text('123-456-7890')),
            DataCell(Text('Medical')),
            DataCell(Text('2024-08-11')),
            DataCell(Text('Edit')),
          ]),
          DataRow(cells: [
            DataCell(Text('2')),
            DataCell(Text('FO124')),
            DataCell(Text('Jane Smith')),
            DataCell(Text('2')),
            DataCell(Text('098-765-4321')),
            DataCell(Text('Food')),
            DataCell(Text('2024-08-12')),
            DataCell(Text('Edit')),
          ]),
          // Add more rows as needed
        ],
      ),
    );
  }
}
