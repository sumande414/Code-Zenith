import 'package:cloud_firestore/cloud_firestore.dart';

List<String> friend_list = [];
addFriend(String handle, String username) async {
  await FirebaseFirestore.instance.collection(username).doc('doc').set({
    'friends_list': ['']
  });
}

addUser(String username, String handle) async {
  await FirebaseFirestore.instance
      .collection(username)
      .doc('doc')
      .set({'handle': handle, 'friends_list': []});
}
