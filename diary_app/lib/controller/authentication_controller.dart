import 'dart:convert';
import 'package:diary_app/controller/DiaryController.dart';
import 'package:diary_app/models/logged_in_user.dart';
import 'package:diary_app/models/models.user.dart';
import 'package:diary_app/services/login_api.dart';
import 'package:diary_app/services/register_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class AuthenticationController extends ChangeNotifier{

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;
  set isLoggedIn(bool status){
    _isLoggedIn = status;
  }

  void checkLogin(){
    if(LoggedInUser.uid != null){
      _isLoggedIn = true;
    }
    _isLoggedIn = false;
    notifyListeners();
  }

  Future<bool> loginUser(String email, String password) async {
    LoginApi api = LoginApi(email, password);
    Response response = await api.loginWithEmailPassword();
    print(response.statusCode);
    if(response.statusCode==200){
      User.fromJSON(jsonDecode(response.body));
      DiaryController().fetchDiaries();
      checkLogin();
      return true;
    }
    return false;
  }

  Future<bool> registerUser(String name, String email, String password) async{
    RegisterAPI api = RegisterAPI(email, password, name);
    Response response = await api.registerWithEmailPassword();
    if(response.statusCode==201){

      User.fromJSON(jsonDecode(response.body));
      checkLogin();
      return true;
    }
    print(response.statusCode);

    return false;
  }

}