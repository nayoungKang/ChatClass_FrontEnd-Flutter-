import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserRepository with ChangeNotifier {
  FirebaseAuth _auth;
  User _user;
  //GoogleSignIn _googleSignIn;
  Status _status = Status.Uninitialized;

  UserRepository({auth}) {
    print('UserRepository Constructor 시작');
    //Firebase.initializeApp();
    _auth = auth ?? FirebaseAuth.instance;

    _auth.authStateChanges().listen((User newUser) {
      print('AuthProvider - FirebaseAuth - onAuthStateChanged - $newUser');
      _user = newUser;
      if (user == null) {
        _status = Status.Unauthenticated;
        print(
            'AuthProvider - FirebaseAuth - onAuthStateChanged to Status Unauthenticated- $newUser');
      } else {
        _user = user;
        _status = Status.Authenticated;
        print(
            'AuthProvider - FirebaseAuth - onAuthStateChanged to Status to Status Authenticated- $newUser');
      }
      print('status : ${_status}');
      notifyListeners();
    }, onError: (e) {
      print('AuthProvider - FirebaseAuth - onAuthStateChanged Error- $e');
    });
  }

  /*UserRepository.instance()
      : _auth = FirebaseAuth.instance,
        _googleSignIn = GoogleSignIn() {
    //_auth.onAuthStateChanged.listen(_onAuthStateChanged);
    _auth.authStateChanges().listen((User user) {
      if (user == null) {
        _status = Status.Unauthenticated;
      } else {
        _user = user;
        _status = Status.Authenticated;
      }
      notifyListeners();
    });
  }*/

  Status get status => _status;
  User get user => _user;

  Future<bool> signIn(String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      _user = await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => user);
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

/*  Future<bool> signInWithGoogle() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _auth.signInWithCredential(credential);
      return true;
    } catch (e) {
      print(e);
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }*/

  Future signOut() async {
    _auth.signOut();
    //_googleSignIn.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<void> _onAuthStateChanged(FirebaseUser firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = firebaseUser;
      _status = Status.Authenticated;
    }
    notifyListeners();
  }
}
