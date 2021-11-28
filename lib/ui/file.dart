import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:status_change/status_change.dart';
import 'package:dodream/controller/controller.dart';
import 'package:dodream/ui/utils.dart';

class FileSelect extends GetView<FileController> {
  const FileSelect({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset : false,
        body: SizedBox(
          child: Column(
            children: [
              Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Column(children: [
                      SizedBox(height: Get.height * 0.15),
                      Column(
                        children: [
                          Text("파일을 선택해주세요.",style:TextStyle(fontSize:20,fontWeight:FontWeight.bold)),
                          SizedBox(height:Get.height*0.02,),
                          SizedBox(
                              width:136,height:136,
                              child: Image.asset("images/token.png"))
                        ],
                      ),

                      SizedBox(height: Get.height * 0.05),
                      Column(
                        children: [
                          Container(width: Get.width*.8, height: Get.height*.4,color: Colors.transparent,
                              child:Align(
                                alignment:Alignment.topLeft,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text("안내사항.",style:TextStyle(fontSize:20,fontWeight:FontWeight.bold)),
                                      ],
                                    ),
                                    SizedBox(height:Get.height*.02),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                          Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: SizedBox(
                                                width:24,height:24,
                                                child: Icon(Icons.check)),
                                          ),

                                        SizedBox(
                                            width:Get.width*.7,
                                            child: Text("반드시 본인의 저작물을 올려주세요.",style:TextStyle(fontSize:18))),
                                      ],
                                    ),Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: SizedBox(
                                              width:24,height:24,
                                              child: Icon(Icons.check)),
                                        ),
                                        SizedBox(
                                            width:Get.width*.7,
                                            child: Text("업로드된 파일은 심사 후 토큰으로 발행됩니다.",style:TextStyle(fontSize:18))),
                                      ],
                                    ),Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: SizedBox(
                                              width:24,height:24,
                                              child: Icon(Icons.check)),
                                        ),
                                        SizedBox(
                                            width:Get.width*.7,
                                            child: Text("용량은 50MB 이하로 제한됩니다.",style:TextStyle(fontSize:18))),
                                      ],
                                    ),
                              Obx(() {
                                      if(controller.fileSelected.value) {return Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: SizedBox(
                                                  width: 24,
                                                  height: 24,
                                                  child: Icon(Icons.check)),
                                            ),
                                            SizedBox(
                                                width: Get.width * .7,
                                                child: Text(
                                                    "선택된 파일 : ${controller.pickedfile!.files
                                                    .single.name}",
                                                    style: TextStyle(
                                                        fontSize: 18))),
                                          ],
                                        );}else return Container();
                                      })
                                  ],
                                ),
                              )
                          ),

                          _startButton()
                        ],
                      )
                    ],
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(height: Get.height * 0.05),
                      Align(
                          alignment: Alignment.center,
                          child: StepProgressView(
                              curStep: 2,
                              width: Get.width * 0.7,
                              color: Color(0xffEFAF01),
                              titles: controller.stepper)
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _startButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: Get.width*.3,
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            color: Color(0xffF7F7F7),
            child: MaterialButton(
              splashColor: Colors.white,
              minWidth: Get.width,
              padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              onPressed: () async {

                print(controller.pickedfile);
                controller.pickedfile = await FilePicker.platform.pickFiles();
                if(controller.pickedfile!=null)controller.fileSelected.value=true;
                print(controller.pickedfile);
                File file = File(controller.pickedfile!.files.single.path!);
                print(file);
              },
              child: Text(
                "파일선택",
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xff868686), fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
    Obx(()=>SizedBox(
          width:Get.width*.5,
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            color:  controller.fileSelected.value?Color(0xffEFAF01):Colors.grey,
            child: MaterialButton(
              splashColor: Colors.white,
              minWidth: Get.width,
              padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              onPressed: () {
                if(controller.fileSelected.value)Get.toNamed("/complete");
              },
              child: Text(
                "업로드",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        )),
      ],
    );
  }
}


