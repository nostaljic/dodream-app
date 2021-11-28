import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


final baseUrl="http://1.124.252.101:8081";

class MainRepository {

  MainRepository();

  Future<dynamic> signinWithUserInfo(String userAccount,String userPassword) async {
    try{
      var response = await Dio().post(baseUrl+"/signin",
          data: {'userAccount':'${userAccount}',
            'userPassword':'${userPassword}',});
      print(response);
      return response;
    }catch(e){
      print(e);
    }
  }
}

class FileRepository {

  FileRepository();

  Future<dynamic> sendVideo(fileForSend) async {
    var formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(fileForSend.path,filename:"${fileForSend.path}"),
      "username": "",
      "userid": "",
    });
    var response = await Dio().post(baseUrl+"/file",
        data: formData);
    print(response);
    return response;
  }
}