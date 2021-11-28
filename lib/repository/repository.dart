import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'item.dart';


final baseUrl="http://ec2-3-37-43-9.ap-northeast-2.compute.amazonaws.com:8080";
var accessToken ="";
var username="";
var userid="";
var walletAddress ="";
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



  Future<dynamic> signinWithUserInfo(String userAccount,String userPassword,String wallet) async {
    try{
      walletAddress = wallet;
      userid = userAccount;
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
    // List<int> imageBytes = File(fileForSend.path).readAsBytesSync();
    // base64Encode(imageBytes);
    // print(base64Encode(imageBytes));

    var formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(fileForSend.path,
          filename: "${fileForSend.name}"),
      "wallet":walletAddress,
      "name": fileForSend.name,
      "id": userid,
    });
   var response = await Dio().post(baseUrl + "/api/v1/dodream/upload", data: formData);
  print(response);
    return response;
  }
}

class RetrieveAndPurchaseRepository {
  /// for data save
  late List<Item> items;

  /// constructor
  RetrieveAndPurchaseRepository() {
    items = retrieveItems();
  }

  void printHelloWorld() => log("Hello World !");

  List<Item> retrieveItems() {
    List<Item> retrievedItems = [];
    for (int i = 0; i < 10; ++i) {
      retrievedItems.add(Item(
          id: 'jdklmdf1podmw1kem1k23e',
          ino: '1i2hjwi91me90m120sd9m',
          itemName: '샘플 예시 그림',
          itemURL:
              'https://images.unsplash.com/photo-1598128558393-70ff21433be0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1989&q=80',
          price: '12345667890'));
    }
    return retrievedItems;
  }

  // TODO purchase item
  void purchaseItem(Item itemToPurchase) =>
      log("you are willing to buy ${itemToPurchase.itemName}");
}
