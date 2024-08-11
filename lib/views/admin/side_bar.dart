import 'package:cwsdo/widget/admin/addBeneficiary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cwsdo/widget/admin/side.dart';
import 'package:cwsdo/widget/admin/totaltally.dart';

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
            ),

            // main content
            Expanded(
              flex: 5,
              child: Container(
                width: 100.0,
                color: const Color.fromARGB(255, 227, 232, 238),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //  header
                    Expanded(
                      flex: 1,
                      child: Container(
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
                        // child: const TotalTally(),
                        child: const Addbeneficiary(),
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
