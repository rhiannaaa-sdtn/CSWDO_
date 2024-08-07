import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cwsdo/widget/admin/side.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({super.key});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // sidebar,
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: const Color.fromARGB(255, 255, 255, 255), width: 3),
                color: const Color.fromARGB(255, 22, 97, 152),
              ),
              width: 240.0,
              child: const Sidebuttons(),
              // rgb(22, 97, 152)
              // height: MediaQuery.of(context).size.height * .9,
              // height: double.infinity,
              // color: Color.fromARGB(255, 190, 39, 39),
            ),

            // main content
            Expanded(
              flex: 5,
              child: Container(
                width: 100.0,
                // height: MediaQuery.of(context).size.height * .9,
                // height: double.infinity,
                color: const Color.fromARGB(255, 227, 232, 238),
                child: Column(
                  children: <Widget>[
                    //  header
                    Expanded(
                      flex: 1,
                      child: Container(
                        // width: 100.0,
                        // height: MediaQuery.of(context).size.height * .9,
                        // height: double.infinity,
                        color: const Color.fromARGB(255, 22, 97, 152),
                        child: const Padding(
                          padding: EdgeInsets.only(right: 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.notifications,
                                color: Colors.white,
                                size: 30,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              VerticalDivider(
                                color: Colors.white,
                                thickness: 2,
                                endIndent: 10,
                                indent: 10,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                'Admin',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Icon(
                                Icons.account_circle,
                                color: Colors.white,
                                size: 50,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    // content
                    Expanded(
                      flex: 6,
                      child: Container(
                        // width: 100.0,
                        // height: MediaQuery.of(context).size.height * .9,
                        // height: double.infinity,
                        // color: const Color.fromARGB(255, 170, 231, 29),
                        child: const TotalTally(),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TotalTally extends StatelessWidget {
  const TotalTally({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 100,
        left: 100,
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total Tally',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          Column(
            children: [
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .7,
                    color: Colors.amber,
                    child: Text('asda'),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .7,
                    color: Colors.white,
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 50, top: 30, bottom: 30, right: 50),
                          child: TableList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

class TableList extends StatelessWidget {
  const TableList({super.key});

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(),
      columnWidths: <int, TableColumnWidth>{
        0: FixedColumnWidth(MediaQuery.of(context).size.width * .12),
        1: FixedColumnWidth(MediaQuery.of(context).size.width * .12),
        2: FixedColumnWidth(MediaQuery.of(context).size.width * .12),
        3: FixedColumnWidth(MediaQuery.of(context).size.width * .12),
        4: FixedColumnWidth(MediaQuery.of(context).size.width * .12),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: <TableRow>[
        TableRow(
          children: <Widget>[
            Tcell(
              txtcell: 'txtcell',
              heightcell: 50,
              colorcell: Color.fromRGBO(227, 232, 238, 1),
            ),
            Tcell(
              txtcell: 'txtcell',
              heightcell: 50,
              colorcell: Color.fromRGBO(227, 232, 238, 1),
            ),
            Tcell(
              txtcell: 'txtcell',
              heightcell: 50,
              colorcell: Color.fromRGBO(227, 232, 238, 1),
            ),
            Tcell(
              txtcell: 'txtcell',
              heightcell: 50,
              colorcell: Color.fromRGBO(227, 232, 238, 1),
            ),
            Tcell(
              txtcell: 'txtcell',
              heightcell: 50,
              colorcell: Color.fromRGBO(227, 232, 238, 1),
            ),
          ],
        ),
      ],
    );
  }
}

class Tcell extends StatelessWidget {
  final String txtcell;
  final double heightcell;
  final Color colorcell;
  const Tcell(
      {super.key,
      required this.txtcell,
      required this.heightcell,
      required this.colorcell});

  @override
  Widget build(BuildContext context) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Container(
        height: heightcell,
        color: colorcell,
        child: Text(txtcell),
      ),
    );
  }
}
