import 'package:firebase_auth/firebase_auth.dart';
import 'package:friendz_code/functions/database_functions.dart';

signup(String email, String password, String handle, String username) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    addUser(username,email, handle);
    signin(email, password);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }
}

signin(String email, String password) async {
  try {
    await FirebaseAuth.instance.signOut();
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    print("Success");
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }
}
