import 'package:cwsdo/views/admin/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:cwsdo/services/firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cwsdo/constatns/navitem.dart'; // Import navitem.dart for bgrgyList
import 'dart:math';

class AddBeneficiaryMain extends StatefulWidget {
  const AddBeneficiaryMain({super.key});

  @override
  State<AddBeneficiaryMain> createState() => _AddBeneficiaryMainState();
}

class _AddBeneficiaryMainState extends State<AddBeneficiaryMain> {
  @override
  Widget build(BuildContext context) {
    return const Sidebar(content: AddBeneficiary());
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
      child: Row(
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
      height: MediaQuery.of(context).size.height * .67,
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _inputBox('Full name', 'Enter Full Name', _fullname),
              _inputBox('Mobile Number', 'Enter Mobile Number', _mobilenum),
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
            _fileUploadRow('Indigency *', pickedfile2, 'type2'),
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
      onChanged: (newValue) {
        setState(() {
          _selectedNeedsType = newValue;
        });
      },
      items: const [
        DropdownMenuItem(value: 'Medical Assistance', child: Text('Medical Assistance')),
        DropdownMenuItem(value: 'Food Assistance', child: Text('Food Assistance')),
      ],
      decoration: const InputDecoration(labelText: 'Type of Needs'),
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

  Widget _inputBox(String label, String hint, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(labelText: label, hintText: hint),
      ),
    );
  }

  Widget _datePickerField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: InkWell(
        onTap: () => selectedDate(controller),
        child: IgnorePointer(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(labelText: label, hintText: 'Pick a date'),
          ),
        ),
      ),
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

  Widget _barangayDropdown() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: DropdownButtonFormField<String>(
        value: _selectedBarangay,
        onChanged: (newValue) {
          setState(() {
            _selectedBarangay = newValue;
          });
        },
        items: bgrgyList.map((barangay) {
          return DropdownMenuItem(value: barangay, child: Text(barangay));
        }).toList(),
        decoration: const InputDecoration(labelText: 'Barangay'),
      ),
    );
  }

  Widget _genderDropdown() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: DropdownButtonFormField<String>(
        value: _selectedGender,
        onChanged: (newValue) {
          setState(() {
            _selectedGender = newValue;
          });
        },
        items: ['Male', 'Female', 'Other'].map((gender) {
          return DropdownMenuItem(value: gender, child: Text(gender));
        }).toList(),
        decoration: const InputDecoration(labelText: 'Gender'),
      ),
    );
  }
}
