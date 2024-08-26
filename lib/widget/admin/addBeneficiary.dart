import 'package:cwsdo/views/admin/side_bar.dart';
import 'package:flutter/material.dart';

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
    return Padding(
      padding:
          const EdgeInsets.only(top: 10.0, left: 50.0, right: 50, bottom: 20),
      child: Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Expanded(
                flex: 1,
                child: Padding(
                    padding: EdgeInsets.only(left: 50.0, right: 50),
                    child: Flexible(child: PersonalInputlocal()))),
            Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 50.0, right: 50),
                  child: ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return const Scrollbar(
                            thumbVisibility: true,
                            child: SingleChildScrollView(
                                child: Flexible(child: NeedsInput())));
                      }),
                )),
          ]),
    );
  }
}

class PersonalInputlocal extends StatelessWidget {
  const PersonalInputlocal({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 50,
          child: Text(
            'Add Beneficiary',
            style: TextStyle(fontSize: 30),
          ),
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
                      'Personal Information',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                )),
            SizedBox(
                width: MediaQuery.of(context).size.width * .8,
                height: MediaQuery.of(context).size.height * .65,
                child: SingleChildScrollView(
                  child: Container(
                    color: Colors.white,
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          InptBX(
                            txtdesc: 'Full name',
                            txtinput: 'Enter Full Name',
                          ),
                          InptBX(
                            txtdesc: 'Mobile Number',
                            txtinput: 'Enter Mobile Number',
                          ),
                          InptBX(
                            txtdesc: 'Date of Birth',
                            txtinput: 'Enter Date of Birth',
                          ),
                          InptBX(
                            txtdesc: 'Any Govt. Issued ID',
                            txtinput: 'Enter any Govt. Issued ID',
                          ),
                          InptBX(
                            txtdesc: 'Number of Family Member',
                            txtinput: 'Enter Number of Family Member',
                          ),
                          InptBX(
                            txtdesc: 'Address',
                            txtinput: 'Enter address',
                          ),
                          InptBX(
                            txtdesc: 'Barangay',
                            txtinput: 'Enter Barangay',
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

class NeedsInput extends StatelessWidget {
  const NeedsInput({super.key});

  @override
  Widget build(BuildContext context) {
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
                        children: [
                          const InptBX(
                            txtdesc: 'Needs type',
                            txtinput: 'Select',
                          ),
                          const InptBX(
                            txtdesc: 'Date Registered',
                            txtinput: 'mm/dd/yyyy',
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

class InptBX extends StatelessWidget {
  final String txtdesc, txtinput;
  // final String txtinput;

  const InptBX({
    super.key,
    required this.txtdesc,
    required this.txtinput,
  });

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
                child: Text(txtdesc,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: TextField(
                    decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: txtinput,
                )),
              ),
            ],
          ),
        )
      ],
    );
  }
}

void _submitButton(BuildContext context, btnlink) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Alert Dialog Example'),
          content: Text(btnlink),
          actions: <Widget>[
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK')),
          ],
        );
      });
}
