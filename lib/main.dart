import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 804),
      minTextAdapt: true,
     builder:(BuildContext context, Widget? child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
         theme: ThemeData(
           primarySwatch: Colors.teal,
           inputDecorationTheme: const InputDecorationTheme(
             enabledBorder: OutlineInputBorder(
               borderSide: BorderSide(width: 1, color: Color(0xFF289488)),
               borderRadius: BorderRadius.all(Radius.circular(20)),
             ),
             focusedBorder: OutlineInputBorder(
               borderSide: BorderSide(width: 1, color: Color(0xFF289488)),
               borderRadius: BorderRadius.all(Radius.circular(20)),
             ),
           ),
         ),
         home: AddStudentInfo(),
       );
     },
    );
  }
}
