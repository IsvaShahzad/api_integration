// import 'dart:developer';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'login_req_model.dart';
//
// List<SubmitDetailsRequestModel> userModelFromJson(String str) =>
//     List<SubmitDetailsRequestModel>.from(json.decode(str).map((x) => SubmitDetailsRequestModel.fromJson(x)));
//
// class ApiService {
//   Future<List<SubmitDetailsRequestModel>?> submitDetails() async {
//     try {
//       var url = Uri.parse( 'http://attendance.skymart.com.pk/api/v1/addstudentinfo' + '/AddUser');
//       var response = await http.post(url);
//       if (response.statusCode == 200) {
//         List<SubmitDetailsRequestModel>
//         _model = userModelFromJson(response.body);
//         return _model;
//       }
//     } catch (e) {
//       log(e.toString());
//     }
//   }
// }
//
