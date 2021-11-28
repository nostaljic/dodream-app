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
  const PurchaseArtworkView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Item selectedItem = controller.selectedItem;
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
                        /// image
                        CachedNetworkImage(imageUrl: selectedItem.itemURL),

                        /// name
                        Text(
                          selectedItem.itemName,
                          style: const TextStyle(color: Color(0xFFAFAFAF)),
                        ),

                        /// left amount account
                        Text(
                          '현재 잔액 : ${NumberFormat('###,###,###,###').format(100000)} (원/ETH)',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),

                        /// ID
                        informationCard('아이디', 'japyon'),

                        /// wallet address
                        informationCard('아이디', 'japyon'),

                        /// price
                        informationCard('아이디', 'japyon'),

                        /// buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () => Get.back(),
                              child: const Text('취소'),
                              style: TextButton.styleFrom(
                                backgroundColor: const Color(0xFFEFEFEF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () => Get.offNamed('/complete'),
                              child: const Text('다음'),
                              style: TextButton.styleFrom(
                                backgroundColor: const Color(0xffEFAF01),
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

  Widget informationCard(String title, String detail) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 24.0),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            /// title
            Text(
              title,
              style: const TextStyle(color: Color(0xFFAEAEAE)),
            ),

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
