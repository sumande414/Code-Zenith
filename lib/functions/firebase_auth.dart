import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:friendz_code/functions/database_functions.dart';

signup(
    {required String email,
    required String password,
    required String handle,
    required String username}) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    addUser(username: username, email: email, handle: handle);
    addFriend(email: email, handle: handle, nickname: "You");
    signin(email: email, password: password);
  } on FirebaseAuthException catch (e) {
    Fluttertoast.showToast(msg: e.message.toString());
  }
}

signin({required String email, required String password}) async {
  try {
    Fluttertoast.showToast(msg: "Signing in...");

    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  } on FirebaseAuthException catch (e) {
    Fluttertoast.showToast(msg: e.message.toString());
  }
}
