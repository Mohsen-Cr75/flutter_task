import 'package:equatable/equatable.dart';

class Data extends Equatable {
  const Data(
      {required this.userId,
      required this.id,
      required this.title,
      required this.body});

  final int userId;
  final int id;
  final String title;
  final String body;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'userId': userId,
        'id': id,
        'title': title,
        'body': body,
      };

  factory Data.fromMap(Map<String, dynamic> json) => Data(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body']);

  @override
  List<Object?> get props => [userId, id, title, body];
}
