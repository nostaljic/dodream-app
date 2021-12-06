import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:status_change/status_change.dart';
import 'package:dodream/controller/controller.dart';
import 'package:dodream/repository/repository.dart';
import 'package:dodream/ui/utils.dart';

class Plan extends GetView<PlanController> {
  const Plan({Key? key}) : super(key: key);

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
                          Text("업로드 하고자 하는 파일을 선택해주세요."),
                          Text("선택 완료 버튼을 통해 다음 단계로 이동합니다."),
                        ],
                      ),

                      SizedBox(height: Get.height * 0.05),
                        Column(
                          children: [
                            Container(width: Get.width*.7, height: Get.height*.5,color: Colors.transparent,
                            child:Scrollbar(
                              child: _dateList(),
                            )
                            ),
                            _startButton()
                          ],
                        )

                    ],),
                  ),
                  Column(
                    children: [
                      SizedBox(height: Get.height * 0.05),
                      Align(
                          alignment: Alignment.center,
                          child: StepProgressView(
                              curStep: 1,
                              width: Get.width * 0.7,
                              color: Color(0xffEFAF01),
                              titles: controller.stepper)),
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
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(10),
        color:Color(0xffEFAF01),
        child: MaterialButton(
          splashColor: Colors.white,
          minWidth: Get.width,
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          onPressed: () async {

              print(controller.planSelection[2]);
              controller.currentStep=2;
              Get.offNamed(controller.planSelection[controller.nowCheckedIndex.value]["route"]!);



          },
          child: Text(
            "선택 완료",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
  Widget _dateList(){
    return ListView.builder(
      itemBuilder: (context, index) {
        var locCon = controller.planSelection[index];
        return GestureDetector(
          onTap: (){
            print(controller.nowCheckedIndex.value);
            controller.nowCheckedIndex(index);
          },
          child: Container(
            height: 72,

            child: Obx(()=>Card(
              color: index==controller.nowCheckedIndex.value?Color(0xffEBECFF):null,
              shape:RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                side:BorderSide(
                  color: Color(0xffEFAF01),
                  width: 2.0,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: Get.width*.4,
                      child: Text("${locCon["plan"]}",style:TextStyle(fontSize:18,color:Colors.black))),
                  SizedBox(
                      width: Get.width*.2,
                      child: SizedBox(width:24,height:24))
                ],
              ),
            ),)
          ),
        );
      },
      itemCount: controller.planSelection.length,
    );
  }
}


