import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dodream/controller/controller.dart';

class LoginStep extends StatelessWidget {
  const LoginStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      body: MethodSelection(),
    );
  }
}

class MethodSelection extends GetView<MainController> {
  const MethodSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: Get.width * 0.8,
        height: Get.height * 0.6,
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: Form(
            key: controller.formKey_dodream_login,
            child: Stack(children: [
              Column(
                children: [
                  SizedBox(
                      width: 123, child: Image.asset("images/main_logo.png")),
                  _userAccount(),
                  _userPassword(),
                  _userWalletAddress(),
                  _startButton(),
                ],
              ),

            ])),
      ),
    );
  }

  Widget _userAccount() {
    return Padding(
      padding: EdgeInsets.only(top: Get.height * 0.05, left: 20.0, right: 20.0),
      child: TextFormField(
          keyboardType: TextInputType.text,
          onChanged: (text) {
            print(text.length);
            if (text.length != 0) {
              controller.textFormIsSelected(true);
            } else {
              controller.textFormIsSelected(false);
            }
            print(controller.textFormIsSelected);
          },
          enabled: !controller.loginProcess,
          controller: controller.accountTextController,
          decoration: InputDecoration(
            labelText: "아이디",
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: Color(0xffced1d2),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: Color(0xffced1d2),
                width: 2.0,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: Color(0xffced1d2),
                width: 2.0,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: Color(0xffced1d2),
                width: 2.0,
              ),
            ),
          ),
          validator: (String? value) {
            if (value!.length ==0) {
              return "아이디를 입력해주세요.";
            }
          }),
    );
  }

  Widget _userPassword() {
    return Padding(
      padding: EdgeInsets.only(top: Get.height * 0.01, left: 20.0, right: 20.0),
      child: TextFormField(
          keyboardType: TextInputType.text,
          obscureText: true,
          onChanged: (text) {
            print(text.length);
            if (text.length != 0) {
              controller.textFormIsSelected(true);
            } else {
              controller.textFormIsSelected(false);
            }
            print(controller.textFormIsSelected);
          },
          enabled: !controller.loginProcess,
          controller: controller.passwordTextController,
          decoration: InputDecoration(
            labelText: "비밀번호",
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: Color(0xffced1d2),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: Color(0xffced1d2),
                width: 2.0,
              ),

            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: Color(0xffced1d2),
                width: 2.0,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: Color(0xffced1d2),
                width: 2.0,
              ),
            ),
          ),
          validator: (String? value) {
            if (value!.length == 0) {
              return "비밀번호를 확인하세요.";
            }

          }),
    );
  }
  Widget _userWalletAddress() {
    return Padding(
      padding: EdgeInsets.only(top: Get.height * 0.05, left: 20.0, right: 20.0),
      child: TextFormField(
          keyboardType: TextInputType.text,
          onChanged: (text) {
            print(text.length);
            if (text.length != 0) {
              controller.textFormIsSelected(true);
            } else {
              controller.textFormIsSelected(false);
            }
            print(controller.textFormIsSelected);
          },
          enabled: !controller.loginProcess,
          controller: controller.walletAddressTextController,
          decoration: InputDecoration(
            labelText: "지갑 주소",
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: Color(0xffced1d2),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: Color(0xffced1d2),
                width: 2.0,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: Color(0xffced1d2),
                width: 2.0,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: Color(0xffced1d2),
                width: 2.0,
              ),
            ),
          ),
          validator: (String? value) {
            if (value!.length ==0) {
              return "지갑 주소를 입력해주세요.";
            }
          }),
    );
  }
  Widget _startButton() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(10),
        color: Color(0xffEFAF01),
        child: MaterialButton(
          splashColor: Colors.white,
          minWidth: Get.width,
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          onPressed: () async {
              print(controller.formKey_dodream_login.currentState!.validate());
              if(controller.formKey_dodream_login.currentState!.validate()){

                var res = await controller.repository.signinWithUserInfo(controller.accountTextController.text, controller.passwordTextController.text);
                if(res['result']==true){
                  Get.offNamed("/select");
                }
                //


              }else{
                //Get.toNamed("/plan");
              }
        },
          child: Text(
            "로그인",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
