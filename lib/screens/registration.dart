import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:recl/screens/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  /*@override
  void initState() {
    Firebase.initializeApp().whenComplete(() {
      setState(() {});
    });
    super.initState();
  }*/

  String email, password;
  /*final _auth = FirebaseAuth.instance;*/
  bool showProgress = false;

  /*Future<void> initializeDefault() async {
    FirebaseApp app = await Firebase.initializeApp();
    */ /*assert(app != null);
    print('Initialized default app $app');*/ /*
  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase Authentication"),
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            /*log(snapshot.error.toString());*/
            print(snapshot.error.toString());
            return Container(
              color: Colors.red,
            );
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            testDbGet(); //firestore test
            var _auth = FirebaseAuth.instance;

            return Center(
              child: ModalProgressHUD(
                inAsyncCall: showProgress,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Registration Page",
                      style: TextStyle(
                          fontWeight: FontWeight.w800, fontSize: 20.0),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        email = value; //get the value entered by user.
                      },
                      decoration: InputDecoration(
                          hintText: "Enter your Email",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0)))),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextField(
                      obscureText: true,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        password = value; //get the value entered by user.
                      },
                      decoration: InputDecoration(
                          hintText: "Enter your Password",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0)))),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Material(
                      elevation: 5,
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.circular(32.0),
                      child: MaterialButton(
                        onPressed: () async {
                          setState(() {
                            showProgress = true;
                          });
                          try {
                            final newuser =
                                await _auth.createUserWithEmailAndPassword(
                                    email: email, password: password);

                            if (newuser != null) {
                              print('firebase 결과 값 : ${newuser}');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()),
                              );
                              /*Navigator.pushNamed(context, LoginScreen.id);*/
                              setState(() {
                                showProgress = false;
                              });
                            }
                          } catch (e) {}
                        },
                        minWidth: 200.0,
                        height: 45.0,
                        child: Text(
                          "Register",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      },
                      child: Text(
                        "Already Registred? Login Now",
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.w900),
                      ),
                    )
                  ],
                ),
              ),
            );
          }

          // Otherwise, show something whilst waiting for initialization to complete
          return Container(
            color: Colors.blue,
          );
        },
      ),
    );
  }

  //하단 firestore 관련 함수
  void testDbGet() async {
    var _db = FirebaseFirestore.instance;
    //create document
    /*await _db.collection("books").doc("1").set({
      'title': 'Mastering Flutter',
      'description': 'Programming Guide for Dart'
    });*/
    /*DocumentReference ref = await _db.collection("books").add({
      'title': 'Flutter in Action',
      'description': 'Complete Programming Guide to learn Flutter'
    });
    print(ref.documentID);*/
    _db.collection("User").get().then((QuerySnapshot snapshot) {
      snapshot.docs
          .forEach((f) => print('${f.toString()} / ${f.id} / ${f.data}'));
    });
  }

  /*PublishSubject loading = PublishSubject();
  final Firestore _db = Firestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> googleSignIn() async {
    // Start
    loading.add(true);

    // Step 1
    //GoogleSignInAccount googleUser = await _googleSignIn.signIn();

    // Step 2
    //GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    //FirebaseUser user = await _auth.signInWithGoogle(
    //    accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    // Step 3
    //updateUserData(user);

    // Done
    loading.add(false);
    //print("signed in " + user.displayName);
    //return user;
  }

  void updateUserData(FirebaseUser user) async {
    DocumentReference ref = _db.collection('users').document(user.uid);

    return ref.setData({
      'uid': user.uid,
      'email': user.email,
      'photoURL': user.photoUrl,
      'displayName': user.displayName,
      'lastSeen': DateTime.now()
    }, merge: true);
  }*/
}
