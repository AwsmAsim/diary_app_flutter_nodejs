import 'dart:convert';
import 'dart:io';
import 'package:diary_app/controller/DiaryController.dart';
import 'package:diary_app/models/logged_in_user.dart';
import 'package:diary_app/models/models.diary.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class DiaryApi extends ChangeNotifier{

  // var urlLink = 'http://192.168.100.141:3000/diary';
  var urlLink = 'http://localhost:3000/diary';

  Future<List> postDiary(String date, String content) async{
    if(LoggedInUser.uid!=null){
      String uid = LoggedInUser.uid ?? '';
      final body = {
        "user" : uid,
        "content" : content,
        "date" : date
      };
      final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
      // final uri = Uri.http('192.168.100.141:3000', '/diary');
      final uri = Uri.http('localhost:3000', '/diary');
      var response = await http.post(uri, body: jsonEncode(body), headers: headers);
      if(response.statusCode == 201){
        print('status code: 201, diary_api.dart L24');
        var obtainedList = [jsonDecode(response.body)];
        // print(obtainedList[0]);
        return obtainedList;
      }else{
        print('status code: ${response.statusCode}');
        return [];
      }
    }
    return [];
  }

  Future<List> getDiaries() async{
    if(LoggedInUser.uid != null){
      String uid = LoggedInUser.uid ?? '';
      // final uri = Uri.http('192.168.100.141:3000', '/diary/${LoggedInUser.uid}');
      final uri = Uri.http('localhost:3000', '/diary/${LoggedInUser.uid}');
      var response = await http.get(uri);

      if(response.statusCode == 200){
        print('status code: 200, diary_api.dart L37');
        // print(response.body);
        var obtainedList = List<Map<String, dynamic>>.from(jsonDecode(response.body));
        // print(obtainedList[0]);
        return obtainedList;
      }else{
        print('status code: ${response.statusCode}');
      }
    }else{
      print('User not logged in, diary_api.dart, L45 ');
      return [];
    }
    return [];
  }

  Future<Map<String, dynamic>> deleteDiary(String diaryId)async {
    if(LoggedInUser.uid!=null){
      final url = Uri.parse(urlLink+'/$diaryId');
      // final header = {'Content-Type': 'application/json'};
      var response = await http.delete(url);
      // print
      if(response.statusCode==200){
        return jsonDecode(response.body);
      }else{
        print(response.statusCode);
      }
    }else{
      return {};
    }
    return {};
  }

  Future<Map<String, dynamic>> updateDiary(Diary diary) async{

    if(LoggedInUser.uid!=null){
      final url = Uri.parse(urlLink + '/${diary.d_id}');
      final header = {'Content-Type': 'application/json'};
      var updateBody = {
        "content" : diary.content,
      };
      final response = await http.patch(url, headers: header, body: jsonEncode(updateBody));
      print(response.body);
      if(response.statusCode == 200){
        return jsonDecode(response.body);
      }else{
        print('status code ${response.statusCode}');
        return {};
      }
    }
    print('User not logged Inn');
    return {};
  }
}