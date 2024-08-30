import 'dart:convert';

import 'package:flutter_task/futures/domain/response_model.dart';

import 'package:http/http.dart' as http;

import '../domain/data_model.dart';

class RepasitoryImpl {
  



Future<ResponseModel> getUsersData() async {
  final url = Uri.parse('https://jsonplaceholder.typicode.com/posts'); // لینک درخواست
  
 try {
  final response = await http.get(url); // ارسال درخواست GET
  if (response.statusCode == 200) {
    // استاتوس 200 یعنی نتجه درخواست موفق 
    final List<dynamic> jsonData = jsonDecode(response.body); // تبدیل JSON به List
    final List<Data> dataList = jsonData.map((item) => Data.fromMap(item)).toList(); // تبدیل به لیست از Data
    return ResponseModel(
      statusCode: response.statusCode,
      title: 'Success',
      users: dataList,
    );
  } else {
     // استاتوس 400 را خودمان به صورت دستی برای درخواست ها ی نا موفق میدهیم  
    return const ResponseModel(
      statusCode: 400,
      title: 'Loading Data Faild',
      users: [],
    );
  }
 } catch (e) {

   return const ResponseModel(
    //استاتوس 500 هم که خودمان داده ایم یعنی اصلا نتوانسته ایم در خواستی بدهیم
      statusCode: 500,
      title: 'bad request',
      users: [],
    );
 }
}
}
