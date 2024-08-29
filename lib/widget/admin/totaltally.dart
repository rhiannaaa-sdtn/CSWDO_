import 'package:cwsdo/constatns/navitem.dart';
import 'package:cwsdo/views/admin/side_bar.dart';
import 'package:flutter/material.dart';

class TotalTallyMain extends StatefulWidget {
  const TotalTallyMain({super.key});

  @override
  State<TotalTallyMain> createState() => _TotalTallyMainState();
}

class _TotalTallyMainState extends State<TotalTallyMain> {
  @override
  Widget build(BuildContext context) {
    return const Sidebar(content: TotalTally());
  }
}

class TotalTally extends StatelessWidget {
  const TotalTally({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        // top: 50,
        left: 50,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Total Tally',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          Container(
            width: MediaQuery.of(context).size.width * .78,
            color: const Color.fromARGB(255, 22, 97, 152),
            height: 50,
            // child: Text('asda'),
          ),
          Column(
            children: [
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width * .78,
                color: Colors.white,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Table(
                    border: TableBorder.all(),
                    columnWidths: <int, TableColumnWidth>{
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(1),
                      2: FlexColumnWidth(1),
                      3: FlexColumnWidth(1),
                      4: FlexColumnWidth(1),
                      5: FlexColumnWidth(1),
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: <TableRow>[
                      const TableRow(
                        children: <Widget>[
                          TcellHeader(
                            txtcell: 'BARANGAY NO.',
                            heightcell: 50,
                          ),
                          TcellHeader(
                            txtcell: 'NAME OF BARANGAY',
                            heightcell: 50,
                          ),
                          TcellHeader(
                            txtcell: 'TOTAL BENEFICIARY',
                            heightcell: 50,
                          ),
                          TcellHeader(
                            txtcell: 'FOOD ASSISTANCE',
                            heightcell: 50,
                          ),
                          TcellHeader(
                            txtcell: 'MEDICAL ASSISTANCE',
                            heightcell: 50,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * .60,
                width: MediaQuery.of(context).size.width * .78,
                color: Colors.white,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Table(
                    border: TableBorder.all(),
                    columnWidths: <int, TableColumnWidth>{
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(1),
                      2: FlexColumnWidth(1),
                      3: FlexColumnWidth(1),
                      4: FlexColumnWidth(1),
                      5: FlexColumnWidth(1),
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: <TableRow>[
                      const TableRow(
                        children: <Widget>[
                          TcellHeader(
                            txtcell: 'BARANGAY NO.',
                            heightcell: 0,
                          ),
                          TcellHeader(
                            txtcell: 'NAME OF BARANGAY',
                            heightcell: 0,
                          ),
                          TcellHeader(
                            txtcell: 'TOTAL BENEFICIARY',
                            heightcell: 0,
                          ),
                          TcellHeader(
                            txtcell: 'FOOD ASSISTANCE',
                            heightcell: 0,
                          ),
                          TcellHeader(
                            txtcell: 'MEDICAL ASSISTANCE',
                            heightcell: 0,
                          ),
                        ],
                      ),
                      for (int i = 0; i < bgrgyList.length; i++)
                        TableRow(
                          children: <Widget>[
                            TcellData(
                              txtcell: bgrgyList[i][0],
                              heightcell: 50,
                              pad: 15,
                              fsize: 15,
                            ),
                            TcellData(
                                txtcell: bgrgyList[i][1],
                                heightcell: 50,
                                pad: 15,
                                fsize: 15),
                            const TcellData(
                                txtcell: '2',
                                heightcell: 50,
                                pad: 15,
                                fsize: 15),
                            const TcellData(
                                txtcell: '1',
                                heightcell: 50,
                                pad: 15,
                                fsize: 15),
                            const TcellData(
                                txtcell: '1',
                                heightcell: 50,
                                pad: 15,
                                fsize: 15),
                          ],
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

class TcellHeader extends StatelessWidget {
  final String txtcell;
  final double heightcell;
  // final Color colorcell;
  // final Widget childcell;
  const TcellHeader({
    super.key,
    required this.txtcell,
    required this.heightcell,
    // required this.childcell,
    // required this.colorcell
  });

  @override
  Widget build(BuildContext context) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Container(
        height: heightcell,
        color: const Color.fromARGB(255, 45, 127, 226),
        child: Center(
            child: Text(
          txtcell,
          style: const TextStyle(fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}

class TcellData extends StatelessWidget {
  final String txtcell;
  final double heightcell, pad, fsize;
  // final Color colorcell;
  // final Widget childcell;
  const TcellData({
    super.key,
    required this.txtcell,
    required this.heightcell,
    required this.pad,
    required this.fsize,
    // required this.childcell,
    // required this.colorcell
  });

  @override
  Widget build(BuildContext context) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Container(
        height: heightcell,
        color: const Color.fromRGBO(255, 255, 255, 1),
        child: Padding(
          padding: EdgeInsets.all(pad),
          child: Text(
            txtcell,
            style: TextStyle(fontSize: fsize),
          ),
        ),
      ),
    );
  }
}
