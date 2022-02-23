import 'package:diary_app/services/date.dart';

class Diary{
  final d_id;
  final String date;
  final String content;
  final String user;

  const Diary({required this.date,required this.content, required this.d_id, required this.user});

  String getSubHeading(){
    if(content.length <= 10){
        return content;
    }
    return content.substring(0,10);
  }


  factory Diary.fromJSON(Map<String, dynamic> json){

    return Diary(
        d_id: json["_id"],
        date: json["date"],
        content: json["content"],
        user: json["user"]
    );

  }
  // "_id": "62077cf575a5812febe8b675",
  // "date": "2021-01-11T00:00:00.000Z",
  // "content": "This is first content.",
  // "user": "62066b85716a03aea270c426",
  // "__v": 0
}