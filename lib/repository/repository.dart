import 'dart:developer' as d;
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:dodream/repository/test_data.dart';
import 'package:intl/intl.dart';

import 'item.dart';

const baseURL =
    "http://ec2-3-37-43-9.ap-northeast-2.compute.amazonaws.com:8080";

Map<String, dynamic> generateBodyForAccountBalance(
        {required String accessToken, required String finAcno}) =>
    {
      "Header": {
        "ApiNm": "InquireBalance",
        "Tsymd": DateFormat("yyyyMMdd").format(DateTime.now()),
        "Trtm": (Random().nextInt(900000) + 100000).toString(),
        "Iscd": "000013",
        "FintechApsno": "001",
        "ApiSvCd": "ReceivedTransferA",
        "IsTuno": (Random().nextInt(900000) + 100000).toString(),
        "AccessToken": accessToken
      },
      "FinAcno": finAcno
    };

var accessToken = "4aa57ae1491a8364441a2f5322f91ccd4f8d618af1ddc76a7d088b65d4ad6635";
var username = "";
var userid = "";
var walletAddress = "";

class LoginModel {
  LoginModel({
    required this.name,
    required this.accesstoken,
    required this.result,
  });
  late final String name;
  late final String accesstoken;
  late final bool result;

  LoginModel.fromJson(Map<String, dynamic> json) {
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

  Future<dynamic> signinWithUserInfo(
      String userAccount, String userPassword, String wallet) async {
    try {
      walletAddress = wallet;
      userid = userAccount;
      var res = await Dio().post(baseURL + "/api/v1/account/login",
          data: {
            'id': '${userAccount}',
            'pwd': '${userPassword}',
          },
          options: Options(headers: {'Access-Control-Allow-Origin': 'true'}));
      //print(res.headers);
      //print(res.data);
      Map<String, dynamic> loginmodel = res.data;
      LoginModel result = LoginModel.fromJson(res.data!);
      accessToken = loginmodel["accesstoken"];
      username = loginmodel["name"];
      return loginmodel;
    } catch (e) {
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
      "wallet": walletAddress,
      "name": fileForSend.name,
      "id": userid,
    });
    var response =
        await Dio().post(baseURL + "/api/v1/dodream/upload", data: formData);
    print(response);
    return response;
  }
}

class RetrieveAndPurchaseRepository {
  /// for data save
  late List<Item> items;
  late String userWalletAddress = walletAddress;
  late String userID = userid;

  /// constructor
  RetrieveAndPurchaseRepository() {
    items = retrieveItems();
  }

  void printHelloWorld() => d.log("Hello World !");

  Future<List<String>> getUserAccountBalance() async {
    try {
      var dio = Dio();
      dio.options.headers = {
        "accessToken": accessToken,
        "Accept": "application/json",
        "Access-Control-Allow-Origin": "*"
      };
      final response = await dio.get(baseURL + "/api/v1/account/detail");

      if (response.statusCode == 200) {
        d.log("body: ${response.data.toString()}");
        // bool result = response.data['result'] as bool;
        String currentBalance = response.data['Ldbl'];
        String usableBalance = response.data['RlpmAbamt'];

        return [currentBalance, usableBalance];
      }

      throw NullThrownError;
    } catch (e) {
      d.log("[getUserAccountBalance Error] : ${e.toString()}");
      rethrow;
    }
  }

  List<Item> retrieveItems() {
    List<Item> retrievedItems = [];
    retrievedItems.addAll(testData);
    return retrievedItems;
  }

  Future<bool> purchaseItem({
    required Item itemToPurchase,
    required String acno,
  }) async {
    try {
      var res = await Dio().post(
        baseURL + "/api/v1/account/transferDeposit",
        data: {"acno": acno, "tram": int.parse(itemToPurchase.price)},
        options: Options(
          headers: {
            "accessToken": accessToken,
            "Accept": "application/json",
            "Access-Control-Allow-Origin": "*"
          },
        ),
      );
      if (res.statusCode == 200) {
        return true;
      }
      throw NullThrownError;
    } catch (e) {
      d.log("[purchaseItem Error] : ${e.toString()}");
      rethrow;
    }
  }
}
