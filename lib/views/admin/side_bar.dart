import 'package:flutter/material.dart';
import 'package:cwsdo/widget/admin/side.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/src/material/dropdown_menu.dart';

class Sidebar extends StatefulWidget {
  final Widget content;
  const Sidebar({super.key, required this.content});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  @override
  Widget build(BuildContext context) {
    String _selectedValue = 'Administrator';
    final FirebaseAuth _auth = FirebaseAuth.instance;

    void _onDropdownChanged(String? newValue) async {
      setState(() {
        _selectedValue = newValue!;
      });

      // Handle the selection
      switch (newValue) {
        case 'Account':
          // Perform action for Account
          print('Account selected');
          break;
        case 'Settings':
          // Perform action for Settings
          print('Settings selected');
          break;
        case 'Logout':

          // Perform action for Logout
          await _auth.signOut();
          Navigator.pushNamed(context, '/');
          print('Logout seleasdcted');
          break;
      }
    }

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
                    SizedBox(
                      height: 80,
                      child: Container(
                        color: const Color.fromARGB(255, 22, 97, 152),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Icon(
                                Icons.notifications,
                                color: Colors.white,
                                size: 30,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              const VerticalDivider(
                                color: Colors.white,
                                thickness: 2,
                                endIndent: 10,
                                indent: 10,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: DropdownButton<String>(
                                  
                                  dropdownColor:
                                      const Color.fromARGB(255, 43, 43, 43),
                                  value: _selectedValue,
                                  onChanged: _onDropdownChanged,
                                  items: <String>[
                                    'Administrator',
                                    // 'Settings',
                                    'Logout'
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    );
                                  }).toList(),
                                  underline:
                                      Container(), // Removes the underline
                                  // You can use any icon you prefer
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              const Icon(
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
                      flex: 8,
                      child: Container(
                          // child: const TotalTally(),
                          // child: const Addbeneficiary(),
                          // child: Reliefrequest()
                          child: widget.content),
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
