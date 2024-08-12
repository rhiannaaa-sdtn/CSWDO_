import 'package:cwsdo/widget/custom/numberInput.dart';
import 'package:cwsdo/widget/custom/table.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
              style: TextStyle(fontSize: 30),
            ),
            Container(
              child: Row(children: [
                const Text(
                  'Show',
                ),
                NumberInputWidget()
              ]),
            ),
            const TableSample(),
          ]),
    );
  }
}
