// import 'package:cwsdo/widget/navigation_bar/footer.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row1(),
        // SizedBox(
        //   height: 20,
        // ),
        Row2(),
        SizedBox(
          height: 50,
        ),

        Contact(),
        SizedBox(
          height: 150,
        )
      ],
    );
  }
}

// Abt
class Abt extends StatefulWidget {
  const Abt({super.key});

  @override
  State<Abt> createState() => _AbtState();
}

class _AbtState extends State<Abt> {
  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
                'ABOUT US',
              ),
              SizedBox(height: 20),
              Text(
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.justify,
                'The City Social Welfare and Development Office (CWSDO) is the local social welfare arm of '
                'the City Government of San Pablo   mandated to provide basic social welfare programs to its '
                'disadvantege citizenry. CWSDO was devolved and decentralized to the City Government of San Pablo '
                'October 1, 1992 in pursuant to RA 7160 and City Ordinance No. 2374 Series of 1994 which approved '
                'the organizaitional structure and staffing pattern of the City of San Pablo in orger for LGUs to '
                'excercise greater autonomy in providing basic welfare programs and service.',
              ),
              SizedBox(height: 20),
              Text(
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
                'Program Objectives',
              ),
              SizedBox(height: 20),
              Text(
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.justify,
                  'The objectives of City Social Welfare and Development Office (CWSDO) is to '
                  'help and provide food and medical assistance for disadvantage citizens of San Pablo.'),
            ],
          )),
    );
  }
}

class Row1 extends StatelessWidget {
  const Row1({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Expanded(
          flex: 5,
          child: SizedBox(
            width: 100.0,
            // height: MediaQuery.of(context).size.height * .9,
            // height: double.infinity,
            // color: const Color.fromARGB(255, 255, 255, 255),
            child: Row(
              children: [Abt()],
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.center, //Center Column contents vertically,
              crossAxisAlignment: CrossAxisAlignment
                  .center, //Center Column contents horizontally,
              children: [
                Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Column(
                      children: [
                        const Text(
                          'CWSDO ASSISTANCE',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          height: 100,
                          width: MediaQuery.of(context).size.width * .3,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                shape: WidgetStatePropertyAll(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  // side: const BorderSide(
                                  //     color: Colors.red)
                                )),
                                backgroundColor: const WidgetStatePropertyAll(
                                    Color.fromRGBO(78, 115, 222, 1))),
                            child: Row(
                              children: [
                                Image.asset("images/Caduceus.png",
                                    width: 100, height: 100, fit: BoxFit.cover),
                                const Text(
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: Color.fromRGBO(255, 255, 255, 1),
                                      fontWeight: FontWeight.bold,
                                    ),
                                    'Medical Assistance')
                              ],
                            ),
                            onPressed: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => const Footer()),
                              // );
                              Navigator.pushNamed(
                                  context, '/medicalassistance');
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          height: 100,
                          width: MediaQuery.of(context).size.width * .3,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                shape: WidgetStatePropertyAll(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  // side: const BorderSide(
                                  //     color: Colors.red)
                                )),
                                backgroundColor: const WidgetStatePropertyAll(
                                    Color.fromRGBO(78, 115, 222, 1))),
                            child: Row(
                              children: [
                                Image.asset("images/Food.png",
                                    width: 100, height: 100, fit: BoxFit.cover),
                                const Text(
                                    style: TextStyle(
                                      color: Color.fromRGBO(255, 255, 255, 1),
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    'Food Assistance')
                              ],
                            ),
                            onPressed: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => const Footer()),
                              // );
                              Navigator.pushNamed(context, '/foodassistance');
                            },
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ],
      // )
      //         height: 500,
      //         width: double.maxFinite,
      //         color: Colors.blueGrey,
    );
  }
}

class Row2 extends StatelessWidget {
  const Row2({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.center, //Center Column contents vertically,
      crossAxisAlignment:
          CrossAxisAlignment.center, //Center Column contents horizontally,
      children: [
        Image.asset("images/CSWDOgroupPic.jpg",
            width: MediaQuery.of(context).size.width * .9,
            height: MediaQuery.of(context).size.height * .5,
            fit: BoxFit.cover)
      ],
    );
  }
}

// height: MediaQuery.of(context).size.height * .1,
class Contact extends StatelessWidget {
  const Contact({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 4,
          child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(children: [
                Image.asset("images/SpcLogo.png",
                    width: 200, height: 200, fit: BoxFit.cover),
                const SizedBox(
                  width: 20,
                ),
                const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                          'Community Needs'),
                      Text(
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                          'Assesment Management'),
                      Text(
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                          'System (CNAMS)')
                    ])
              ])),
        ),
        const Expanded(
          flex: 4,
          child: Padding(
              padding: EdgeInsets.all(30.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                        'CONTACT US'),
                    Divider(
                      color: Colors.black,
                      thickness: 10,
                      endIndent: 300,
                    ),
                    Text(
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        'inquiry@cswdo.gov.ph'),
                    Text(
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        'cnams.co@cswdo.gov.ph'),
                    Text(
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        '8962-2813/8951-7433'),
                    Text(
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        'Monday - Friday (except holidays)'),
                    Text(
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        '8:00 am - 5:00 pm')
                  ])),
        ),
      ],
      // )
      //         height: 500,
      //         width: double.maxFinite,
      //         color: Colors.blueGrey,
    );
  }
}
