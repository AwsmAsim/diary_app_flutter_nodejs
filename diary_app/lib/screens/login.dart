import 'package:diary_app/controller/DiaryController.dart';
import 'package:diary_app/controller/authentication_controller.dart';
import 'package:diary_app/screens/homepage.dart';
import 'package:diary_app/screens/loadingScreen.dart';
import 'package:diary_app/screens/register.dart';
import 'package:diary_app/widgets/form_text_field.dart';
import 'package:diary_app/widgets/log_in_button.dart';
import 'package:diary_app/widgets/page_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  static String ID = '/login';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.cyanAccent,
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              Container(
                height: MediaQuery.of(context).size.height-100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                // Text('Enter id:',
                //
                // ),
                  Center(
                    child: Text('Login',
                      style: GoogleFonts.lobster(
                          color: Colors.white,
                          fontSize: 45.0
                      ),
                    ),
                  ),
                // const SizedBox(height: 20.0,),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width/3,
                    decoration: BoxDecoration(
                    ),
                    child: Image.asset('assets/images/diary_logo.png'),
                  ),
                ),
                // const SizedBox(height: 10.0),
                Column(
                  children:  [

                    // Email Text Field
                    FormTextField(
                      hintText: 'Enter Email',
                      controller: emailController,
                    ),
                    SizedBox(height: 20.0,),
                    FormTextField(
                        hintText: 'Enter Password',
                        controller: passwordController,
                        obscureText : true,
                    )
                  ],
                ),
                    Column(
                      children: [
                        Center(
                            child: LoginButton(text: 'Log In', onPressed: () async{

                              AuthenticationController authController = AuthenticationController();
                              var loginStatus = await authController.loginUser(emailController.text, passwordController.text);
                              if(loginStatus){
                                Provider.of<DiaryController>(context, listen: false).fetchDiaries();
                                Navigator.of(context).popAndPushNamed(LoadingScreen.ID);
                                // Navigator.of(context).popAndPushNamed(HomePage.ID);
                              }else{
                                print('Login Failed, login.dart, loginStatus $loginStatus');
                              }
                            })
                        ),
                        // SizedBox(height: 20.0,),
                        Center(
                            child: LoginButton(text: 'Sign Up', onPressed: () async{
                                Navigator.of(context).pushNamed(RegisterPage.ID);
                            })
                        ),
                      ],
                    )

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
