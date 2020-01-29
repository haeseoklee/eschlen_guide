import 'package:firebase_auth/firebase_auth.dart';

class AuthManager{
  final _auth = FirebaseAuth.instance;

  Future<FirebaseUser> signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<FirebaseUser> getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        return user;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}