import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Models/demo_cat_model.dart';
import '../../Utils/colors.dart';
import '../../Utils/url.dart';
import '../home_page.dart';
import 'demo_chapter.dart';

class DemoScreen extends StatefulWidget {
  const DemoScreen({super.key});

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  var catName;
  var userToken;
  bool loader = false;
  List<GetDemoModel> _getDemoCategory = [];

  demoCatApi() async {
    setState(() {
      loader = true;
    });
    http.Response response = await http.get(Uri.parse(demourl),
        headers: {"Authorization": "Bearer $userToken"});

    print(userToken);

    Map jsonData = jsonDecode(response.body);
    print("response...==" + response.toString());
    print("response...==" + demourl.toString());

    if (response.statusCode == 200) {

      setState(() {
        loader = false;
      });
      for (int i = 0; i < jsonData['data'].length; i++) {
        Map<String, dynamic> object = jsonData['data'][i];
        GetDemoModel test = GetDemoModel();
        test = GetDemoModel.fromJson(object);
        _getDemoCategory.add(test);
      }
    } else {
      print("error");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    demoCatApi();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(width: 2.2, color: yellow800)),
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.04,
          left: MediaQuery.of(context).size.width * 0.06,
          right: MediaQuery.of(context).size.width * 0.06,
          bottom: MediaQuery.of(context).size.height * 0.02,
        ),
        child: loader
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.04,
                        // left: MediaQuery.of(context).size.width *0.06,
                        // right: MediaQuery.of(context).size.width *0.06,
                        // bottom: MediaQuery.of(context).size.height *0.02,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.10,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                              color: yellow800,
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                child: Image(
                                  image: const AssetImage(
                                      "assets/images/Last logo.jpeg"),
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  width:
                                      MediaQuery.of(context).size.width * 0.1,
                                ),
                              ),
                              Text(
                                "Demo",
                                style: TextStyle(
                                    fontSize: 30,
                                    color: kWhite,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    demoLesson(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Column(
                      // mainAxisAlignment: MainAxisAlignment.end,
                      // crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => HomePageScreen())));
                          },
                          child: Icon(
                            Icons.home,
                            size: 40,
                          ),
                        ),
                        
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Divider(
                          color: yellow800, //color of divider
                          height: 5, //height spacing of divider
                          thickness: 2, //thickness of divier line
                          indent: 25, //spacing at the start of divider
                          endIndent: 25, //spacing at the end of divider
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Center(
                            child: Text(
                              "Dar formazione per patente e lingue italiana\n patente AM, B,C,D , Corse CQC,\n info. 3779870452",
                              style: TextStyle(
                                fontSize: 14,
                                color: kBlack,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    ));
  }

  Widget demoLesson() {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: _getDemoCategory.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DemoChapterScreen(
                            id: _getDemoCategory[index].id.toString(),
                          )));
            },
            child: Container(
              margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.02,
                right: MediaQuery.of(context).size.width * 0.02,
                top: MediaQuery.of(context).size.height * 0.02,
              ),
              height: MediaQuery.of(context).size.height * 0.08,
              width: MediaQuery.of(context).size.width * 0.70,
              alignment: Alignment.center,

              decoration: BoxDecoration(
                  color: background, borderRadius: BorderRadius.circular(14)),
              //  decoration: BoxDecoration(color: klightblue),
              child: Text(
                _getDemoCategory[index].name.toString(),
                style: TextStyle(
                    fontSize: 24,
                    color: yellow800,
                    fontWeight: FontWeight.w400),
              ),
            ),
          );
        });
  }
}
