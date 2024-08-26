import 'package:cwsdo/widget/admin/totaltally.dart';
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
        List<TableRow> clientWidgets = [
          const TableRow(
            children: <Widget>[
              TcellHeader(
                txtcell: 'S No',
                heightcell: 50,
              ),
              TcellHeader(
                txtcell: 'Family Order No',
                heightcell: 50,
              ),
              TcellHeader(
                txtcell: 'Acting Representative',
                heightcell: 50,
              ),
              TcellHeader(
                txtcell: 'Mobile Number',
                heightcell: 50,
              ),
              TcellHeader(
                txtcell: 'Needs Type',
                heightcell: 50,
              ),
              TcellHeader(
                txtcell: 'Date Registered',
                heightcell: 50,
              ),
              TcellHeader(
                txtcell: 'Action',
                heightcell: 50,
              ),
            ],
          )
        ];

        if (snapshot.hasData) {
          final clients = snapshot.data?.docs.toList();
          for (var client in clients!) {
            final clientWidget = TableRow(
              children: <Widget>[
                const TcellData(
                  txtcell: '1',
                  heightcell: 50,
                ),
                const TcellData(
                  txtcell: '23241',
                  heightcell: 50,
                ),
                TcellData(
                  txtcell: client['fullname'],
                  heightcell: 50,
                ),
                TcellData(
                  txtcell: client['familynum'],
                  heightcell: 50,
                ),
                TcellData(
                  txtcell: client['mobileNum'],
                  heightcell: 50,
                ),
                TcellData(
                  txtcell: client['timeStamp'].toDate().toString(),
                  heightcell: 50,
                ),
                const TcellData(
                  txtcell: 'food assitance',
                  heightcell: 50,
                ),
              ],
            );
            clientWidgets.add(clientWidget);
          }
        }

        // return ListView(
        //   scrollDirection: Axis.vertical,
        //   shrinkWrap: true,
        //   children: clientWidgets,
        // );
        return Table(
          border: TableBorder.all(),
          columnWidths: const <int, TableColumnWidth>{
            //   0: FixedColumnWidth(MediaQuery.of(context).size.width * .14),
            //   1: FixedColumnWidth(MediaQuery.of(context).size.width * .14),
            //   2: FixedColumnWidth(MediaQuery.of(context).size.width * .14),
            //   3: FixedColumnWidth(MediaQuery.of(context).size.width * .14),
            //   4: FixedColumnWidth(MediaQuery.of(context).size.width * .14),
            //   5: FixedColumnWidth(MediaQuery.of(context).size.width * .14),
            //   6: FixedColumnWidth(MediaQuery.of(context).size.width * .14),

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
