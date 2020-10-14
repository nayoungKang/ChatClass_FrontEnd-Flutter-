import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recl/lib/auth_provider.dart';
import 'screens/login.dart';
import 'screens/questiondetail_screen.dart';
import 'screens/questionnaire.dart';
import 'screens/registration.dart';
import 'screens/todo_screen.dart';
import 'widgets/landing_widget.dart';

import 'lib/auth_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LandingPage(),
      /*initialRoute:
                      LandingPage.id, //RegistrationScreen.id, //LoginScreen.id,
                  routes: {
                    LandingPage.id: (context) => LandingPage(),
                    RegistrationScreen.id: (context) => RegistrationScreen(),
                    LoginScreen.id: (context) => LoginScreen(),
                    */ /*QuestionnaireScreen.id: (context) => QuestionnaireScreen(),*/ /*
                    */ /*QuestionnaireScreen.id: (context) => ExampleApp(),*/ /*
                    QuestionnaireScreen.id: (context) => TodoScreen(),
                    QuestionDetailScreen.id: (context) => QuestionDetailScreen()
                  },*/
    );
  }
}
//2차 주석
/*ChangeNotifierProvider<AuthProvider>(
      create: (_) {
        print('main ChangeNotifierProvider create 시작');
        return new AuthProvider();
      },
      child: Consumer<AuthProvider>(
        builder: (context, model, child) => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          initialRoute:
              LandingPage.id, //RegistrationScreen.id, //LoginScreen.id,
          routes: {
            LandingPage.id: (context) => LandingPage(),
            RegistrationScreen.id: (context) => RegistrationScreen(),
            LoginScreen.id: (context) => LoginScreen(),
            */ /*QuestionnaireScreen.id: (context) => QuestionnaireScreen(),*/ /*
            */ /*QuestionnaireScreen.id: (context) => ExampleApp(),*/ /*
            QuestionnaireScreen.id: (context) => TodoScreen(),
            QuestionDetailScreen.id: (context) => QuestionDetailScreen()
          },
        ),
      ),
    );*/

//1차 주석
/*MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: LandingPage.id, //RegistrationScreen.id, //LoginScreen.id,
        routes: {
          LandingPage.id: (context) => LandingPage(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          */ /*QuestionnaireScreen.id: (context) => QuestionnaireScreen(),*/ /*
          */ /*QuestionnaireScreen.id: (context) => ExampleApp(),*/ /*
          QuestionnaireScreen.id: (context) => TodoScreen(),
          QuestionDetailScreen.id: (context) => QuestionDetailScreen()
        },
      ),
    );*/

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'Coflutter'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);
//
//   final String title;
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             RaisedButton(
//               child: Text('Show Material Dialog'),
//               onPressed: _showMaterialDialog,
//             ),
//             RaisedButton(
//               child: Text('Show Cupertino Dialog'),
//               onPressed: _showCupertinoDialog,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   _showMaterialDialog() {
//     showDialog(
//         context: context,
//         builder: (_) => new AlertDialog(
//               title: new Text("Material Dialog"),
//               content: new Text("Hey! I'm Coflutter!"),
//               actions: <Widget>[
//                 FlatButton(
//                   child: Text('Close me!'),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                 )
//               ],
//             ));
//   }
//
//   _showCupertinoDialog() {
//     showDialog(
//         context: context,
//         builder: (_) => new CupertinoAlertDialog(
//               title: new Text("Cupertino Dialog"),
//               content: new Text("Hey! I'm Coflutter!"),
//               actions: <Widget>[
//                 FlatButton(
//                   child: Text('Close me!'),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                 )
//               ],
//             ));
//   }
// }
