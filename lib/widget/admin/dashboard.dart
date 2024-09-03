import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cwsdo/views/admin/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

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
    final s1 = FirebaseFirestore.instance.collection('Request').snapshots();
    final s2 = FirebaseFirestore.instance.collection('Beneficiary').snapshots();

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

        if (!snapshot.hasData ||
            snapshot.data == null ||
            snapshot.data!.isEmpty) {
          return Center(child: Text('No data available'));
        }

        final docs1 = snapshot.data![0].docs;
        final docs2 = snapshot.data![1].docs;
        print(docs1.length);
        print(docs2.length);

        return Padding(
          padding: EdgeInsets.all(50),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      'Dashboard',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DashboardBox(
                      title: 'Total Registered Beneficiary',
                      count: '${docs2.length}',
                      link: '/beneficiarylist'),
                  DashboardBox(
                      title: 'Food Assistance',
                      count:
                          '${docs1.where((doc) => doc['needs'] == 'Food Assistance').length}',
                      link: '/foodassistancelist'),
                  DashboardBox(
                      title: 'Medical Assistance',
                      count:
                          '${docs1.where((doc) => doc['needs'] == 'Medical Assistance').length}',
                      link: '/medicalassistancelist'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DashboardBox(
                      title: 'Total Completed Assistance',
                      count:
                          '${docs1.where((doc) => doc['status'] == 'Completed').length}',
                      link: '/completedassitance'),
                  DashboardBox(
                      title: 'Ongoing Assistance',
                      count:
                          '${docs1.where((doc) => doc['status'] == 'Ongoing').length}',
                      link: '/ongoingassistance'),
                  DashboardBox(
                      title: 'Relief Request',
                      count: '${docs1.length}',
                      link: '/reliefrequest'),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class DashboardBox extends StatefulWidget {
  final String title, count, link;
  const DashboardBox(
      {super.key,
      required this.title,
      required this.count,
      required this.link});

  @override
  State<DashboardBox> createState() => _DashboardBoxState();
}

class _DashboardBoxState extends State<DashboardBox> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            // showDialog(
            //   context: context,
            //   builder: (context) {
            //     return AlertDialog(
            //       title: const Text('Detail'),
            //       content: Text(count),
            //       actions: <Widget>[
            //         TextButton(
            //           onPressed: () => Navigator.of(context).pop(),
            //           child: const Text('OK'),
            //         ),
            //       ],
            //     );
            //   },
            // );

            Navigator.pushNamed(context, widget.link);
          },
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, bottom: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
