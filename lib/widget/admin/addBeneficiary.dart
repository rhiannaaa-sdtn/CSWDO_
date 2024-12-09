import 'package:cwsdo/views/admin/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:cwsdo/services/firestore.dart';
import 'package:cwsdo/widget/admin/dashboard.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cwsdo/constatns/navitem.dart'; // Import navitem.dart for bgrgyList
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

class AddBeneficiaryMain extends StatefulWidget {
  const AddBeneficiaryMain({super.key});

  @override
  State<AddBeneficiaryMain> createState() => _AddBeneficiaryMainState();
}

class _AddBeneficiaryMainState extends State<AddBeneficiaryMain> {
  @override
  Widget build(BuildContext context) {
    return const Sidebar(content: AddBeneficiary(), title:" ");
  }
}

class AddBeneficiary extends StatefulWidget {
  const AddBeneficiary({super.key});

  @override
  _AddBeneficiaryState createState() => _AddBeneficiaryState();
}

class _AddBeneficiaryState extends State<AddBeneficiary> {
  final TextEditingController _fullname = TextEditingController();
  final TextEditingController _mobilenum = TextEditingController();
  final TextEditingController _dob = TextEditingController();
  final TextEditingController _govtidno = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _barangay = TextEditingController();
  final TextEditingController _needs = TextEditingController();
  final TextEditingController _dateRegistered = TextEditingController();

  String? _selectedCivilStatus;
  String? _selectedBarangay; // Add selectedBarangay to store the dropdown value
  String? _selectedNeedsType; // New variable for Type of Needs
  String? _selectedGender; // New variable for Gender dropdown

  PlatformFile? pickedfile1;
  PlatformFile? pickedfile2;
  bool isLoading = false; // Loading state

  Future<void> selectedDate(TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        controller.text = picked.toString().split(" ")[0];
      });
    }
  }

Future<bool> _hasRecentRequest(String fullname) async {
  try {
    // Calculate the date 90 days ago from today
    DateTime today = DateTime.now();
    DateTime ninetyDaysAgo = today.subtract(Duration(days: 90));

    // Query Firestore to find all beneficiaries with the same fullname
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('beneficiaries')
        .where('fullname', isEqualTo: fullname)
        // .orderBy('dateRegistered', descending: true) // Order by dateRegistered
        .get();

    // Loop through the results to find if any dateRegistered is within the last 90 days
    for (var doc in querySnapshot.docs) {
      String dateRegisteredString = doc['dateRegistered'] as String;

      // Convert the string to DateTime
      DateTime dateRegistered = DateFormat('yyyy-MM-dd').parse(dateRegisteredString);

      // Check if the date is within the last 90 days
      if (dateRegistered.isAfter(ninetyDaysAgo)) {
        return true; // Found a recent request
      }
    }

    return false; // No recent request
  } catch (e) {
    _showErrorDialog("Error checking recent requests: $e");
    return false;
  }
}

  void _onSubmit() async {
    if (_fullname.text.isEmpty || _mobilenum.text.isEmpty || _selectedCivilStatus == null || _selectedBarangay == null || _selectedGender == null) {
      _showErrorDialog("Please fill all required fields");
      return;
    }

    // Check if the files are uploaded (Valid ID and Indigency)
    if (pickedfile1 == null || pickedfile2 == null) {
      _showErrorDialog("Please upload both Valid ID and Indigency documents");
      return;
    }

    // Check if the user has made a request in the last 90 days
    bool hasRecentRequest = await _hasRecentRequest(_fullname.text);

    if (hasRecentRequest) {
      _showErrorDialog("You have already made a request within the last 90 days.");
      return; // Stop further processing
    }

    setState(() {
      isLoading = true; // Show loading indicator
    });

    try {
      // Upload files to Firebase Storage
      String? validIdUrl = await _uploadFile(pickedfile1, 'valid_id');
      String? indigencyUrl = await _uploadFile(pickedfile2, 'indigency');

      // Add beneficiary data to Firestore and get documentId
      String documentId = await _addBeneficiaryToFirestore(validIdUrl, indigencyUrl);

      // Clear the fields after saving
      _clearFields();

      // Show success dialog with documentId
      _showSuccessDialog("Beneficiary added successfully!\nDocument ID: $documentId");
    } catch (e) {
      _showErrorDialog("Error adding beneficiary: $e");
    } finally {
      setState(() {
        isLoading = false; // Hide loading indicator after processing
      });
    }
  }

  Future<String?> _uploadFile(PlatformFile? file, String fileType) async {
    if (file == null) return null;

    try {
      final storageRef = FirebaseStorage.instance.ref().child('beneficiaries/$fileType/${file.name}');
      final uploadTask = storageRef.putData(file.bytes!);
      final snapshot = await uploadTask.whenComplete(() => null);
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      _showErrorDialog('Error uploading $fileType: $e');
      return null;
    }
  }

  Future<String> _addBeneficiaryToFirestore(String? validIdUrl, String? indigencyUrl) async {
    try {
      // Firestore document structure for the beneficiary
      String dateToday = DateTime.now().toIso8601String().substring(0, 10).replaceAll('-', ''); // Get date in yyyyMMdd format
      int randomFourDigitNumber = Random().nextInt(9000) + 1000; // Generate a random 4-digit number

      String documentId = '$dateToday$randomFourDigitNumber'; // Combine both to form the document ID

      await FirebaseFirestore.instance.collection('beneficiaries').doc(documentId).set({
        'fullname': _fullname.text,
        'mobilenum': _mobilenum.text,
        'dob': _dob.text,
        'civilStatus': _selectedCivilStatus,
        'gender': _selectedGender, // Use selectedGender
        'address': _address.text,
        'barangay': _selectedBarangay, // Use selectedBarangay
        'needs': _selectedNeedsType, // Use selectedNeedsType
        'dateRegistered': _dateRegistered.text,
        'validId': validIdUrl,
        'indigency': indigencyUrl,
        'status': 'Ongoing',
      });

      return documentId;
    } catch (e) {
      _showErrorDialog("Error adding beneficiary to Firestore: $e");
      rethrow; // Rethrow to handle the error at the calling site
    }
  }

  Future<void> _selectedFile(String type) async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      if (type == 'type1') pickedfile1 = result.files.first;
      if (type == 'type2') pickedfile2 = result.files.first;
    });
  }

  void _clearFields() {
    _fullname.clear();
    _mobilenum.clear();
    _dob.clear();
    _govtidno.clear();
    _address.clear();
    _barangay.clear();
    _needs.clear();
    _dateRegistered.clear();
    _selectedCivilStatus = null;
    _selectedBarangay = null; // Clear the selectedBarangay value
    _selectedNeedsType = null; // Clear the selectedNeedsType
    _selectedGender = null; // Clear the selectedGender
    pickedfile1 = null;
    pickedfile2 = null;
  }

  // Method to show error dialog
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Method to show success dialog
  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Success"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

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


    return Padding(
          padding: EdgeInsets.all(0),
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
 child:
     Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 0.0),
      child:
          Row(
            children: [
              // Left Column: Personal Information
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 50.0),
                  child: Column(
                    children: [
                      _sectionHeader('Personal Information'),
                      _personalInformationForm(),
                    ],
                  ),
                ),
              ),
              // Right Column: Needs Information and File Uploads
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 50.0),
                  child: Column(
                    children: [
                      _sectionHeader('Needs Information'),
                      _needsInformationForm(),
                    ],
                  ),
                ),
              ),
            ],
          ),
       
    ),
              ),
            ],
          ),
        );
    
    
    
    


        },
    );




  }

  Widget _sectionHeader(String title) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .8,
      child: Container(
        color: const Color.fromARGB(255, 22, 97, 152),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }

  Widget _personalInformationForm() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .8,
      height: MediaQuery.of(context).size.height * .60,
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _inputBox('Full name', 'Enter Full Name', _fullname),
              
                TextFormField(
  controller: _mobilenum,
  decoration: InputDecoration(
    labelText: 'Mobile Number',
    hintText: 'Enter Mobile Number',
  ),
  keyboardType: TextInputType.number, // This will show a numeric keyboard.
  inputFormatters: <TextInputFormatter>[
    FilteringTextInputFormatter.digitsOnly, // This ensures only digits are allowed.
  ],
),
              _datePickerField('Date of Birth', _dob),
              _dropdownField(),
              _genderDropdown(), // Gender Dropdown
              _inputBox('Address', 'Enter Address', _address),
              _barangayDropdown(),
              // _datePickerField('Request Date', _dateRegistered),
            ],
          ),
        ),
      ),
    );
  }

  Widget _needsInformationForm() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .8,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _needsTypeDropdown(),
            _datePickerField('Request Date', _dateRegistered),
            const SizedBox(height: 30),
            _fileUploadRow('Document', pickedfile1, 'type1'),
            _fileUploadRow('Indigency', pickedfile2, 'type2'),
            const SizedBox(height: 20),
           
            _submitButton(),
          ],
        ),
      ),
    );
  }

  Widget _needsTypeDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedNeedsType,
      decoration: const InputDecoration(labelText: 'Type of Needs'),
      items: ['Medical Assistance', 'Food Assistance', 'Other Assistance']
          .map((needs) => DropdownMenuItem(
                value: needs,
                child: Text(needs),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          _selectedNeedsType = value;
        });
      },
    );
  }



  Widget _dropdownField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: DropdownButtonFormField<String>(
        value: _selectedCivilStatus,
        onChanged: (newValue) {
          setState(() {
            _selectedCivilStatus = newValue;
          });
        },
        items: ['Single', 'Married', 'Widowed', 'Separated'].map((option) {
          return DropdownMenuItem(value: option, child: Text(option));
        }).toList(),
        decoration: InputDecoration(labelText: 'Civil Status'),
      ),
    );
  }

  Widget _genderDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedGender,
      decoration: const InputDecoration(labelText: 'Gender'),
      items: ['Male', 'Female']
          .map((gender) => DropdownMenuItem(
                value: gender,
                child: Text(gender),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          _selectedGender = value;
        });
      },
    );
  }

  Widget _barangayDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedBarangay,
      decoration: const InputDecoration(labelText: 'Barangay'),
      items: bgrgyList
          .map((barangay) => DropdownMenuItem(
                value: barangay,
                child: Text(barangay),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          _selectedBarangay = value;
        });
      },
    );
  }

  Widget _submitButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        isLoading
            ? const CircularProgressIndicator()
            : ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  backgroundColor:
                      const MaterialStatePropertyAll(Color.fromRGBO(78, 115, 222, 1))),
                onPressed: _onSubmit,
                child: const Text(
                  'Submit',
                  style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
      ],
    );
  }

  Widget _datePickerField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(labelText: label),
      onTap: () => selectedDate(controller),
    );
  }

  Widget _inputBox(String label, String hint, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
      ),
    );
  }

   Widget _fileUploadRow(String label, PlatformFile? pickedFile, String type) {
    return Row(
      children: [
        const Icon(size: 40, Icons.image),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label),
            pickedFile != null
                ? Text(
                    pickedFile.name,
                    style: const TextStyle(fontSize: 12, color: Colors.blue),
                  )
                : const Text(
                    'No file selected',
                    style: TextStyle(fontSize: 12, color: Colors.red),
                  ),
          ],
        ),
        IconButton(
          onPressed: () => _selectedFile(type),
          icon: const Icon(Icons.upload_file),
        ),
      ],
    );
  }

}
