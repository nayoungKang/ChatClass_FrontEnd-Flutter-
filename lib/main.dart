import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:recl/lib/auth_provider.dart';
import 'screens/login.dart';
import 'lib/user_repository.dart';
import 'screens/questiondetail_screen.dart';
import 'screens/questionnaire.dart';
import 'screens/registration.dart';
import 'screens/todo_screen.dart';
import 'widgets/landing_widget.dart';

import 'lib/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserRepository(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserRepository>(context);
    switch (user.status) {
      case Status.Uninitialized:
        return Splash();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return LoginPage();
      case Status.Authenticated:
        return TodoScreen(); //Todo Module 2개로 구성할 것.
      /*case Status.Authenticated:
        return UserInfoPage(user: user.user);*/

    }
    /*return ChangeNotifierProvider(
      create: (_) => UserRepository(),
      child: Consumer<UserRepository>(
        builder: (context, UserRepository user, _) {
          print('HomPage builder 시작');
          switch (user.status) {
            case Status.Uninitialized:
              return Splash();
            case Status.Unauthenticated:
            case Status.Authenticating:
              return LoginPage();
            case Status.Authenticated:
              return UserInfoPage(user: user.user);
          }
        },
      ),
    );*/
  }
}

class UserInfoPage extends StatelessWidget {
  final User user;

  const UserInfoPage({Key key, this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Info"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(user.email),
            RaisedButton(
              child: Text("SIGN OUT"),
              onPressed: () =>
                  Provider.of<UserRepository>(context, listen: false).signOut(),
            )
/*
      Tried to listen to a value exposed with provider, from outside of the widget tree.
      This is likely caused by an event handler (like a button's onPressed) that called
      Provider.of without passing `listen: false`.
*/
          ],
        ),
      ),
    );
  }
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Text("Splash Screen"),
      ),
    );
  }
}
