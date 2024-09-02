import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cwsdo/views/admin/side_bar.dart';
import 'package:cwsdo/views/request_releif.dart';
// import 'package:cwsdo/widget/custom/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:cwsdo/services/firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';

// import 'package:flutter/src/widgets/framework.dart';

class DashboardMain extends StatefulWidget {
  const DashboardMain({super.key});

  @override
  State<DashboardMain> createState() => _DashboardMainState();
}

class _DashboardMainState extends State<DashboardMain> {
  @override
  Widget build(BuildContext context) {
    return const Sidebar(content: Dashboard());
  }
}

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(50),
      child: Column(
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 1,
                    child: Text(
                      'Dashboard',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    )),
              ]),
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DashboardBox(
                  title: 'Total Registered Beneficiary',
                  count: '8',
                ),
                DashboardBox(
                  title: 'Food Assistance',
                  count: '5',
                ),
                DashboardBox(
                  title: 'Medical Assistance',
                  count: '3',
                ),
              ]),
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DashboardBox(
                  title: 'Total Completed Assistance',
                  count: '',
                ),
                DashboardBox(
                  title: 'Ongoing Assistance',
                  count: '3',
                ),
                DashboardBox(
                  title: 'Relief Request',
                  count: '3',
                ),
              ]),
        ],
      ),
    );
  }
}

class DashboardBox extends StatefulWidget {
  final String title, count;
  const DashboardBox({super.key, required this.title, required this.count});

  @override
  State<DashboardBox> createState() => _DashboardBoxState();
}

class _DashboardBoxState extends State<DashboardBox> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Credential Error'),
                      content: Text(widget.count),
                      actions: <Widget>[
                        TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('OK')),
                      ],
                    );
                  });
            },
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.white, border: Border.all(color: Colors.black)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, bottom: 5),
                    child: Column(
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          widget.count,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 10,
                    color: Colors.amber,
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
