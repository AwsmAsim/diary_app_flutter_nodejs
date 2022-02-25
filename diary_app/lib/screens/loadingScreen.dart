import 'package:diary_app/controller/DiaryController.dart';
import 'package:diary_app/controller/authentication_controller.dart';
import 'package:diary_app/screens/homepage.dart';
import 'package:diary_app/services/diary_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  static String ID = '/loadingScreen';

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  AuthenticationController auth = AuthenticationController();
  @override
  Widget build(BuildContext context) {
    // Provider.of<DiaryController>(context).fetchDiaries();
    return Consumer<DiaryController>(
      builder: (context, diary, _){
        // diary.fetchDiaries();

        return HomePage();
      },

    );
    // return FutureBuilder(
    //   future: diaryController.fetchDiaries(),
    //   builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    //     if(snapshot.connectionState == ConnectionState.done){
    //       return HomePage();
    //     }
    //     return Scaffold(
    //           body: Container(
    //             decoration: const BoxDecoration(
    //               color: Colors.blueAccent
    //             ),
    //             child: const Center(
    //               child: Text('Loading...',
    //                 style: TextStyle(
    //                   color: Colors.white,
    //                   fontSize: 30.0
    //                 ),
    //               ),
    //             ),
    //           ),
    //         );
    //   },
    // );
  }

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Provider.of<DiaryController>(context, listen: false).fetchDiaries();
    });
  }
}
