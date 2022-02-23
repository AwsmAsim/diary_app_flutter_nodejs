import 'package:diary_app/services/date.dart';
import 'package:flutter/material.dart';

class DiaryTile extends StatelessWidget {

  String date, subHeading;
  var onTap, onDeleteButtonPressed;
  DiaryTile({required this.date,required this.subHeading, this.onTap, this.onDeleteButtonPressed});
  Date date1 = Date();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          ListTile(
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: onDeleteButtonPressed,
            ),
            title: Text(date1.parseTime(date),
              style: const TextStyle(
                  fontWeight: FontWeight.bold
              ),
            ),
            subtitle: Text(subHeading),

          ),
          Container(
            height: 2,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              color: Colors.cyanAccent,
            ),
          )
        ],
      ),
    );
  }
}
