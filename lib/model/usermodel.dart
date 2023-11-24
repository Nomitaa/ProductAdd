import 'package:cloud_firestore/cloud_firestore.dart';

UserModel? usermodel;

class UserModel {
  String name;
  DateTime? createdtime;
  DateTime? logintime;
  DocumentReference? reference;
  String id;

  UserModel({
    this.reference,
    required this.name,
    this.createdtime,
    this.logintime,
    required this.id,
  });

  UserModel.fromjson(Map<String, dynamic> json)
      : reference = json['reference'],
        name = json['name'],
        id = json['id'],
        createdtime = json['createdtime'].toDate(),
        logintime = json['logintime'].toDate();

  Map<String, dynamic> tojson() => {
        "reference": reference,
        'name': name,
        'createdtime': createdtime,
        'logintime': logintime,
        "id": id,
      };

  UserModel copywith({
    DocumentReference? reference,
    String? name,
    String? id,
  }) =>
      UserModel(
        reference: reference ?? this.reference,
        name: name ?? this.name,
        id: id ?? this.id,
      );
}
