import 'dart:developer';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;


class AddStudentInfo extends StatefulWidget {
  @override
  State<AddStudentInfo> createState() => _AddStudentInfoState();
}

class _AddStudentInfoState extends State<AddStudentInfo> {
  bool isLoading = false;
  Future<void> submitDetails() async {
    isLoading = true;

    // var params =

    //
    //
    // // SubmitDetailsRequestModel(
    // //   name: nameController.text,
    // //   fathername: fathernameController.text,
    // //   cnic: cnicController.text,
    // //   rollno: rollnumberController.text,
    // //   image: imageController.;
    // // );
    // print('this is my request : ${params.toJson()}');
    try {

      var request =  http.MultipartRequest(
          'POST', Uri.parse('http://attendance.skymart.com.pk/api/v1/addstudentinfo')

      );
      request.fields['name'] = nameController.text;
      request.fields['fathername'] = fathernameController.text;
      request.fields['cnic'] = cnicController.text;
      request.fields['rollno'] = rollnumberController.text;
      request.files.add(await http.MultipartFile.fromPath(
          'image',
          frontSideImage!.path
      )
      );
      var response = await request.send();
      print(response.stream);
      print(response.statusCode);
      final res = await http.Response.fromStream(response);
      print(res.body);
      if(response.statusCode==200){

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('added data successfully'),

        ),);
      }else
        {
          ScaffoldMessenger.of(context).showSnackBar(

              const SnackBar(
              content: Text('error!'),));
        }


    // var response = await http.post(url, body: params.toJson());
    //   if (response.statusCode == 200) {
    //     isLoading = false;
    //     print('Submitted');
    //   }
      isLoading = false;
    } catch (e) {
      log(e.toString());  //doesnt have limit
      isLoading = false;
    }
  }
  // Home home= Home();
  PickedFile? frontSideImage;
  String? frontImageBase64;
  String pathBackImage = 'b';
  String pathFrontImage = 'f';
  var frontImageFileName = 'N/A';

  final loginFormKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController fathernameController = TextEditingController();
  final TextEditingController cnicController = TextEditingController();
  final TextEditingController rollnumberController = TextEditingController();
  final TextEditingController imageController = TextEditingController();

  Future imageSelector(BuildContext context, String pickerType) async {
    switch (pickerType) {
      case 'camera': // CAMERA CAPTURE CODE

        frontSideImage = await ImagePicker()
            .getImage(source: ImageSource.camera, imageQuality: 50);

        break;

      case 'gallery':
        frontSideImage = await ImagePicker()
            .getImage(source: ImageSource.gallery, imageQuality: 50);

        break;
    }

    setState(() {
      if (pickerType == 'camera') {
        pathFrontImage =
            frontSideImage!.path.substring(80, frontSideImage!.path.length);

        var imagePath = frontSideImage!.path;

        frontImageFileName = (imagePath.split('/').last);

        print(frontImageFileName.toString());
      } else {
        pathFrontImage =
            frontSideImage!.path.substring(60, frontSideImage!.path.length);

        var imagePath = frontSideImage!.path;

        frontImageFileName = (imagePath.split('/').last);

        print(frontImageFileName.toString());
      }
    });

    if (frontSideImage != null) {
      print('this is the path');

      print(frontSideImage!.path);

      var imageBytes = await frontSideImage!.readAsBytes();

      setState(() {
        frontSideImage= PickedFile(frontSideImage!.path);
      });
    }
  }

  ///bottomsheet to select camera or gallery icon(front img)

  void showPickerForFrontImg(context) {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SizedBox(
              height: 150,
              child: Wrap(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(
                      Icons.photo_camera,
                      color: Colors.orange,
                    ),
                    title: const Text('Camera'),
                    onTap: () {
                      imageSelector(context, 'camera');

                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                      leading: const Icon(
                        Icons.photo_library,
                        color: Colors.orange,
                      ),
                      title: const Text('Pick From Gallery'),
                      onTap: () {
                        imageSelector(context, 'gallery');

                        Navigator.of(context).pop();
                      }),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
            key: loginFormKey,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    SingleChildScrollView(
                        child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(top: 60.0),
                                      child: Text(
                                        'Log In Screen',
                                        style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.teal,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 20.0),
                                            child: Text('Name',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                )),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          TextFormField(
                                            controller: nameController,
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            decoration: InputDecoration(
                                              fillColor:
                                                  Colors.white.withOpacity(0.1),
                                              hintText: 'Enter your name',
                                              hintStyle:
                                                  TextStyle(fontSize: 15),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            // keyboardType: TextInputType.number,

                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please Enter Some Text ';
                                              }
                                              return null;
                                            },
                                          ),
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          Text('Father Name',
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              )),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          TextFormField(
                                            controller: fathernameController,
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            decoration: InputDecoration(
                                              fillColor:
                                                  Colors.white.withOpacity(0.1),
                                              hintText: 'Enter text',
                                              hintStyle:
                                                  TextStyle(fontSize: 15),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please Enter Some Text ';
                                              }
                                              return null;
                                            },
                                          ),
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          Text('CNIC',
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              )),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          TextFormField(
                                            controller: cnicController,
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            decoration: InputDecoration(
                                              fillColor:
                                                  Colors.white.withOpacity(0.1),
                                              hintText:
                                                  'Enter your cnic number',
                                              hintStyle:
                                                  TextStyle(fontSize: 15),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please Enter Some Text ';
                                              }
                                              return null;
                                            },
                                          ),
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          Text('roll number',
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              )),
                                          TextFormField(
                                            controller: rollnumberController,
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            decoration: InputDecoration(
                                              fillColor:
                                                  Colors.white.withOpacity(0.1),
                                              hintText:
                                                  'Enter your roll number',
                                              hintStyle:
                                                  TextStyle(fontSize: 15),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please Enter Some Text ';
                                              }
                                              return null;
                                            },
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Text(
                                            'Pictures',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          TextButton(
                                              onPressed: () {
                                                showPickerForFrontImg(context);
                                              },
                                              child: Text('Get image')),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 20),
                                              child: isLoading == true
                                                  ? CircularProgressIndicator()
                                                  : ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary:
                                                            Color(0xFF289488),
                                                        onPrimary: Colors.white,
                                                        elevation: 3,
                                                        minimumSize:
                                                            const Size(200, 50),
                                                        maximumSize:
                                                            const Size(200, 50),
                                                        shape: StadiumBorder(),
                                                      ),
                                                      child: Text('Submit',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16)),
                                                      onPressed: () async {
                                                        if (loginFormKey
                                                            .currentState!
                                                            .validate())
                                                          await submitDetails();
                                                         // home.multipartProcedure();
                                                      },
                                                    ),
                                            ),
                                          )
                                        ]),
                                  ),
                                ])))
                  ],
                )))));
  }
}
