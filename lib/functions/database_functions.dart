import 'package:cloud_firestore/cloud_firestore.dart';


addFriend({
  required String email,
  required String handle,
  required String nickname
}) async {
  await FirebaseFirestore.instance.collection('users').doc(email).collection('friends').doc(handle).set({
    'nickname':nickname,
    'handle':handle,
  });
}

addUser(
    {required String username,
    required String email,
    required String handle}) async {
  await FirebaseFirestore.instance
      .collection('users')
      .doc(email)
      .set({'username': username, 'handle': handle});
}
