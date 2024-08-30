import 'package:equatable/equatable.dart';
import 'package:flutter_task/futures/domain/data_model.dart';

class ResponseModel extends Equatable {
  const ResponseModel(
      {
      required this.statusCode,
      required this.title,
      required this.users
      });

  final int statusCode;
  final String title;
  final List<Data> users;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'userId': statusCode,
        'title': title,
        'users': users.map((data) => data.toMap()).toList(),
      };

  factory ResponseModel.fromMap(Map<String, dynamic> json) => ResponseModel(
      statusCode: json['statusCode'],
      title: json['title'],
      users:  (json['users'] as List<dynamic>).map((item) => Data.fromMap(item)).toList(),
      );



  @override
  List<Object?> get props => [statusCode, title, users];
}
