import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Models/video_model.dart';
import '../../Utils/colors.dart';
import '../../Utils/url.dart';
import '../home_page.dart';
import 'videoplay.dart';

class VideoChapterScreen extends StatefulWidget {
  final String videoid;

  const VideoChapterScreen({super.key, required this.videoid});

  @override
  State<VideoChapterScreen> createState() => _VideoChapterScreenState();
}

class _VideoChapterScreenState extends State<VideoChapterScreen> {
  bool loader = false;
  var userToken;
  var categotyname;
  List<VideoModel> _video = [];

  getShare() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userToken = sharedPreferences.getString('userToken');
    getCategoryApi();
  }

  getCategoryApi() async {
    setState(() {
      loader = true;
    });

    http.Response response = await http.get(
        Uri.parse(vidoeurl + widget.videoid),
        headers: {"Authorization": "Bearer $userToken"});

    print(userToken);

    print(response.body.toString());
    Map jsonData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        loader = false;
      });
      print("ist json data ....." + response.body.toString());
      for (int i = 0; i < jsonData['data'].length; i++) {
        Map<String, dynamic> object = jsonData['data'][i];
        VideoModel test = VideoModel();
        test = VideoModel.fromJson(object);
        _video.add(test);
      }
    } else {
      print("Error");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Something went wrong")));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getShare();
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
                              Text(
                                "Videos",
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
                      color: yellow800,
                      //color of divider
                      height: 5,
                      //height spacing of divider
                      thickness: 2,
                      //thickness of divier line
                      indent: 25,
                      //spacing at the start of divider
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
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: _video.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => VidePlayScreen(
                          name: _video[index].name.toString(),
                          video: _video[index].videoWithLink.toString(),
                          thumnail: _video[index].cat!.image.toString(),
                          videoid: _video[index].id.toString(),
                        ))));
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _video[index].name.toString(),
                style: TextStyle(
                    fontSize: 18,
                    color: yellow800,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
        );
      },
    );
  }
}
