import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cwsdo/views/home_page.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// final _auth = FirebaseAuth.instance;

// class CheckAuth {
//   final user = _auth.currentUser;
//   Future<void> authLogedIn(context) {
//     if (user != null) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => HomePage()),
//       );
//       ;
//       // return Navigator.pushNamed(context, '/');
//     }
//     throw Exception('Login');
//   }

//   Future<void> authLogedOut(context) {
//     if (user != null) {
//       return Navigator.pushNamed(context, '/');
//     }
//     throw Exception('Login');
//   }
// }

class FireStoreService {
// get DB instance
  final CollectionReference requestRelief =
      FirebaseFirestore.instance.collection('Request');
//create: add request
  Future<void> addRequest(
      String fullname,
      String mobileNum,
      String dateOfBirth,
      String govtID,
      String familynum,
      String address,
      String barangay,
      String? validID,
      String? indigency,
      String? authLetter) {
    return requestRelief.add({
      'fullname': fullname,
      'mobileNum': mobileNum,
      'dateOfBirth': dateOfBirth,
      'govtID': govtID,
      'familynum': familynum,
      'address': address,
      'barangay': barangay,
      'validID': validID,
      'indigency': indigency,
      'authLetter': authLetter,
      'timeStamp': Timestamp.now()
    });
  }

// get DB instance
  final CollectionReference addRemarksfire =
      FirebaseFirestore.instance.collection('Remarks');
//create: add request
  Future<void> addRemarks(
    String cleintID,
    String remarks,
    String status,
  ) {
    return addRemarksfire.add({
      'cleintID': cleintID,
      'remarks': remarks,
      'status': status,
      'timeStamp': Timestamp.now(),
      'REMARK BY': 'ADMINISTRATOR',
    });
  }
}
