import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../Models/info_chapter_model.dart';
import '../../Utils/colors.dart';
import '../../Utils/url.dart';
import '../home_page.dart';

class InfoChapterScreen extends StatefulWidget {
  final String id;
  const InfoChapterScreen({
    super.key,
    required this.id,
  });

  @override
  State<InfoChapterScreen> createState() => _InfoChapterScreenState();
}

class _InfoChapterScreenState extends State<InfoChapterScreen> {
  var userToken;
  bool loader = false;
  List<ChapterInfoModel> _getinfoChapter = [];
  getdemoChapterApi() async {
    setState(() {
      loader = true;
    });

    http.Response response = await http.get(
        Uri.parse(
          getInfoChapterUrl + widget.id,
        ),
        headers: {"Authorization": "Bearer $userToken"});

    print(userToken);
    print("its idd...==" + widget.id.toString());

    Map jsonData = jsonDecode(response.body);
    print("response...==" + response.toString());
    print("response...==" + getInfoChapterUrl.toString());

    if (response.statusCode == 200) {
      print("its josn dtat after 200" + jsonData.toString());
      setState(() {
        loader = false;
      });
      for (int i = 0; i < jsonData['data'].length; i++) {
        Map<String, dynamic> object = jsonData['data'][i];
        ChapterInfoModel test = ChapterInfoModel();
        test = ChapterInfoModel.fromJson(object);
        _getinfoChapter.add(test);
      }
    } else {
      print("error");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdemoChapterApi();
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
        child: SingleChildScrollView(
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
                            height: MediaQuery.of(context).size.height * 0.1,
                            width: MediaQuery.of(context).size.width * 0.1,
                          ),
                        ),
                        Text(
                          "Info",
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
              demolesson(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
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
                        
              Divider(
                color: yellow800, //color of divider
                height: 5, //height spacing of divider
                thickness: 2, //thickness of divier line
                indent: 25, //spacing at the start of divider
                endIndent: 25, //spacing at the end of divider
              ),
              //      SizedBox(        height: MediaQuery.of(context).size.height*0.01,
              // ),
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
        ),
      ),
    ));
  }

  Widget demolesson() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: _getinfoChapter.length,
      itemBuilder: (context, index) {
        return Container(
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
            _getinfoChapter[index].name.toString(),
            style: TextStyle(
                fontSize: 24, color: yellow800, fontWeight: FontWeight.w400),
          ),
        );
      },
    );
  }
}
