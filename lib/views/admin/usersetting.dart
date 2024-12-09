import 'package:flutter/material.dart';
import 'package:cwsdo/views/admin/side_bar.dart';
import 'package:cwsdo/constatns/navitem.dart'; // Import navitem.dart for officeList
import 'package:firebase_auth/firebase_auth.dart'; // For Firebase Authentication
import 'package:cloud_firestore/cloud_firestore.dart'; // For Firestore
import 'package:firebase_core/firebase_core.dart'; // To initialize Firebase if needed

class UserSetting extends StatefulWidget {
  const UserSetting({super.key});

  @override
  State<UserSetting> createState() => _UserSettingState();
}

class _UserSettingState extends State<UserSetting> {
  @override
  Widget build(BuildContext context) {
    return const Sidebar(content: AddBeneficiary(),title: 'User Setting');
  }
}

class AddBeneficiary extends StatefulWidget {
  const AddBeneficiary({super.key});

  @override
  _AddBeneficiaryState createState() => _AddBeneficiaryState();
}

class _AddBeneficiaryState extends State<AddBeneficiary> {
  TextEditingController _searchController = TextEditingController();
  List<DocumentSnapshot> _filteredUsers = [];
  List<DocumentSnapshot> _allUsers = [];

  // Function to filter the users based on the search query
  void _filterUsers(String query) {
    List<DocumentSnapshot> filtered = _allUsers.where((user) {
      String fullName = user['fullName'].toLowerCase();
      String email = user['email'].toLowerCase();
      return fullName.contains(query.toLowerCase()) || email.contains(query.toLowerCase());
    }).toList();

    setState(() {
      _filteredUsers = filtered;
    });
  }

  // Function to show the dialog for adding a new user
  void _showAddUserDialog(BuildContext context) {
    final TextEditingController fullNameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController = TextEditingController();

    String? selectedOffice;

    List<String> offices = officeList; // Assuming officeList is a List<String> in navitem.dart

    double screenWidth = MediaQuery.of(context).size.width;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New User'),
          content: ConstrainedBox(
            constraints: BoxConstraints(minWidth: screenWidth * 0.8),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Full Name and Office Dropdown
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: fullNameController,
                          decoration: const InputDecoration(
                            labelText: 'Full Name',
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: selectedOffice,
                          hint: const Text('Select Office'),
                          onChanged: (String? newValue) {
                            selectedOffice = newValue;
                          },
                          items: offices.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Email
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            labelText: 'Email Address',
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Password and Confirm Password
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: passwordController,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                          ),
                          obscureText: true,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: confirmPasswordController,
                          decoration: const InputDecoration(
                            labelText: 'Confirm Password',
                          ),
                          obscureText: true,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          actions: [
            // Cancel Button
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            // Submit Button
            TextButton(
              onPressed: () async {
                List<String> errorMessages = [];

                // Validate required fields
                if (fullNameController.text.isEmpty) {
                  errorMessages.add('Full Name is required');
                }
                if (emailController.text.isEmpty) {
                  errorMessages.add('Email Address is required');
                }
                if (passwordController.text.isEmpty) {
                  errorMessages.add('Password is required');
                }
                if (confirmPasswordController.text.isEmpty) {
                  errorMessages.add('Confirm Password is required');
                }
                if (selectedOffice == null || selectedOffice!.isEmpty) {
                  errorMessages.add('Office is required');
                }
                if (passwordController.text != confirmPasswordController.text) {
                  errorMessages.add('Passwords do not match');
                }

                if (errorMessages.isNotEmpty) {
                  // Show error dialog with all issues
                  _showErrorDialog(context, errorMessages);
                } else {
                  try {
                    // Step 1: Create a new user with Firebase Authentication
                    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text,
                    );

                    // Step 2: Store additional user details in Firestore (no 'role' field)
                    await FirebaseFirestore.instance.collection('users').doc(userCredential.user?.uid).set({
                      'fullName': fullNameController.text,
                      'email': emailController.text,
                      'office': selectedOffice,
                      'createdAt': FieldValue.serverTimestamp(),
                    });

                    // Success! Close the dialog and show success message
                    Navigator.of(context).pop();
                    _showSuccessDialog(context, 'User successfully added!');
                  } on FirebaseAuthException catch (e) {
                    // Handle Firebase errors here
                    _showErrorDialog(context, [e.message ?? 'Error occurred']);
                  }
                }
              },
              child: const Text('Add User'),
            ),
          ],
        );
      },
    );
  }

  // Function to show a success dialog
  void _showSuccessDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Success'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Function to show an error dialog
  void _showErrorDialog(BuildContext context, List<String> errorMessages) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var errorMessage in errorMessages)
                  Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the error dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 50.0, right: 50, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // White Container with text and button, and the search bar inside it
          Container(
            color: Colors.white, // White background for the entire section
            padding: const EdgeInsets.all(20.0), // Padding inside the white container
            child: Column(
              children: [
                // Row for "Manage Users" text, search bar and "Add New User" button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center, // Center the children horizontally
                  crossAxisAlignment: CrossAxisAlignment.center, // Vertically align items in the center
                  children: [
                    // Manage Users Text
                    const Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(left: 50.0),
                        child: Text('Manage users', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    
                    // Search Bar (in the middle)
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 20),
                    //   child: SizedBox(
                    //     width: screenWidth * 0.3, // Set a width for the search bar
                    //     child: TextField(
                    //       controller: _searchController,
                    //       decoration: const InputDecoration(
                    //         labelText: 'Search by Name or Email',
                    //         prefixIcon: Icon(Icons.search),
                    //         border: OutlineInputBorder(),
                    //       ),
                    //       onChanged: (query) {
                    //         _filterUsers(query); // Call the filter function
                    //       },
                    //     ),
                    //   ),
                    // ),

                    // Add New User Button
                    ElevatedButton(
                      onPressed: () {
                        // Show the add new user dialog
                        _showAddUserDialog(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, // Set the button color
                      ),
                      child: const Text(
                        'Add New User',
                        style: TextStyle(color: Colors.white), // White text color
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20), // Space between the row and the user list
              ],
            ),
          ),
          const SizedBox(height: 20), // Space between the white container and user list

          // User List
          StreamBuilder<QuerySnapshot>( 
            stream: FirebaseFirestore.instance.collection('users').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              var users = snapshot.data!.docs;
              _allUsers = users;  // Storing the all users for filtering
              _filteredUsers = users; // Initially show all users

              return Expanded(
                child: ListView.builder(
                  itemCount: _filteredUsers.length,
                  itemBuilder: (context, index) {
                    var user = _filteredUsers[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      child: ListTile(
                        title: Text(user['fullName']),
                        subtitle: Text('${user['email']}\nOffice: ${user['office']}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            // Delete user from Firestore
                            try {
                              await FirebaseFirestore.instance.collection('users').doc(user.id).delete();
                              _showSuccessDialog(context, 'User deleted successfully');
                            } catch (e) {
                              _showErrorDialog(context, ['Error deleting user: $e']);
                            }
                          },
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
