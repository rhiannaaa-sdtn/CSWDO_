import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TableSample extends StatefulWidget {
  const TableSample({super.key});

  @override
  State<TableSample> createState() => _TableSampleState();
}

class _TableSampleState extends State<TableSample> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Request').snapshots(),
      builder: (context, snapshot) {
        List<Row> clientWidgets = [
          Row(
            children: [
              Text('fullname'),
              SizedBox(
                width: 50,
              ),
              Text('address'),
              SizedBox(
                width: 50,
              ),
              Text('barangay'),
            ],
          )
        ];

        if (snapshot.hasData) {
          final clients = snapshot.data?.docs.reversed.toList();
          for (var client in clients!) {
            final clientWidget = Row(
              children: [
                Text(client['fullname']),
                SizedBox(
                  width: 50,
                ),
                Text(client['address']),
                SizedBox(
                  width: 50,
                ),
                Text(client['barangay']),
              ],
            );
            clientWidgets.add(clientWidget);
          }
        }

        return ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: clientWidgets,
        );
      },
    );
  }
}
