import 'package:flutter/material.dart';
import 'package:recl/constants.dart';
import 'package:recl/screens/questionnaire.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recl/screens/todo_screen.dart';
import '../lib/auth_provider.dart';
// import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;
  // final _auth = FirebaseAuth.instance;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        //ModalProgressHUD(
        //inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Flexible(
              //   child: Hero(
              //     tag: 'logo',
              //     child: Container(
              //       height: 200.0,
              //       child: Image.asset('images/logo.png'),
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Text("Log In"),
                color: Colors.lightBlueAccent,
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    //final _auth = Provider.of<FirebaseAuth>(context, listen:false); // retrieve firebaseAuth from above in the widget tree
                    //final _provider = Provider.of(context);
                    final _auth = Provider.of<AuthProvider>(context);
                    final user = await _auth.signInEmail(email, password);
                    if (user != null) {
                      //Navigator.pushNamed(context, QuestionnaireScreen.id); //provider가 다른 tree에 있다는 err(from outside of the widget tree.)
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => TodoScreen(),
                        ),
                      );
                    }

                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    print(e);
                  }
                },
              ),
              FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, QuestionnaireScreen.id);
                  },
                  child: Text('questionnaire'))
            ],
          ),
        ),
      ),
    );
  }
}
