import 'package:diary_app/controller/DiaryController.dart';
import 'package:diary_app/controller/authentication_controller.dart';
import 'package:diary_app/models/logged_in_user.dart';
import 'package:diary_app/screens/login.dart';
import 'package:diary_app/screens/write_diary_page.dart';
import 'package:diary_app/services/diary_api.dart';
import 'package:diary_app/widgets/diary_tile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {

  static String ID = '/homepage';
  DiaryController diaryController = DiaryController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.login), onPressed: (){
          Provider.of<DiaryController>(context, listen: false).clearDiaries();
          Provider.of<AuthenticationController>(context, listen: false).logOutUser();
          Navigator.of(context).pushNamedAndRemoveUntil(LoginPage.ID, (Route<dynamic> route) => false);
        },),
        title: const Center(child: Text('Your Diaries',
          style: TextStyle(
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        backgroundColor: Colors.cyanAccent,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyanAccent,
        onPressed: (){
          // TODO : Solve this null poblrm, easy alternative is to create a null pGE.
          Navigator.of(context).pushNamed(WriteDiaryPage.ID, arguments: {"diary" : null});
          // DiaryController().fetchDiaries();
          // Provider.of<DiaryController>(context, listen: false).fetchDiaries();
        },
        child: Container(
            child: Icon(Icons.add)),
        focusColor: Colors.cyanAccent,
      ),
      body: Container(
        color: Colors.cyanAccent,
        padding: const EdgeInsets.all(20.0),
        child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20.0))
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: Text('Hey, ${LoggedInUser.name}! Here are your diaries',
                  style: GoogleFonts.lobster(),
                  textAlign: TextAlign.left,
                ),
              ),
              Expanded(
                child: Container(
                      child: Consumer<DiaryController>(
                        builder: (context, diary, _){

                          if(diary.diaryList.isNotEmpty){
                            // print(diary.diaryList.length);
                            return ListView.builder(
                                  itemCount: diary.diaryList.length,
                                  itemBuilder: (BuildContext context, int index){
                                    if(diary.diaryList.isNotEmpty){
                                      return DiaryTile(date: diary.diaryList[index].date, subHeading: diary.diaryList[index].getSubHeading(),
                                          onTap: (){
                                            // diary.updateDiaries(diary.diaryList[index]);
                                            Navigator.pushNamed(context, WriteDiaryPage.ID, arguments: {"diaryObj": diary.diaryList[index]});

                                          },
                                        onDeleteButtonPressed: (){
                                          diary.deleteDiaries(diary.diaryList[index]);
                                          print('delete button pressed');
                                        },
                                      );
                                    }else{
                                      return const Center(child: Text('No Diaries Found'));
                                    }
                                  },
                                );
                          }else{
                            return Container(
                                    height: MediaQuery.of(context).size.height - 200,
                                    child: Center(child: Text('No diaries...'),),
                                  );
                          }
                        },
                      ),
                      // child: FutureBuilder(
                      //   future: diaryController.fetchDiaries(),
                      //   builder: (context, snapshot) {
                      //     if(snapshot.connectionState == ConnectionState.done){
                      //       return ListView.builder(
                      //         itemCount: diaryController.diaryList.length,
                      //         itemBuilder: (BuildContext context, int index){
                      //           if(diaryController.diaryList.isNotEmpty){
                      //             return DiaryTile(date: diaryController.diaryList[index].date, subHeading: diaryController.diaryList[index].getSubHeading(),
                      //                 onTap: (){
                      //                   Navigator.pushNamed(context, WriteDiaryPage.ID);
                      //                 });
                      //           }else{
                      //             return const Center(child: Text('No Diaries Found'));
                      //           }
                      //         },
                      //       );
                      //     }else{
                      //       return Container(
                      //         height: MediaQuery.of(context).size.height - 200,
                      //         child: Center(child: Text('Loading...'),),
                      //       );
                      //     }
                      //   }
                      // ),
                    ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
