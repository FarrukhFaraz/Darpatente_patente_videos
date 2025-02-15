import 'dart:convert';

import 'package:dar_formazione/util/unique_id_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../util/colors.dart';
import '../../util/navigator.dart';
import '../../util/show_message.dart';
import '../../util/url.dart';
import '../home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool loader = false;
  bool isLogin = false;
  dynamic userId;
  dynamic userToken;

  bool _isObscure = true;

  loginApi(BuildContext context) async {
    setState(() {
      loader = true;
    });

    Map<String, dynamic> body = {
      'phone': phoneController.text.toString(),
      'password': passwordController.text.toString(),
      'imei_no': await UniqueIdService.getUniqueId(),
    };

    try {
      http.Response response = await http.post(
        Uri.parse(AppUrl.loginUrl),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(body),
      );

      print('_LoginScreenState.loginApi:::: ${response.body}');

      var jsonData = jsonDecode(response.body);
      if (jsonData['status'] == 'success') {
        var jsonData = jsonDecode(response.body.toString());

        userId = (jsonData['user']['id']);
        userToken = (jsonData['token']);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("userId", userId.toString());
        prefs.setString("userToken", userToken.toString());
        setState(() {
          loader = false;
        });
        if (context.mounted) showSnackMessage(context, 'Login successfully');
        if (context.mounted) navReplace(context, const HomePageScreen());
      } else if (jsonData['statusCode'] == '500') {
        setState(() {
          loader = false;
        });
        if (context.mounted) {
          showSnackErrorMessage(context, jsonData['message'], 3);
        }
      } else {
        setState(() {
          loader = false;
        });
        if (context.mounted) showSnackErrorMessage(context, jsonData['message'], 3);
      }
    } catch (e) {
      setState(() {
        loader = false;
      });
      if (kDebugMode) {
        print('_LoginPageScreenState.loginApi:::: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kcWhite,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/logo.png",
                    height: 190,
                    fit: BoxFit.cover,
                  ),
                  const Gap(24),
                  formWidget(),
                  const Gap(24),
                  GestureDetector(
                    onTap: () {
                      if (phoneController.text.isEmpty) {
                        showSnackMessage(context, 'Phone field is required');
                      } else if (passwordController.text.isEmpty) {
                        showSnackMessage(context, 'Password field is required');
                      } else {
                        loginApi(context);
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 66,
                      width: MediaQuery.of(context).size.width * 0.6,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: AppColor.kcPurple),
                      child: loader
                          ? Center(child: CircularProgressIndicator(color: AppColor.kcWhite))
                          : Text(
                              "Send",
                              style: TextStyle(color: AppColor.kcWhite, fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                    ),
                  ),
                  const Gap(24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formWidget() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(4),
            child: TextFormField(
              style: TextStyle(color: AppColor.kcBlack),
              keyboardType: TextInputType.emailAddress,
              autofocus: false,
              autocorrect: false,
              controller: phoneController,
              validator: MultiValidator([RequiredValidator(errorText: "Required *"), EmailValidator(errorText: "Not a valid  Email")]).call,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColor.kcBlue, width: 2.2),
                ),
                prefixIcon: Icon(Icons.mail, color: AppColor.kcBlack),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                hintText: "Enter your Email",
                hintStyle: TextStyle(color: AppColor.kcBlack),
              ),
            ),
          ),
          const Gap(16),
          Container(
            margin: const EdgeInsets.all(4),
            child: TextFormField(
              controller: passwordController,
              keyboardType: TextInputType.visiblePassword,
              validator: RequiredValidator(errorText: "Required *").call,
              style: TextStyle(color: AppColor.kcBlack),
              autofocus: false,
              autocorrect: false,
              obscureText: _isObscure,
              decoration: InputDecoration(
                focusedBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppColor.kcBlue, width: 2.2)),
                suffixIcon: IconButton(
                  icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility, color: AppColor.kcBlack),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                ),
                prefixIcon: Icon(Icons.lock_outline, color: AppColor.kcBlack),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                hintText: "Enter your password",
                hintStyle: TextStyle(color: AppColor.kcBlack),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
