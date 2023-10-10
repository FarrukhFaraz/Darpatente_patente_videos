import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:toast/toast.dart';
import 'package:unique_identifier/unique_identifier.dart';

import '../Home_Screens/home_page.dart';
import '../Utils/colors.dart';
import '../Utils/url.dart';

var userId;
var userToken;

class LoginPageScreen extends StatefulWidget {
  const LoginPageScreen({Key? key}) : super(key: key);

  @override
  State<LoginPageScreen> createState() => _LoginPageScreenState();
}

class _LoginPageScreenState extends State<LoginPageScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController phoneControler = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool loader = false;
  bool isLogin = false;

  bool _isObscure = true;
  void login() {
    if (_formKey.currentState!.validate()) {
      //  checkConnectivity();
    } else {
      return;
    }
  }
  // checkConnectivity() async {
  //   if (await connection()) {
  //     loginApi();
  //     setState(() {
  //       checkConnection = false;
  //     });
  //   } else {
  //     setState(() {
  //       checkConnection = true;
  //     });
  //   }
  // }

  loginApi() async {
    setState(() {
      loader = true;
    });
    // print('token==$devicetoken');

    Map body = {
      'phone': phoneControler.text.toString(),
      'password': passwordController.text.toString(),
      'imei_no': await UniqueIdentifier.serial,
    };
    // print(phoneControler.text);
    // print(passwordController.text);

    http.Response response = await http.post(Uri.parse(loginurl), body: body);
    print("loginurll==" + loginurl.toString());
    print("bodyy" + body.toString());
    debugPrint("loginds;ld" + response.body);

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'success') {
      var jsonData = jsonDecode(response.body.toString());
      // debugPrint("message is  ${jsonData['message']}");

      userId = (jsonData['user']['id']);
      userToken = (jsonData['token']);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("userId", userId.toString());
      prefs.setString("userToken", userToken.toString());
      // debugPrint("userId  $userId");
      setState(() {
        loader = false;
      });
      print("userId  $userId");
      print("userToken  $userToken");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Login Succefully")));
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePageScreen()));
    } else if (response.statusCode == 500) {
      setState(() {
        loader = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            "You already login on another device. If you want to login on this device. Please contact admin"),
      ));
    } else {
      setState(() {
        loader = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Invalid Phone or Password"),
      ));

// }
// else {
      //   setState(() {
      //     loader = false;
      //   });
      //   print("error message    ${jsonData['message']}");
      //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //     content: Text("Invalid email/password"),
      //   ));
      //   // debugPrint(jsonData['message']);
      //   // Navigator.push(
      //   //     context, MaterialPageRoute(builder: ((context) => HomePageScreen())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.1,
            left: MediaQuery.of(context).size.height * 0.02,
            right: MediaQuery.of(context).size.height * 0.02,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  "assets/images/Last logo.jpeg",
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                formWidget(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                GestureDetector(
                  onTap: () {
                    if (phoneControler.text.isEmpty) {
                      Toast.show(
                        'Phone feild is required',
                        gravity: Toast.bottom,
                        duration: Toast.lengthLong,
                      );
                    } else if (passwordController.text.isEmpty) {
                      Toast.show(
                        'Password feild is required',
                        gravity: Toast.bottom,
                        duration: Toast.lengthLong,
                      );
                    } else {
                      loginApi();
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width * 0.6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: kBlack,
                    ),
                    child: loader
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Text(
                            "Send",
                            style: TextStyle(
                              color: kWhite,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                )
              ],
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
              // keyboardType: TextInputType.number,
              style: TextStyle(color: kBlack),
              autofocus: false,
              autocorrect: false,
              controller: phoneControler,
              validator: MultiValidator([
                RequiredValidator(errorText: "Required *"),
                EmailValidator(errorText: "Not a valid  Email")
              ]),
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: yellow800, width: 2.2)),
                  prefixIcon: Icon(
                    Icons.mail,
                    color: kBlack,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  hintText: "Enter your Email",
                  hintStyle: TextStyle(color: kBlack)),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Container(
            margin: const EdgeInsets.all(4),
            child: TextFormField(
              controller: passwordController,
              validator: RequiredValidator(errorText: "Required *"),
              style: TextStyle(color: kBlack),
              autofocus: false,
              autocorrect: false,
              obscureText: _isObscure,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: yellow800, width: 2.2)),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscure ? Icons.visibility_off : Icons.visibility,
                      color: kBlack,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  ),
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: kBlack,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  hintText: "Enter your password",
                  hintStyle: TextStyle(color: kBlack)),
            ),
          ),
        ],
      ),
    );
  }
}
