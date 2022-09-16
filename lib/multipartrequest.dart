// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// import 'login_req_model.dart';
// class Home {
//
//   multipartProcedure() async {
//
//
//
//     //for multipartrequest
//     var request = http.MultipartRequest('POST', Uri.parse('http://attendance.skymart.com.pk/api/v1/addstudentinfo'));
//
//
//
//     //for completeing the request
//
//
//     var response =await request.send();
//
//
//
//     //for getting and decoding the response into json format
//     var responsed = await http.Response.fromStream(response);
//     final responseData = json.decode(responsed.body);
//
//
//
//     if (response.statusCode==200) {
//
//       print("SUCCESS");
//       print(responseData);
//     }
//     else {
//       print("ERROR");
//     }
//   }}