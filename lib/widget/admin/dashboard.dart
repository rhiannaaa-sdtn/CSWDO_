import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cwsdo/views/admin/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

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

        if (!snapshot.hasData ||
            snapshot.data == null ||
            snapshot.data!.isEmpty) {
          return Center(child: Text('No data available'));
        }

        final docs1 = snapshot.data![0].docs;
        final docs2 = snapshot.data![1].docs;
        print(docs1.length);
        print(docs2.length);

        // Prepare markers based on sample data or Firestore data
        List<Marker> markers = [];
        for (var doc in docs2) {
          var lat = 14.0642; // Default latitude if none found
          var lng = 121.3233; // Default longitude if none found
          markers.add(
            Marker(
              width: 80.0,
              height: 80.0,
              point: LatLng(lat, lng),
              child: Icon(
                Icons.location_on,
                color: Colors.red,
                size: 40.0,
              ),
            ),
          );
        }

        return Padding(
          padding: EdgeInsets.all(1),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DashboardBox(
                    title: 'Total Registered Beneficiary',
                    count: '${docs2.length}',
                    link: '/beneficiarylist',
                  ),
                  DashboardBox(
                    title: 'Ongoing Assistance',
                    count:
                        '${docs1.where((doc) => doc['status'] != 'Completed').length}',
                    link: '/ongoingassistance',
                  ),
                  DashboardBox(
                    title: 'Total Completed Assistance',
                    count:
                        '${docs1.where((doc) => doc['status'] == 'Completed').length}',
                    link: '/completedassitance',
                  ),
                ],
              ),
              Expanded(
                child: FlutterMap(
                  options: MapOptions(
                    center: LatLng(14.0642, 121.3233), // Center of the map
                    zoom: 13,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // OSM Tile Server
                      userAgentPackageName: 'com.example.app',
                    ),
                    MarkerClusterLayerWidget(
                      options: MarkerClusterLayerOptions(
                        markers: markers,
                        polygonOptions: PolygonOptions(
                          borderColor: Colors.blueAccent,
                          // borderWidth: 3,
                          color: Colors.blue.withOpacity(0.4),
                        ),
                        builder: (context, markers) {
                          return FloatingActionButton(
                            onPressed: () {},
                            child: Text(markers.length.toString()),
                          );
                        },
                      ),
                    ),
                  ],
                ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
