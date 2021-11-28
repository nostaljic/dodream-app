import 'package:cached_network_image/cached_network_image.dart';
import 'package:dodream/repository/item.dart';
import 'package:dodream/ui/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:status_change/status_change.dart';
import 'package:dodream/controller/controller.dart';
import 'package:dodream/repository/repository.dart';

class PurchaseArtworkView extends GetView<RetrieveAndPurchaseController> {
  PurchaseArtworkView({Key? key}) : super(key: key);

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    Item selectedItem = controller.selectedItem!;
    int currentAmount = 1000000;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Scrollbar(
            controller: _scrollController,
            // isAlwaysShown: true,
            child: ListView(
              controller: _scrollController,
              children: [
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          /// blank space for progress bar
                          SizedBox(height: Get.height * 0.15),
          
                          /// image
                          CachedNetworkImage(
                              imageUrl: selectedItem.itemURL,
                              height: Get.width),
          
                          /// name
                          Text(
                            selectedItem.itemName,
                            style: const TextStyle(color: Color(0xFFAFAFAF)),
                          ),
          
                          /// left amount account
                          Text(
                            '현재 잔액 : ${NumberFormat('###,###,###,###').format(currentAmount)} (원/ETH)',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.0),
                          ),
          
                          /// ID
                          informationCard('아이디', selectedItem.id),
          
                          /// wallet address
                          informationCard('지갑 주소', selectedItem.ino),
          
                          /// price
                          informationCard('가격', selectedItem.price),
          
                          const SizedBox(height: 4.0),
                          Align(
                            alignment: Alignment.centerRight,
                            child: currentAmount < int.parse(selectedItem.price)
                                ? const Text(
                                    '구매 가능',
                                    style: TextStyle(color: Colors.green),
                                  )
                                : const Text(
                                    '잔액 부족',
                                    style: TextStyle(color: Colors.red),
                                  ),
                          ),
                          const SizedBox(height: 16.0),
          
                          /// buttons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () => Get.back(),
                                child: const Text('취소'),
                                style: TextButton.styleFrom(
                                  backgroundColor: const Color(0xFFEFEFEF),
                                  minimumSize: Size(Get.width * 0.3, 40),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () => Get.offNamed('/complete'),
                                child: const Text(
                                  '다음',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                style: TextButton.styleFrom(
                                  backgroundColor: const Color(0xffEFAF01),
                                  minimumSize: Size(Get.width * 0.6, 40),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
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
      ),
    );
  }

  Widget informationCard(String title, String detail) => Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        width: Get.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /// title
            Text(
              title,
              style: const TextStyle(color: Color(0xFFAEAEAE)),
            ),
            const SizedBox(height: 8.0),

            /// details
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              decoration: BoxDecoration(
                  color: const Color(0xFFEFEFEF),
                  borderRadius: BorderRadius.circular(8.0),
                  border:
                      Border.all(color: const Color(0xFFAEAEAE), width: 2.0)),
              child: Text(
                detail,
                style: const TextStyle(
                    color: Color(0xFF7A7A7A), fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      );
}
