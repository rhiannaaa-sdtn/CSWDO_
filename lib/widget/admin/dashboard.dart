import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cwsdo/views/admin/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter_map_heatmap/flutter_map_heatmap.dart';
import 'package:flutter/services.dart';
import 'package:cwsdo/constatns/navitem.dart';
import 'package:intl/intl.dart'; // Import the intl package

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
                    link: '/listbns',
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
 child:Heatmap() ,
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







class Heatmap extends StatefulWidget {
  Heatmap({Key? key,}) : super(key: key);

  @override
  _HeatmapState createState() => _HeatmapState();
}

class _HeatmapState extends State<Heatmap> {
  StreamController<void> _rebuildStream = StreamController.broadcast();
  List<WeightedLatLng> data = [];
  List<Map<double, MaterialColor>> gradients = [
    HeatMapOptions.defaultGradient,
    {0.25: Colors.blue, 0.55: Colors.red, 0.85: Colors.pink, 1.0: Colors.purple}
  ];

  var index = 0;

  initState() {
    _loadData();
    super.initState();
  }

  @override
  dispose() {
    _rebuildStream.close();
    super.dispose();
  }


_loadData() async {
  var now = DateTime.now();
  var formatter = DateFormat('yyyy-MM-dd');
  var today = formatter.format(now);
  var thirtyDaysAgo = now.subtract(Duration(days: 30));
  var thirtyDaysAgoFormatted = formatter.format(thirtyDaysAgo);

  var beneficiaryData = await FirebaseFirestore.instance
      .collection('beneficiaries')
      .where('dateRegistered', isGreaterThanOrEqualTo: thirtyDaysAgoFormatted)
      .get();

  var coor = "";

  for (var i = 0; i < beneficiaryData.docs.length; i++) {
    var doc = beneficiaryData.docs[i];
    var barangay = doc['barangay'].toString();
    print(brgycoor[barangay]);

    if (i == 0) {
      coor = "[" + brgycoor[barangay].toString() + "]";
    } else {
      coor = coor + ",[" + brgycoor[barangay].toString() + "]";
    }
  }

  var str = "[" + coor + "]";
  print(str);

  List<dynamic> result = jsonDecode(str);

  // Ensure the widget is still mounted before calling setState
  if (mounted) {
    setState(() {
      data = result
          .map((e) => e as List<dynamic>)
          .map((e) => WeightedLatLng(LatLng(e[0], e[1]), 1))
          .toList();
    });
  }
}


  void _incrementCounter() {
    setState(() {
      index = index == 0 ? 1 : 0;
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _rebuildStream.add(null);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _rebuildStream.add(null);
    });

    final map = new FlutterMap(
      options: new MapOptions(
          initialCenter: new LatLng(14.06351681625969, 121.31892008458746), initialZoom: 14.0),
      children: [
        TileLayer(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png"),
        if (data.isNotEmpty)
          HeatMapLayer(
            heatMapDataSource: InMemoryHeatMapDataSource(data: data),
            heatMapOptions: HeatMapOptions(
                gradient: this.gradients[this.index], minOpacity: 0.1),
            reset: _rebuildStream.stream,
          )
      ],
    );
    return  Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Container(child: map),
      );
  }
}