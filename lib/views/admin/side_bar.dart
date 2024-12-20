import 'package:flutter/material.dart';
import 'package:cwsdo/widget/admin/side.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/src/material/dropdown_menu.dart';
import 'dart:html' as html; // Import dart:html for web storage
// For platform-specific checks
// For web-specific checks

class Sidebar extends StatefulWidget {
  final Widget content;
  final String title;
  const Sidebar({super.key, required this.content, required this.title});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  @override
  Widget build(BuildContext context) {
    String _selectedValue = html.window.localStorage['office'].toString();
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
          print('Logout selected');
          break;
      }
    }

    return Scaffold(
      body: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Sidebar
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: const Color.fromARGB(255, 255, 255, 255), width: 3),
                color: const Color.fromARGB(255, 22, 97, 152),
              ),
              width: 240.0,
              child: const Sidebuttons(),
            ),

            // Main content
            Expanded(
              flex: 5,
              child: Container(
                width: 100.0,
                color: const Color.fromARGB(255, 227, 232, 238),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Header
                    SizedBox(
                      height: 80,
                      child: Container(
                        color: const Color.fromARGB(255, 22, 97, 152),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Title on the left
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                  widget.title, // Set your title here
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),

                              // Dropdown and account icon on the right
                              Row(
                                children: [
                                  // Uncomment the following lines for notification icon if needed
                                  // const Icon(
                                  //   Icons.notifications,
                                  //   color: Colors.white,
                                  //   size: 30,
                                  // ),
                                  const SizedBox(width: 15),
                                  const VerticalDivider(
                                    color: Colors.white,
                                    thickness: 2,
                                    endIndent: 10,
                                    indent: 10,
                                  ),
                                  const SizedBox(width: 15),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: DropdownButton<String>(
                                      dropdownColor:
                                          const Color.fromARGB(255, 43, 43, 43),
                                      value: _selectedValue,
                                      onChanged: _onDropdownChanged,
                                      items: <String>[
                                        html.window.localStorage['office']
                                            .toString(),
                                        // 'Settings',
                                        'Logout'
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                        );
                                      }).toList(),
                                      underline:
                                          Container(), // Removes the underline
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  const Icon(
                                    Icons.account_circle,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Content
                    Expanded(
                      flex: 8,
                      child: widget.content,
                    ),
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
