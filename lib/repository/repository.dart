import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


final baseUrl="http://ec2-3-37-43-9.ap-northeast-2.compute.amazonaws.com:8080";
var accessToken ="";
var username="";
class LoginModel {
  LoginModel({
    required this.name,
    required this.accesstoken,
    required this.result,
  });
  late final String name;
  late final String accesstoken;
  late final bool result;

  LoginModel.fromJson(Map<String, dynamic> json){
    name = json['name'] as String;
    accesstoken = json['accesstoken'] as String;
    result = json['result'] as bool;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['accesstoken'] = accessToken;
    _data['result'] = result;
    return _data;
  }
}

class MainRepository {
  MainRepository();


  Future<dynamic> signinWithUserInfo(String userAccount,String userPassword) async {
    try{
      var res = await Dio().post(baseUrl+"/api/v1/account/login",
          data: {'id':'${userAccount}',
            'pwd':'${userPassword}',},
        options: Options(
            headers : {'Access-Control-Allow-Origin':'true'}
        ));
      //print(res.headers);
      //print(res.data);
      Map<String,dynamic> loginmodel = res.data;
      LoginModel result = LoginModel.fromJson(res.data!);
      accessToken = loginmodel["accesstoken"];
      username= loginmodel["name"];
      return loginmodel;

    }catch(e){

      print(e);
    }
  }
}

class FileRepository {
  FileRepository();

  Future<dynamic> sendFile(fileForSend) async {
    var formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(fileForSend.path,
          filename: "${fileForSend.path}"),
      "username": "",
      "userid": "",
    });
    var response = await Dio().post(baseUrl + "/file", data: formData);
    print(response);
    return response;
  }
}

class PurchaseRepository {
  PurchaseRepository(); // constructor

  void printHelloWorld() => log("Hello World !");
}
