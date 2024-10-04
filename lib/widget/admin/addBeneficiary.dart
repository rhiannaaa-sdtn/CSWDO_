import 'package:cwsdo/views/admin/side_bar.dart';
import 'package:cwsdo/views/request_releif.dart';
// import 'package:cwsdo/widget/custom/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:cwsdo/services/firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

// import 'package:flutter/src/widgets/framework.dart';

class AddBeneficiaryMain extends StatefulWidget {
  const AddBeneficiaryMain({super.key});

  @override
  State<AddBeneficiaryMain> createState() => _AddBeneficiaryMainState();
}

class _AddBeneficiaryMainState extends State<AddBeneficiaryMain> {
  @override
  Widget build(BuildContext context) {
    return const Sidebar(content: Addbeneficiary());
  }
}

class Addbeneficiary extends StatelessWidget {
  const Addbeneficiary({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _fullname = TextEditingController();
    final TextEditingController _mobilenum = TextEditingController();
    final TextEditingController _dob = TextEditingController();
    final TextEditingController _govtid = TextEditingController();
    final TextEditingController _familynum = TextEditingController();
    final TextEditingController _address = TextEditingController();
    final TextEditingController _barangay = TextEditingController();
    final TextEditingController _needs = TextEditingController();
    final TextEditingController _date = TextEditingController();
    return Padding(
      padding:
          const EdgeInsets.only(top: 10.0, left: 50.0, right: 50, bottom: 20),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: Padding(
                    padding: const EdgeInsets.only(left: 50.0, right: 50),
                    child: Flexible(
                        child: PersonalInputlocal(
                            fullname: _fullname,
                            mobilenum: _mobilenum,
                            dob: _dob,
                            govtid: _govtid,
                            familynum: _familynum,
                            address: _address,
                            barangay: _barangay)))),
            Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 50.0, right: 50),
                  child: ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return Scrollbar(
                            thumbVisibility: true,
                            child: SingleChildScrollView(
                                child: Flexible(
                              child: NeedsInput(
                                  fullname: _fullname,
                                  mobileNum: _mobilenum,
                                  dob: _dob,
                                  govtid: _govtid,
                                  familynum: _familynum,
                                  address: _address,
                                  barangay: _barangay,
                                  needs: _needs,
                                  date: _date),
                            )));
                      }),
                )),
          ]),
    );
  }
}

class PersonalInputlocal extends StatefulWidget {
  final TextEditingController fullname,
      mobilenum,
      dob,
      govtid,
      familynum,
      address,
      barangay;

  const PersonalInputlocal({
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
  State<PersonalInputlocal> createState() => _PersonalInputlocalState();
}

class _PersonalInputlocalState extends State<PersonalInputlocal> {
  @override
  Widget build(BuildContext context) {
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

    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 50,
          child: Text(
            'Add Beneficiary',
            style: TextStyle(fontSize: 20),
          ),
        ),
        Column(
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width * .8,
                child: Container(
                  color: const Color.fromARGB(255, 22, 97, 152),
                  child: const Padding(
                    padding: EdgeInsets.all(05.0),
                    child: Text(
                      'Personal Information',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                )),
            SizedBox(
                width: MediaQuery.of(context).size.width * .8,
                height: MediaQuery.of(context).size.height * .67,
                child: SingleChildScrollView(
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InptBX(
                            txtdesc: 'Full name',
                            txtinput: 'Enter Full Name',
                            inputText: widget.fullname,
                          ),
                          InptBX(
                            txtdesc: 'Mobile Number',
                            txtinput: 'Enter Mobile Number',
                            inputText: widget.mobilenum,
                          ),
                          // const Padding(
                          //   padding: EdgeInsets.all(8.0),
                          //   child: Text('Date of Birth',
                          //       style: TextStyle(fontWeight: FontWeight.bold)),
                          // ),
                          Container(
                            height: 50,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: widget.dob,
                                decoration: const InputDecoration(
                                    labelText: 'Date of Birth',
                                    filled: true,
                                    prefixIcon: Icon(Icons.calendar_today),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.blue))),
                                readOnly: true,
                                onTap: () {
                                  selectedDate();
                                },
                              ),
                            ),
                          ),
                          InptBX(
                            txtdesc: 'Any Govt. Issued ID',
                            txtinput: 'Enter any Govt. Issued ID',
                            inputText: widget.govtid,
                          ),
                          InptBX(
                            txtdesc: 'Number of Family Member',
                            txtinput: 'Enter Number of Family Member',
                            inputText: widget.familynum,
                          ),
                          InptBX(
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
                                padding: const EdgeInsets.only(
                                    top: 0, left: 10, right: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                  const  Padding(
                                      padding: const EdgeInsets.all(0),
                                      child: Text('Barangay',
                                          style: const TextStyle(fontSize: 12,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(0),
                                        child: BarangayDrop(
                                            barangay: widget.barangay),
                                      ),
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
                ))
          ],
        )
      ],
    );
  }
}

class NeedsInput extends StatefulWidget {
  final TextEditingController fullname,
      mobileNum,
      dob,
      govtid,
      familynum,
      address,
      barangay,
      needs,
      date;

  const NeedsInput(
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
  State<NeedsInput> createState() => _NeedsInputState();
}

class _NeedsInputState extends State<NeedsInput> {
  @override
  Widget build(BuildContext context) {
    final FireStoreService fireStoreService = FireStoreService();
    bool _isLoading = false;

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
    }

    Future<void> selectedDate() async {
      DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100));

      if (picked != null) {
        debugPrint(picked.toString().split(" ")[0]);
        widget.date.text = picked.toString().split(" ")[0];
      }
    }

    void _submitButton(BuildContext context, btnlink) {
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
          fireStoreService.addBeneficiary(
              widget.fullname.text,
              widget.mobileNum.text,
              widget.dob.text,
              widget.govtid.text,
              widget.familynum.text,
              widget.address.text,
              widget.barangay.text,
              widget.needs.text,
              widget.date.text);
        } finally {
          Navigator.of(context).pop(); // Close the loading dialog
          setState(() {
            _isLoading = false; // Stop loading
          });
        }

        _clearFile();
      }
    }

    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 50,
        ),
        Column(
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width * .8,
                child: Container(
                  color: const Color.fromARGB(255, 22, 97, 152),
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Needs Information',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                )),
            SizedBox(
                width: MediaQuery.of(context).size.width * .8,
                height: MediaQuery.of(context).size.height * .64,
                child: SingleChildScrollView(
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: widget.date,
                              decoration: const InputDecoration(
                                  labelText: 'Date',
                                  filled: true,
                                  prefixIcon: Icon(Icons.calendar_today),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue))),
                              readOnly: true,
                              onTap: () {
                                selectedDate();
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                                shape: WidgetStatePropertyAll(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  // side: const BorderSide(
                                  //     color: Colors.red)
                                )),
                                backgroundColor: const WidgetStatePropertyAll(
                                    Color.fromRGBO(78, 115, 222, 1))),
                            child: const Column(
                              children: [
                                Text(
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Color.fromRGBO(255, 255, 255, 1),
                                      fontWeight: FontWeight.bold,
                                    ),
                                    'Submit')
                              ],
                            ),
                            onPressed: () {
                              _submitButton(context, 'asd');
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
          ],
        )
      ],
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
