import 'package:diary_app/controller/authentication_controller.dart';
import 'package:diary_app/widgets/form_text_field.dart';
import 'package:diary_app/widgets/log_in_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'homepage.dart';
import 'loadingScreen.dart';

class RegisterPage extends StatelessWidget {

  static String ID = '/register';

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon:  Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: Colors.cyanAccent,
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height-100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Text('Enter id:',
                  //
                  // ),
                  Center(
                    child: Text('Register',
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

                      FormTextField(
                        hintText: 'Full Name',
                        controller: nameController,
                      ),
                      SizedBox(height: 20.0,),

                      // Email Text Field
                      FormTextField(
                        hintText: 'Enter Email',
                        controller: emailController,
                      ),
                      SizedBox(height: 20.0,),

                      //Password Text Field
                      FormTextField(
                        hintText: 'Enter Password',
                        controller: passwordController,
                        obscureText : true,
                      )
                    ],
                  ),
                  Center(
                      child: LoginButton(text: 'Sign Up', onPressed: () async{
                        AuthenticationController authController = AuthenticationController();
                        var authStatus = await authController.registerUser(nameController.text, emailController.text, passwordController.text);
                        if(authStatus){
                          Navigator.of(context).pushNamedAndRemoveUntil(LoadingScreen.ID, (Route<dynamic> route) => false);
                        }else{
                          print('Registration Failed !');
                        }
                        // Navigator.of(context).popAndPushNamed(HomePage.ID);
                      })
                  ),
                  const SizedBox(height: 20.0,)

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
