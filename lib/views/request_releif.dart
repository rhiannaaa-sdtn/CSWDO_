import 'dart:typed_data';
import 'package:cwsdo/constatns/navitem.dart';
import 'package:cwsdo/services/firestore.dart';
import 'package:cwsdo/widget/custom/custom_widget.dart';
import 'package:cwsdo/widget/navigation_bar/footer.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cwsdo/widget/navigation_bar/navigation_bar.dart';
// import 'package:flutter/widgets.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';

// import 'package:file_picker/';

const List<String> list = <String>['Food Assistance', 'Medical Assistance'];

class RequestRelief extends StatefulWidget {
  const RequestRelief({super.key});

  @override
  State<RequestRelief> createState() => _RequestReliefState();
}

class _RequestReliefState extends State<RequestRelief> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          //MAIN
          const NavBar(),
          //about
          //Home
          Container(
            // height: MediaQuery.of(context).size.height * .9,
            // height: double.maxFinite,
            width: 100,
            decoration: const BoxDecoration(
              image: DecorationImage(
                alignment: Alignment.topCenter,
                image: AssetImage("images/bg1.png"),
                fit: BoxFit.fitWidth,
              ),
            ),
            child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 80,
                  ),
                  FoodHEad(),
                  SizedBox(
                    height: 20,
                  ),
                  FormRegister(),
                  SizedBox(
                    height: 50,
                  ),
                ]),
          ),
          // const About(),
          const Footer(),
        ],
      ),
    );
  }
}

// child: Padding(
//                 padding: const EdgeInsets.only(left: 200, top: 50),

class FoodHEad extends StatelessWidget {
  const FoodHEad({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset("images/SpcLogo.svg",
              width: 100, height: 100, fit: BoxFit.cover),
          const SizedBox(
            width: 20,
          ),
          const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                'Community Needs'),
            Text(
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                'Assesment Management'),
            Text(
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                'System (CNAMS)')
          ])
        ]);
  }
}

class FormRegister extends StatefulWidget {
  const FormRegister({super.key});

  @override
  State<FormRegister> createState() => _FormRegisterState();
}

class _FormRegisterState extends State<FormRegister> {
  final TextEditingController _fullname = TextEditingController();
  final TextEditingController _mobilenum = TextEditingController();
  final TextEditingController _dob = TextEditingController();
  final TextEditingController _govtid = TextEditingController();
  final TextEditingController _familynum = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _barangay = TextEditingController();
  final TextEditingController _needs = TextEditingController();
  final TextEditingController _date = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 1500,
      width: MediaQuery.of(context).size.height * 1.5,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        // borderRadius: BorderRadius.circular(10),
        // boxShadow: const [
        //   BoxShadow(
        //       color: Colors.grey,
        //       blurRadius: 5,
        //       spreadRadius: 1,
        //       offset: Offset(4, 4)),
        // ],
        color: Color.fromRGBO(227, 232, 238, 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(78, 115, 222, 1),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
            ),
            width: MediaQuery.of(context).size.height * 2,
            child: const Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text('Register for Requesting Assistance',
                      style: TextStyle(
                          fontSize: 50,
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(1.0, 1.0),
                              blurRadius: 3.0,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ],
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 50, right: 50, top: 50),
            child: Text(
              'Fill out the form for Registration',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 5,
                child:
                    // color: Colors.amber,
                    PersonalInput(
                        fullname: _fullname,
                        mobilenum: _mobilenum,
                        dob: _dob,
                        govtid: _govtid,
                        familynum: _familynum,
                        address: _address,
                        barangay: _barangay),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  // color: const Color.fromARGB(255, 30, 58, 73),
                  child: Column(
                    children: [
                      NeedsInput(needs: _needs, date: _date),
                      CredentialsInput(
                          fullname: _fullname,
                          mobileNum: _mobilenum,
                          dob: _dob,
                          govtid: _govtid,
                          familynum: _familynum,
                          address: _address,
                          barangay: _barangay,
                          needs: _needs,
                          date: _date)
                    ],
                  ),
                ),
              ),
            ],
            // )
            //         height: 500,
            //         width: double.maxFinite,
            //         color: Colors.blueGrey,
          ),
        ],
      ),
    );
  }
}

class PersonalInput extends StatefulWidget {
  final TextEditingController fullname,
      mobilenum,
      dob,
      govtid,
      familynum,
      address,
      barangay;
  const PersonalInput({
    super.key,
    required this.fullname,
    required this.mobilenum,
    required this.dob,
    required this.govtid,
    required this.familynum,
    required this.address,
    required this.barangay,
  });

  @override
  State<PersonalInput> createState() => _PersonalInputState();
}

class _PersonalInputState extends State<PersonalInput> {
  @override
  Widget build(BuildContext context) {
    // TextEditingController dateController = TextEditingController();
    Future<void> selectedDate() async {
      DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100));

      if (picked != null) {
        debugPrint(picked.toString().split(" ")[0]);
        // setState(() {
        //   dateController.text = '_picked.toString().split(" ")[0]';
        // });

        widget.dob.text = picked.toString().split(" ")[0];

        // dateController.text = 'asdsadsadsadkshagfjsahgfhkjsdagflksagkfjhgsalkf';
      }
    }

    return Padding(
      padding: const EdgeInsets.only(left: 50, right: 20, top: 50, bottom: 30),
      child: Container(
        width: MediaQuery.of(context).size.height * 1.5,
        // alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
                color: Colors.grey,
                blurRadius: 5,
                spreadRadius: 1,
                offset: Offset(4, 4)),
          ],
          color: const Color.fromARGB(255, 246, 246, 246),
        ),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 40),
                child: Text('Personal information',
                    style: TextStyle(
                        color: Color.fromRGBO(78, 115, 222, 1), fontSize: 30)),
              ),
              InptBox(
                txtdesc: 'Full name',
                txtinput: 'Enter Full Name',
                inputText: widget.fullname,
              ),
              InptBox(
                txtdesc: 'Mobile Number',
                txtinput: 'Enter Mobile Number',
                inputText: widget.mobilenum,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Date of Birth',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: widget.dob,
                  decoration: const InputDecoration(
                      labelText: 'Date of Birth',
                      filled: true,
                      prefixIcon: Icon(Icons.calendar_today),
                      enabledBorder:
                          OutlineInputBorder(borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue))),
                  readOnly: true,
                  onTap: () {
                    selectedDate();
                  },
                ),
              ),
              InptBox(
                txtdesc: 'Any Govt. Issued ID',
                txtinput: 'Enter any Govt. Issued ID',
                inputText: widget.govtid,
              ),
              InptBox(
                txtdesc: 'Number of Family Member',
                txtinput: 'Enter Number of Family Member',
                inputText: widget.familynum,
              ),
              InptBox(
                txtdesc: 'Address',
                txtinput: 'Enter address',
                inputText: widget.address,
              ),
              // InptBox(
              //   txtdesc: 'Barangay',
              //   txtinput: 'Enter Barangay',
              //   inputText: widget.barangay,
              // ),
              Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Barangay',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: BarangayDrop(barangay: widget.barangay),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NeedsInput extends StatefulWidget {
  final TextEditingController needs, date;
  const NeedsInput({super.key, required this.needs, required this.date});

  @override
  State<NeedsInput> createState() => _NeedsInputState();
}

class _NeedsInputState extends State<NeedsInput> {
  @override
  Widget build(BuildContext context) {
    // TextEditingController dateController = TextEditingController();
    Future<void> selectedDate() async {
      DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100));

      if (picked != null) {
        debugPrint(picked.toString().split(" ")[0]);
        // setState(() {
        //   dateController.text = '_picked.toString().split(" ")[0]';
        // });

        widget.date.text = picked.toString().split(" ")[0];

        // dateController.text = 'asdsadsadsadkshagfjsahgfhkjsdagflksagkfjhgsalkf';
      }
    }

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 50, top: 50, bottom: 30),
      child: Container(
        width: MediaQuery.of(context).size.height * 1.5,
        // alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
                color: Colors.grey,
                blurRadius: 5,
                spreadRadius: 1,
                offset: Offset(4, 4)),
          ],
          color: const Color.fromARGB(255, 246, 246, 246),
        ),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 40),
                child: Text('Needs Information',
                    style: TextStyle(
                        color: Color.fromRGBO(78, 115, 222, 1), fontSize: 30)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Needs Type',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropButton(
                        needs: widget.needs,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Date',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: widget.date,
                        decoration: const InputDecoration(
                            labelText: 'Date',
                            filled: true,
                            prefixIcon: Icon(Icons.calendar_today),
                            enabledBorder:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue))),
                        readOnly: true,
                        onTap: () {
                          selectedDate();
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CredentialsInput extends StatefulWidget {
  final TextEditingController fullname,
      mobileNum,
      dob,
      govtid,
      familynum,
      address,
      barangay,
      needs,
      date;

  const CredentialsInput(
      {super.key,
      required this.fullname,
      required this.mobileNum,
      required this.dob,
      required this.govtid,
      required this.familynum,
      required this.address,
      required this.barangay,
      required this.needs,
      required this.date});
  @override
  State<CredentialsInput> createState() => _CredentialsInputState();
}

class _CredentialsInputState extends State<CredentialsInput> {
  bool _isLoading = false;
  final FireStoreService fireStoreService = FireStoreService();
  PlatformFile? pickedfile1;
  PlatformFile? pickedfile2;
  PlatformFile? pickedfile3;
  UploadTask? uploadTask;

  Future _onSubmit() async {
    if (pickedfile1 == null || pickedfile2 == null) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Credential Error'),
              content: const Text('Please Add Valid ID and indigency file'),
              actions: <Widget>[
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('OK')),
              ],
            );
          });
    } else {
      setState(() {
        _isLoading = true; // Start loading
      });

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      try {
        // ------------------------file1----------------------
        final FirebaseStorage storage1 = FirebaseStorage.instance;
        var path1 = 'files/${pickedfile1!.name}';
        Uint8List? fileBytes1 = pickedfile1!.bytes;
        if (fileBytes1 != null) {
          Reference storageRef =
              storage1.ref().child('uploads/${pickedfile3!.name}');
          UploadTask uploadTask = storageRef.putData(fileBytes1);
          uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
            double progress = snapshot.bytesTransferred.toDouble() /
                snapshot.totalBytes.toDouble();
            print('Upload is ${progress * 100} % complete.');
          });
          await uploadTask;
          String downloadURL = await storageRef.getDownloadURL();
          print('File uploaded successfully! Download URL: $downloadURL');
        }

        // -------------file2-------------
        final FirebaseStorage storage2 = FirebaseStorage.instance;
        var path2 = 'files/${pickedfile3!.name}';
        Uint8List? fileBytes2 = pickedfile2!.bytes;
        if (fileBytes2 != null) {
          Reference storageRef =
              storage2.ref().child('uploads/${pickedfile2!.name}');
          UploadTask uploadTask = storageRef.putData(fileBytes2);
          uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
            double progress = snapshot.bytesTransferred.toDouble() /
                snapshot.totalBytes.toDouble();
            print('Upload is ${progress * 100} % complete.');
          });
          await uploadTask;
          String downloadURL = await storageRef.getDownloadURL();
          print('File uploaded successfully! Download URL: $downloadURL');
        }
      } finally {
        Navigator.of(context).pop(); // Close the loading dialog
        setState(() {
          _isLoading = false; // Stop loading
        });
      }
    }

    if (widget.fullname.text == '' ||
        widget.mobileNum.text == '' ||
        widget.dob.text == '' ||
        widget.govtid.text == '' ||
        widget.familynum.text == '' ||
        widget.address.text == '' ||
        widget.barangay.text == '') {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Input Error'),
              content: const Text('Please Fillup all fields'),
              actions: <Widget>[
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('OK')),
              ],
            );
          });
    } else {
      fireStoreService.addRequest(
        widget.fullname.text,
        widget.mobileNum.text,
        widget.dob.text,
        widget.govtid.text,
        widget.familynum.text,
        widget.familynum.text,
        widget.address.text,
        widget.barangay.text,
        widget.needs.text,
        widget.date.text,
        'files/${pickedfile1!.name}',
        'files/${pickedfile2!.name}',
        pickedfile3 != null ? 'files/${pickedfile3!.name}' : '',
        // pickedfile3 != null ? pickedfile1.path : '',
        // pickedfile2.path,
        // pickedfile3.path,
      );

// if (pickedfile3 != null) {}

      _clearFile();
    }
  }

  Future<void> _selectedFile(String type) async {
    // FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (type == 'type1') {
      final result = await FilePicker.platform.pickFiles();
      // widget.result = result;
      if (result == null) return;
      setState(() {
        pickedfile1 = result.files.first;
      });
    }
    if (type == 'type2') {
      final result = await FilePicker.platform.pickFiles();
      // widget.result = result;
      if (result == null) return;
      setState(() {
        pickedfile2 = result.files.first;
      });
    }
    if (type == 'type3') {
      final result = await FilePicker.platform.pickFiles();
      // widget.result = result;
      if (result == null) return;
      setState(() {
        pickedfile3 = result.files.first;
      });
    }
  }

  final file1 = '';
  final file2 = '';
  final file3 = '';
  Future<void> _clearFile() async {
    widget.fullname.text = '';
    widget.mobileNum.text = '';
    widget.dob.text = 'Date of Birth';
    widget.govtid.text = '';
    widget.familynum.text = '';
    widget.address.text = '';
    widget.barangay.text = '';
    widget.needs.text = 'Food Assistance';
    widget.date.text = 'Date';
    pickedfile1 = null;
    pickedfile2 = null;
    pickedfile3 = null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 50, top: 50, bottom: 30),
      child: Container(
        width: MediaQuery.of(context).size.height * 1.5,
        // alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
                color: Colors.grey,
                blurRadius: 5,
                spreadRadius: 1,
                offset: Offset(4, 4)),
          ],
          color: const Color.fromARGB(255, 246, 246, 246),
        ),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 40),
                child: Text('Upload Credentials',
                    style: TextStyle(
                        color: Color.fromRGBO(78, 115, 222, 1), fontSize: 30)),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Column(
                    children: [
                      // file1
                      Row(
                        children: [
                          const Icon(size: 100, Icons.image),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Document'),
                              pickedfile1 != null
                                  ? Text(pickedfile1!.name)
                                  : const Text('Clear Picure of your Valid ID'),
                              ElevatedButton(
                                style: ButtonStyle(
                                    shape: WidgetStatePropertyAll(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    )),
                                    backgroundColor:
                                        const WidgetStatePropertyAll(
                                            Color.fromRGBO(78, 115, 222, 1))),
                                child: const Row(
                                  children: [
                                    Text(
                                        style: TextStyle(
                                          fontSize: 15,
                                          color:
                                              Color.fromRGBO(255, 255, 255, 1),
                                          fontWeight: FontWeight.bold,
                                        ),
                                        'Upload File'),
                                  ],
                                ),
                                onPressed: () {
                                  _selectedFile('type1');
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                      // file2
                      Row(
                        children: [
                          const Icon(size: 100, Icons.image),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Indigency *'),
                              pickedfile2 != null
                                  ? Text(pickedfile2!.name)
                                  : const Text(
                                      'Clear Picure of your Indigency'),
                              ElevatedButton(
                                style: ButtonStyle(
                                    shape: WidgetStatePropertyAll(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    )),
                                    backgroundColor:
                                        const WidgetStatePropertyAll(
                                            Color.fromRGBO(78, 115, 222, 1))),
                                child: const Row(
                                  children: [
                                    Text(
                                        style: TextStyle(
                                          fontSize: 15,
                                          color:
                                              Color.fromRGBO(255, 255, 255, 1),
                                          fontWeight: FontWeight.bold,
                                        ),
                                        'Upload File'),
                                  ],
                                ),
                                onPressed: () {
                                  _selectedFile('type2');
                                },
                              ),
                            ],
                          )
                        ],
                      ),

                      // file3
                      Row(
                        children: [
                          const Icon(size: 100, Icons.image),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                  'Authorization Letter (if applicable) *'),
                              pickedfile3 != null
                                  ? Text(pickedfile3!.name)
                                  : const Text('(.jpg .png .pdf)'),
                              ElevatedButton(
                                style: ButtonStyle(
                                    shape: WidgetStatePropertyAll(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    )),
                                    backgroundColor:
                                        const WidgetStatePropertyAll(
                                            Color.fromRGBO(78, 115, 222, 1))),
                                child: const Row(
                                  children: [
                                    Text(
                                        style: TextStyle(
                                          fontSize: 15,
                                          color:
                                              Color.fromRGBO(255, 255, 255, 1),
                                          fontWeight: FontWeight.bold,
                                        ),
                                        'Upload File'),
                                  ],
                                ),
                                onPressed: () {
                                  _selectedFile('type3');
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  )),
              ElevatedButton(
                style: ButtonStyle(
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      // side: const BorderSide(
                      //     color: Colors.red)
                    )),
                    backgroundColor: const WidgetStatePropertyAll(
                        Color.fromRGBO(78, 115, 222, 1))),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontWeight: FontWeight.bold,
                        ),
                        'Submit')
                  ],
                ),
                onPressed: () {
                  _onSubmit();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

// class PicField extends StatefulWidget {
//   final String txtdesc, txtID;
//   final TextEditingController fullname;
//   // final File result;

//   // final String txtinput;

//   const PicField({
//     super.key,
//     required this.txtdesc,
//     required this.txtID,
//     required this.fullname,
//     // required this.result,
//   });
//   @override
//   State<PicField> createState() => _PicFieldState();
// }

// class _PicFieldState extends State<PicField> {
//   final FireStoreService fireStoreService = FireStoreService();
//   PlatformFile? pickedfile;

//   Future<void> _selectedFile() async {
//     // FilePickerResult? result = await FilePicker.platform.pickFiles();
//     final result = await FilePicker.platform.pickFiles();
//     // widget.result = result;
//     if (result == null) return;
//     setState(() {
//       pickedfile = result.files.first;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Icon(size: 100, Icons.image),
//         Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(widget.txtID),
//             pickedfile != null ? Text(pickedfile!.name) : Text(widget.txtdesc),
//             ElevatedButton(
//               style: ButtonStyle(
//                   shape: WidgetStatePropertyAll(RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   )),
//                   backgroundColor: const WidgetStatePropertyAll(
//                       Color.fromRGBO(78, 115, 222, 1))),
//               child: const Row(
//                 children: [
//                   Text(
//                       style: TextStyle(
//                         fontSize: 15,
//                         color: Color.fromRGBO(255, 255, 255, 1),
//                         fontWeight: FontWeight.bold,
//                       ),
//                       'Upload File'),
//                 ],
//               ),
//               onPressed: () {
//                 _selectedFile();
//               },
//             ),
//           ],
//         )
//       ],
//     );
//   }
// }

class DropButton extends StatefulWidget {
  final TextEditingController needs;
  const DropButton({super.key, required this.needs});

  @override
  State<DropButton> createState() => _DropButtonState();
}

class _DropButtonState extends State<DropButton> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      controller: widget.needs,
      initialSelection: list.first,
      onSelected: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}

class BarangayDrop extends StatefulWidget {
  final TextEditingController barangay;
  const BarangayDrop({super.key, required this.barangay});

  @override
  State<BarangayDrop> createState() => _BarangayDropState();
}

class _BarangayDropState extends State<BarangayDrop> {
  String dropdownValue = bgrgyList.first;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      // width: 100,
      textStyle: const TextStyle(color: Colors.black,fontSize: 12),
      controller: widget.barangay,
        // menuHeight: 40, 
      initialSelection: bgrgyList.first,
      onSelected: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      dropdownMenuEntries:
          bgrgyList.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value,);
      }).toList(),
    );
  }
}


class InptBX extends StatefulWidget {
  final String txtdesc, txtinput;
  final TextEditingController inputText;
  // final String txtinput;

  const InptBX({
    super.key,
    required this.txtdesc,
    required this.txtinput,
    required this.inputText,
  });

  @override
  State<InptBX> createState() => _InptBXState();
}

class _InptBXState extends State<InptBX> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 1, left: 1, right: 1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: Text(widget.txtdesc,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 12)),
              ),
              Container(height: 35  ,
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: TextField(
                      controller: widget.inputText,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hintText: widget.txtinput,
                      ), style:const TextStyle(fontSize: 12)
                      ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
