import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

addFriend(
    {required String email,
    required String handle,
    required String nickname}) async {
  try {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(email)
        .collection('friends')
        .doc(handle)
        .set({
      'nickname': nickname,
      'handle': handle,
    });
  } catch (e) {
    Fluttertoast.showToast(msg: "Firestore Error: ${e.toString()}");
  }
}

addUser(
    {required String username,
    required String email,
    required String handle}) async {
  try {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(email)
        .set({'username': username, 'handle': handle});
  } catch (e) {
    Fluttertoast.showToast(msg: "Firestore Error: ${e.toString()}");
  }
}

removeFriend({required String email, required String handle}) async {
  try {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(email)
        .collection('friends')
        .doc(handle)
        .delete();
    Fluttertoast.showToast(msg: "Success");
  } catch (e) {
    Fluttertoast.showToast(msg: "Firestore Error: ${e.toString()}");
  }
}

deleteAllData({required String email}) async {
  try {
    await FirebaseFirestore.instance.collection('users').doc(email).delete();
  } catch (e) {
    Fluttertoast.showToast(msg: "Firestore Error: ${e.toString()}");
  }
}

editUserHandle({required String newHandle, required String email}) async {
  try {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(email)
        .update({'handle': newHandle});
  } catch (e) {
    Fluttertoast.showToast(msg: "Firestore Error: ${e.toString()}");
  }
}
