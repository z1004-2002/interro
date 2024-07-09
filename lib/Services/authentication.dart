import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethod {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// SignUp User
  Future<String> signupUser({
    required String email,
    required String phone,
    required String password,
    required String name,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty || name.isNotEmpty) {
        // register user in auth with email and password

        // add user to your  firestore database
        QuerySnapshot snap = await FirebaseFirestore.instance
            .collection('users')
            .where("phone", isEqualTo: phone)
            .get();
        if (snap.docs.isEmpty) {
          UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );
          await _firestore.collection("users").doc(cred.user!.uid).set({
            'name': name,
            'uid': cred.user!.uid,
            'email': email,
            'phone': phone,
          });

          res = "success";
        } else {
          return "user already registered";
        }
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  /// logIn user
  Future<String> loginUser({
    required String phone,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      if (phone.isNotEmpty || password.isNotEmpty) {
        QuerySnapshot snap = await FirebaseFirestore.instance
            .collection('users')
            .where("phone", isEqualTo: phone)
            .get();
        if (snap.docs.isNotEmpty) {
          String email = snap.docs[0]['email'];
          await _auth.signInWithEmailAndPassword(
            email: email,
            password: password,
          );
          res = "success";
        } else {
          res = "Utilisateur non trouvé";
        }
        // logging in user with email and password
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  /// for sighout
  signOut() async {
    await _auth.signOut();
  }
}
