import 'dart:io';

class SubmitDetailsRequestModel {
  SubmitDetailsRequestModel({
    required this.name,
    required this.fathername,
    required this.cnic,
    required this.rollno,
    required this.image,
  });
  late final String name;
  late final String fathername;
  late final String cnic;
  late final String rollno;
  late final File image;

  SubmitDetailsRequestModel.fromJson(Map<String, dynamic> json){
    name = json['name'];
    fathername = json['fathername'];
    cnic = json['cnic'];
    rollno = json['rollno'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['fathername'] = fathername;
    _data['cnic'] = cnic;
    _data['rollno'] = rollno;
    _data['image'] = image;
    return _data;
  }
}