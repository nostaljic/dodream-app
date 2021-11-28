import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:dodream/repository/item.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dodream/repository/repository.dart';

var selectPlan = [
  {"plan": "사진/그림", "route": "/fileselect"},
  {"plan": "동영상", "route": "/fileselect"},
  {"plan": "음원", "route": "/fileselect"},
];

class PlanController extends GetxController {
  //for main pages
  var stepper = ["종류 선택", "파일 업로드", "인증 진행"];
  var currentStep = 0;
  var nowCheckedIndex = 0.obs;
  var planSelection = selectPlan;
  @override
  Future<void> onInit() async {
    super.onInit();
  }
}

class ResearchController extends GetxController {
  //
  final meal = true.obs;
  var researchIndex = 0.obs;
  var textFormIsSelected = false.obs;
  var userSymtomController = TextEditingController(text: "");
  var researchCheck0 = false.obs;
  var researchCheck1 = false.obs;
  var researchCheck2 = false.obs;
  var researchCheck3 = false.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
  }
}

class FileController extends GetxController {
  //
  final repository;
  var stepper = ["종류 선택", "파일 업로드", "인증 진행"];
  final meal = true.obs;
  var researchIndex = 0.obs;
  var userSymtomController = TextEditingController(text: "");
  var researchCheck0 = false.obs;
  var researchCheck1 = false.obs;
  var researchCheck2 = false.obs;
  var researchCheck3 = false.obs;
  FileController({required this.repository}) : assert(repository != null);
  //Cam
  FilePickerResult? pickedfile;
  var fileSelected = false.obs;
  File? fileForSend;
  var camInitialized = false.obs;
  var onSubmitting = false.obs;
  var isRecognized = false.obs;
  var userFaceInformation = "".obs;

  var start = 60.obs;
  Timer? timer;

  var diagTime = 3.obs;
  var diagSuccessTime = 3.obs;
}

class MainController extends GetxController {
  final MainRepository repository;

  MainController({required this.repository}) : assert(repository != null);

  var pageIndex = 0.obs;
  //for signin&up
  var accountTextController = TextEditingController(text: "");
  var passwordTextController = TextEditingController(text: "");
  var walletAddressTextController = TextEditingController(text: "");
  var passwordVisible = false.obs;
  final formKey_dodream_login = GlobalKey<FormState>();
  var loginProcess = false;
  var error = "";
  var textFormIsSelected = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    interval(textFormIsSelected, (callback) => print(textFormIsSelected.value),
        time: Duration(seconds: 1));
  }
}

class RetrieveAndPurchaseController extends GetxController {
  final RetrieveAndPurchaseRepository retrieveRepository;

  RetrieveAndPurchaseController({required this.retrieveRepository});

  //for main pages
  var stepper = ["상품 조회", "상품 구매", "구매 완료"];
  var currentStep = 0;
  var nowCheckedIndex = 0.obs;
  late List<Item> items;
  Item selectedItem =
      Item(id: '', ino: '', itemName: '', itemURL: '', price: '').obs as Item;

  @override
  Future<void> onInit() async {
    super.onInit();
    items = retrieveRepository.items;
  }

  // TODO select and purchase
  void setSelectedItem(Item newItem) => selectedItem = newItem;

  void purchaseSelectedItem() {
    log("you have selected ${selectedItem.itemName}");
  }
}
