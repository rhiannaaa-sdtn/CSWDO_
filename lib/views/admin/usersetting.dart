import 'package:flutter/material.dart';
import 'package:cwsdo/views/admin/side_bar.dart'; // assuming Sidebar is defined elsewhere

class UserSetting extends StatefulWidget {
  const UserSetting({super.key});

  @override
  State<UserSetting> createState() => _UserSettingState();
}

class _UserSettingState extends State<UserSetting> {
  @override
  Widget build(BuildContext context) {
    return const Sidebar(content: Addbeneficiary());
  }
}

class Addbeneficiary extends StatelessWidget {
  const Addbeneficiary({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the screen width
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 50.0, right: 50, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 50.0, right: 50),
              child: SizedBox(
                width: screenWidth * 0.7, // 70% of the screen width
                child: Container(
                  color: Colors.blue, // Just to visualize the width
                  height: 100.0, // Example height
                  child: Center(child: Text('Beneficiary Form')),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
