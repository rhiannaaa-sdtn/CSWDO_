import 'package:cwsdo/widget/custom/custom_widget.dart';
import 'package:cwsdo/widget/navigation_bar/footer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cwsdo/widget/navigation_bar/navigation_bar.dart';
import 'package:flutter/widgets.dart';

const List<String> list = <String>['Food Assitance', 'Medical Assistance'];

class RequestRelief extends StatelessWidget {
  const RequestRelief({super.key});

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
          Image.asset("images/SpcLogo.png",
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

class FormRegister extends StatelessWidget {
  const FormRegister({super.key});

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
        color: const Color.fromRGBO(227, 232, 238, 1),
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
            padding: const EdgeInsets.only(left: 50, right: 50, top: 50),
            child: Text(
              'Fill out the form for Registration',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Expanded(
                flex: 5,
                child:
                    // color: Colors.amber,
                    const PersonalInput(),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  // color: const Color.fromARGB(255, 30, 58, 73),
                  child: const Column(
                    children: [NeedsInput(), CredentialsInput()],
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

class PersonalInput extends StatelessWidget {
  const PersonalInput({super.key});

  @override
  Widget build(BuildContext context) {
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
        child: const Padding(
          padding: EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 40),
                child: Text('Personal information',
                    style: TextStyle(
                        color: Color.fromRGBO(78, 115, 222, 1), fontSize: 30)),
              ),
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
    );
  }
}

class NeedsInput extends StatefulWidget {
  const NeedsInput({super.key});

  @override
  State<NeedsInput> createState() => _NeedsInputState();
}

class _NeedsInputState extends State<NeedsInput> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _dateController = TextEditingController();
    Future<void> _selectedDate() async {
      DateTime? _picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100));

      if (_picked != null) {
        setState(() {
          _dateController.text = _picked.toString().split(" ")[0];
        });
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
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: DropButton(),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Date',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _dateController,
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
                          _selectedDate();
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
  const CredentialsInput({super.key});

  @override
  State<CredentialsInput> createState() => _CredentialsInputState();
}

class _CredentialsInputState extends State<CredentialsInput> {
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
        child: const Padding(
          padding: EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 40),
                child: Text('Upload Credentials',
                    style: TextStyle(
                        color: Color.fromRGBO(78, 115, 222, 1), fontSize: 30)),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Column(
                    children: [
                      PicField(
                        txtID: 'Valid ID *',
                        txtdesc: 'Clear Picure of your Valid ID',
                      ),
                      PicField(
                        txtID: 'Indigency *',
                        txtdesc: 'Clear Picure of your Indigency',
                      ),
                      PicField(
                        txtID: 'Authorization Letter (if applicable) *',
                        txtdesc: '(.jp .png .pdf)',
                      ),
                      // PicField(),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class PicField extends StatefulWidget {
  final String txtdesc, txtID;
  // final String txtinput;

  const PicField({
    super.key,
    required this.txtdesc,
    required this.txtID,
  });
  @override
  State<PicField> createState() => _PicFieldState();
}

class _PicFieldState extends State<PicField> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(size: 100, Icons.image),
        // Image.asset("images/SpcLogo.png",
        //     width: 100, height: 100, fit: BoxFit.cover),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.txtID),
            Text(widget.txtdesc),
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
                children: [
                  Text(
                      style: TextStyle(
                        fontSize: 15,
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontWeight: FontWeight.bold,
                      ),
                      'Upload File')
                ],
              ),
              onPressed: () {},
            ),
          ],
        )
      ],
    );
  }
}

class DropButton extends StatefulWidget {
  const DropButton({super.key});

  @override
  State<DropButton> createState() => _DropButtonState();
}

class _DropButtonState extends State<DropButton> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
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