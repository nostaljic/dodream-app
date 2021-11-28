import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class LOGINJSON {
  String? bncd;
  Header? header;
  String? dpnm;
  String? acno;


  LOGINJSON.fromJson(Map<String, dynamic> json) {
    bncd = json['Bncd'];
    header =
    (json['Header'] != null ? new Header.fromJson(json['Header']) : null)!;
    dpnm = json['Dpnm'];
    acno = json['Acno'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Bncd'] = this.bncd;
    if (this.header != null) {
      data['Header'] = this.header!.toJson();
    }
    data['Dpnm'] = this.dpnm;
    data['Acno'] = this.acno;
    return data;
  }
}

class Header {
  String? trtm;
  String? rsms;
  String? apiNm;
  String? isTuno;
  String? tsymd;
  String? fintechApsno;
  String? iscd;
  String? rpcd;
  String? apiSvcCd;


  Header.fromJson(Map<String, dynamic> json) {
    trtm = json['Trtm'];
    rsms = json['Rsms'];
    apiNm = json['ApiNm'];
    isTuno = json['IsTuno'];
    tsymd = json['Tsymd'];
    fintechApsno = json['FintechApsno'];
    iscd = json['Iscd'];
    rpcd = json['Rpcd'];
    apiSvcCd = json['ApiSvcCd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Trtm'] = this.trtm;
    data['Rsms'] = this.rsms;
    data['ApiNm'] = this.apiNm;
    data['IsTuno'] = this.isTuno;
    data['Tsymd'] = this.tsymd;
    data['FintechApsno'] = this.fintechApsno;
    data['Iscd'] = this.iscd;
    data['Rpcd'] = this.rpcd;
    data['ApiSvcCd'] = this.apiSvcCd;
    return data;
  }
}

final baseUrl="http://ec2-3-37-43-9.ap-northeast-2.compute.amazonaws.com:8080";
var accessToken ="";


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
      //print(jsonEncode(res.data));
      print(res);



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
