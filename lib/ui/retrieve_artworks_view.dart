import 'package:cached_network_image/cached_network_image.dart';
import 'package:dodream/ui/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:status_change/status_change.dart';
import 'package:dodream/controller/controller.dart';
import 'package:dodream/repository/repository.dart';

class RetrieveArtWorksView extends GetView<RetrieveAndPurchaseController> {
  const RetrieveArtWorksView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SizedBox(
          child: Column(
            children: [
              Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        SizedBox(height: Get.height * 0.15),
                        Column(
                          children: const [
                            Text("상품을 둘러보세요",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 24)),
                            Text("\n누르면 송금 페이지로 이동합니다."),
                          ],
                        ),
                        SizedBox(height: Get.height * 0.05),
                        Column(
                          children: [
                            Container(
                                width: Get.width * .7,
                                height: Get.height * .5,
                                color: Colors.transparent,
                                child: Scrollbar(
                                  child: _artWorkList(),
                                )),
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
                              curStep: 1,
                              width: Get.width * 0.7,
                              color: const Color(0xffEFAF01),
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
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xffEFAF01),
        child: MaterialButton(
          splashColor: Colors.white,
          minWidth: Get.width,
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          onPressed: () async {
            controller.currentStep = 2;
            Get.toNamed('/purchase');
          },
          child: const Text(
            "선택 완료",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _artWorkList() {
    var items = controller.items;
    controller.setSelectedItem(items[0]); // for init
    return ListView.separated(
        itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                controller.nowCheckedIndex(index);
                controller.setSelectedItem(items[index]);
              },
              child: SizedBox(
                  height: 72,
                  child: Obx(
                    () => Card(
                      color: index == controller.nowCheckedIndex.value
                          ? const Color(0xffEBECFF)
                          : null,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: const BorderSide(
                          color: Color(0xffEFAF01),
                          width: 2.0,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: Get.width * 0.2,
                            child: CachedNetworkImage(
                              imageUrl: items[index].itemURL,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  items[index].itemName,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                const SizedBox(height: 10),
                                Text(items[index].price)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
            ),
        separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
        itemCount: items.length);
  }
}
