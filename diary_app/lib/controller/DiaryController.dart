import 'package:diary_app/models/models.diary.dart';
import 'package:diary_app/services/diary_api.dart';
import 'package:flutter/cupertino.dart';

class DiaryController extends ChangeNotifier{
  DiaryApi api = DiaryApi();
  List<Diary> diaryList = [Diary(date: 'date', content: 'content', d_id: 'd_id', user: 'user')];

  Future<void> fetchDiaries() async{
    List obtainedList = await api.getDiaries();
    if(obtainedList.length > 1){
      List<Diary> tDiaryList = [];
      obtainedList.forEach((diaryJson) {
        tDiaryList.add(Diary.fromJSON(diaryJson));
      });
      // print(diaryList[0].date);
      diaryList = tDiaryList;
      notifyListeners();
    }
  }

  void postDiaries(String date, String content) async{
    List posted = await api.postDiary(date, content);
    diaryList.add(Diary.fromJSON(posted[0]));
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
    if(updatedValues.keys.length > 1){
      var idx = diaryList.indexOf(diary);
      diaryList.removeAt(idx);
      diaryList.insert(idx, Diary.fromJSON(updatedValues));
      notifyListeners();
    }else{
      print('error');
    }
  }

}