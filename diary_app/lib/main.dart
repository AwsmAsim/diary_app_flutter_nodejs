import 'package:diary_app/controller/DiaryController.dart';
import 'package:diary_app/controller/authentication_controller.dart';
import 'package:diary_app/screens/homepage.dart';
import 'package:diary_app/screens/loadingScreen.dart';
import 'package:diary_app/screens/login.dart';
import 'package:diary_app/screens/register.dart';
import 'package:diary_app/screens/splash.dart';
import 'package:diary_app/screens/write_diary_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(App());
}

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    AuthenticationController auth = AuthenticationController();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>DiaryController()),
        ChangeNotifierProvider(create: (context)=>AuthenticationController())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: auth.isLoggedIn ? LoadingScreen() : LoginPage(),
        routes: {
          HomePage.ID : (context)=>HomePage(),
          LoginPage.ID : (context) => LoginPage(),
          RegisterPage.ID : (context) => RegisterPage(),
          SplashScreen.ID : (context) => SplashScreen(),
          WriteDiaryPage.ID : (context) => WriteDiaryPage(),
          LoadingScreen.ID : (context) => LoadingScreen()
        },
      ),
    );
  }
}

// class InitialPage extends StatelessWidget {
//   AuthenticationController auth = AuthenticationController();
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

