import 'package:diary_app/models/logged_in_user.dart';

class User{

  final email;
  final uid;
  final name;

  User({required this.email, required this.uid, required this.name}){
    LoggedInUser.uid = uid;
    LoggedInUser.email = email;
    LoggedInUser.name = name;

  }

  factory User.fromJSON(Map<String, dynamic> json){
    return User(
      email: json['email'],
      uid: json['_id'],
      name: json['name']
    );
  }

}