import 'package:cwsdo/views/admin/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:cwsdo/services/firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

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
  final TextEditingController _civilStatus = TextEditingController();
  final TextEditingController _govtidno = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _barangay = TextEditingController();
  final TextEditingController _needs = TextEditingController();
  final TextEditingController _dateRegistered = TextEditingController();

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
    if (_fullname.text.isEmpty || _mobilenum.text.isEmpty) {
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

      // Add beneficiary data to Firestore
      await _addBeneficiaryToFirestore(validIdUrl, indigencyUrl);

      // Clear the fields after saving
      _clearFields();

      _showSuccessDialog("Beneficiary added successfully!");
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

  Future<void> _addBeneficiaryToFirestore(String? validIdUrl, String? indigencyUrl) async {
    try {
      // Firestore document structure for the beneficiary
      await FirebaseFirestore.instance.collection('beneficiaries').add({
        'fullname': _fullname.text,
        'mobilenum': _mobilenum.text,
        'dob': _dob.text,
        'civilStatus': _civilStatus.text,
        'govtidno': _govtidno.text,
        'address': _address.text,
        'barangay': _barangay.text,
        'needs': _needs.text,
        'dateRegistered': _dateRegistered.text,
        'validId': validIdUrl,
        'indigency': indigencyUrl,
      });
      print("Beneficiary added to Firestore!");
    } catch (e) {
      _showErrorDialog("Error adding beneficiary to Firestore: $e");
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
    _civilStatus.clear();
    _govtidno.clear();
    _address.clear();
    _barangay.clear();
    _needs.clear();
    _dateRegistered.clear();
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
              _inputBox('Civil Status', 'Enter Civil Status', _civilStatus),
              _inputBox('Gender', 'Enter Gender', _govtidno),
              _inputBox('Address', 'Enter Address', _address),
              _inputBox('Barangay', 'Enter Barangay', _barangay),
            ],
          ),
        ),
      ),
    );
  }

  Widget _needsInformationForm() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.64,
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _inputBox('Needs Type', 'Enter Need Type', _needs),
              _datePickerField('Date Registered', _dateRegistered),
              _fileUploadRow('Valid ID *', pickedfile1, 'type1'),
              _fileUploadRow('Indigency *', pickedfile2, 'type2'),
              _submitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputBox(String label, String hint, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          filled: true,
          enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
      ),
    );
  }

  Widget _datePickerField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          prefixIcon: const Icon(Icons.calendar_today),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
        readOnly: true,
        onTap: () => selectedDate(controller),
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

  Widget _submitButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        isLoading
            ? const CircularProgressIndicator()
            : ElevatedButton(
                style: ButtonStyle(
                                    shape: WidgetStatePropertyAll(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    )),
                                    backgroundColor:
                                        const WidgetStatePropertyAll(
                                            Color.fromRGBO(78, 115, 222, 1))),
                onPressed: _onSubmit,
                child: const Text(
                  'Submit',
                  style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
      ],
    );
  }
}
