import 'package:diary_app/models/models.diary.dart';
import 'package:diary_app/services/diary_api.dart';
import 'package:flutter/cupertino.dart';

class DiaryController extends ChangeNotifier{
  DiaryApi api = DiaryApi();
  List<Diary> diaryList = [];

  Future<void> fetchDiaries() async{
    List obtainedList = await api.getDiaries();
      List<Diary> tDiaryList = [];
    if(obtainedList.length > 1){
      obtainedList.forEach((diaryJson) {
        tDiaryList.add(Diary.fromJSON(diaryJson));
      });
    print('owaowowaoawao');
      // print(diaryList[0].date);
      diaryList = tDiaryList;
      print('obtained diaries:');
      print(diaryList);
      notifyListeners();
    }
  }

  void postDiaries(String date, String content) async{
    List posted = await api.postDiary(date, content);
    diaryList.insert(0, Diary.fromJSON(posted[0]));
    // diaryList.add(Diary.fromJSON(posted[0]));
    notifyListeners();
  }

  void deleteDiaries(Diary diary) async{
    Map<String, dynamic> deleted = await api.deleteDiary(diary.d_id);
    print(deleted);
    if(deleted.keys.length>1){
      diaryList.remove(diary);
      notifyListeners();
    }else{
      print('error');
    }
  }

  void updateDiaries(Diary diary) async{
    Map<String, dynamic> updatedValues = await api.updateDiary(diary);
    // print(diaryList.indexOf(diary));
    if(updatedValues.keys.length > 1){
      var idx = diaryList.indexWhere((diary)=>diary.d_id == updatedValues["_id"]);
      diaryList[idx] = Diary.fromJSON(updatedValues);
      // diaryList.removeAt(idx);
      // diaryList.insert(idx, Diary.fromJSON(updatedValues));
      notifyListeners();
    }else{
      print('error');
    }
  }

  void clearDiaries(){
    diaryList = [];
    notifyListeners();
  }

}