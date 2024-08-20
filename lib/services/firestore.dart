import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {
// get DB instance
  final CollectionReference requestRelief =
      FirebaseFirestore.instance.collection('Request');
//create: add request
  Future<void> addRequest(String fullname, String mobileNum, String dateOfBirth,
      String govtID, String familynum, String address, String barangay) {
    return requestRelief.add({
      'fullname': fullname,
      'mobileNum': mobileNum,
      'dateOfBirth': dateOfBirth,
      'govtID': govtID,
      'familynum': familynum,
      'address': address,
      'barangay': barangay,
      'timeStamp': Timestamp.now()
    });
  }
}
