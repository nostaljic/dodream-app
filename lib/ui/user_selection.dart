import 'package:flutter/material.dart';
import 'package:get/get.dart';

///  the page for selecting the user's action
///  whether the user will choose to upload new image and receive new token
///  or to sell or buy a nft-image
///
///  @author seunghwanly
class UserSelection extends StatelessWidget {
  const UserSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                            Text("어떤 작업을 해볼까요? 🧐"),
                            Text("선택 완료 버튼을 통해 다음 단계로 이동합니다."),
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
                                  child: _dateList(),
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dateList() {
    return ListView.separated(
        itemBuilder: (context, index) => ListTile(

            /// Navigation actions
            onTap: () {
              if (index == 0) {
                Get.offNamed("/plan");
              } else {
                Get.toNamed("/purchase");
              }
            },

            /// component design
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: const BorderSide(
                color: Color(0xffEFAF01),
                width: 2.0,
              ),
            ),
            title: index == 0
                ? const Text('NFT 저작물 발행')
                : const Text('NFT 저작물 구매')),
        separatorBuilder: (_, index) => const SizedBox(
              height: 10,
            ),
        itemCount: 2);
  }
}
