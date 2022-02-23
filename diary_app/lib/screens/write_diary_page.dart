import 'package:diary_app/controller/DiaryController.dart';
import 'package:diary_app/models/models.diary.dart';
import 'package:diary_app/screens/homepage.dart';
import 'package:diary_app/services/date.dart';
import 'package:diary_app/widgets/page_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WriteDiaryPage extends StatelessWidget {

  static String ID = '/diary';

  TextEditingController content = TextEditingController();
  String date = '2020-2-4';
  bool update = false;
  Diary? diary;
  Date dateParser = Date();
  WriteDiaryPage({this.diary});

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as Map;

    if (arguments != null) {
      diary = arguments["diaryObj"];
      if(diary != null)
      update = true;
    }
    void diaryText(){
      content.text = diary?.content ?? '';
      print(diary);
    }
    diaryText();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Write Diary'),
          backgroundColor: Colors.cyanAccent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(onPressed: (){
              if(update){
                Diary d3 = diary?? Diary(content: '', d_id: '', user: '', date: '');
                Diary d2 = Diary(date: d3.date, content: content.text, d_id: d3.d_id, user: d3.user);
                // Since we know when update is true diary will not be null.

                Provider.of<DiaryController>(context, listen: false).updateDiaries(d2);
                Navigator.of(context).pushNamedAndRemoveUntil(HomePage.ID, (Route<dynamic> route) => false);
              }else{
                Provider.of<DiaryController>(context, listen: false).postDiaries(date, content.text);
                Navigator.of(context).pushNamedAndRemoveUntil(HomePage.ID, (Route<dynamic> route) => false);
              }

            }, icon: Icon(Icons.save))
          ],
        ),
        body: PageBorder(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(diary?.date ?? dateParser.currentParsedTime(),
                  style: const TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Container(
                  child: Container(
                    child: TextField(
                      controller: content,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Your Note"
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ),
    );
  }
}
