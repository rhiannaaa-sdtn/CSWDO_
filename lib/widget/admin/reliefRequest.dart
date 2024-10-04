import 'package:cwsdo/views/admin/side_bar.dart';
import 'package:cwsdo/widget/custom/numberInput.dart';
import 'package:cwsdo/widget/custom/table.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// import 'package:cwsdo/widget/admin/addBeneficiary.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:cwsdo/widget/admin/totaltally.dart';
// import 'package:cwsdo/widget/admin/reliefRequest.dart';

class ReliefrequestMain extends StatefulWidget {
  const ReliefrequestMain({super.key});

  @override
  State<ReliefrequestMain> createState() => _ReliefrequestMainState();
}

class _ReliefrequestMainState extends State<ReliefrequestMain> {
  @override
  Widget build(BuildContext context) {
    return const Sidebar(content: Reliefrequest());
  }
}

class Reliefrequest extends StatelessWidget {
  const Reliefrequest({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 10.0, left: 50.0, right: 50, bottom: 20),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Relief Request',
              style: TextStyle(fontSize: 20),
            ),
            Column(
              children: [
                Container(
                  color: Color.fromARGB(255, 45, 127, 226),
                  height: 30,
                  width: double.infinity,
                  // child: Tex t('data'),
                ),
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 18,left: 18,right: 18),
                    child: Column(
                      children: [
                        Container(
                          child: const Row(children: [
                            Text(
                              'Show',
                            ),
                            NumberInputWidget()
                          ]),
                        ),
                        const TableSample(),
                      ],
                    ),
                  ),
                  // child: Tex t('data'),
                )
              ],
            ),
          ]),
    );
  }
}
