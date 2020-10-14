import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../lib/auth_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/login.dart';
import '../screens/todo_screen.dart';

class LandingPage extends StatelessWidget {
  static const String id = 'landing_page';
  AuthProvider authProvider;
  @override
  Widget build(BuildContext context) {
    print('LandingPage build 시작');

    /*
    authProvider = Provider.of(context, listen: false);Widget body;
    if (authProvider != null) {
      print('${authProvider.toString()} / ${authProvider.user.toString()}');
      if (authProvider.isAuthenticated) {
        return TodoScreen();
      } else {
        return LoginScreen();
      }
    }*/
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ChangeNotifierProvider(
              // decendents route 들에서 context of provider 접근 위해 ChangeNotifireProvider() 내부에 child로 route 작성
              create: (_) => AuthProvider(), //build 는 deprecated 됨.
              child: Consumer<AuthProvider>(
                  //create 에 AuthProvider 생성자가 먼저 실행 되고 나서 initialRoute 가 로딩 되게끔 Consumer 작성
                  builder: (context, AuthProvider authProvider, _) {
                Widget childWidget = LoginScreen();
                if (authProvider != null) {
                  print(
                      '${authProvider.toString()} / ${authProvider.user.toString()}');
                  if (authProvider.isAuthenticated) {
                    childWidget = TodoScreen();
                  } else {
                    childWidget = LoginScreen();
                  }
                }
                return childWidget;
              }),
            );
          } else if (snapshot.hasError) {
            return Icon(
              Icons.home,
              color: Colors.red,
              size: 60,
            );
          }
          return Icon(
            Icons.home,
            color: Colors.red,
            size: 60,
          );
        });
  }
  /*Widget build(BuildContext context) {
    // retrieve firebaseAuth from above in the widget tree
    final firebaseAuth = Provider.of<FirebaseAuth>(context);
    return StreamBuilder<User>(
      stream: firebaseAuth.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User user = snapshot.data;
          if (user == null) {
            return LoginScreen();
          }
          return TodoScreen(); //todo screen user status에 따른 화면 구성 필요
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }*/
}
