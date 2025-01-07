import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import '../../Utils/colors.dart';
import '../../Utils/url.dart';
import '../home_page.dart';
import 'chewi.dart';

class VidePlayScreen extends StatefulWidget {
  final String name;
  final String video;
  final String thumnail;
  final String videoid;

  const VidePlayScreen({
    super.key,
    required this.name,
    required this.video,
    required this.thumnail,
    required this.videoid,
  });

  @override
  State<VidePlayScreen> createState() => _VidePlayScreenState();
}

class _VidePlayScreenState extends State<VidePlayScreen> {
  bool loader = false;
  var userToken;

  uservideohistoryApi() async {
    setState(() {
      loader = true;
    });
    // print('token==$devicetoken');

    Map body = {
      'video_id': widget.videoid.toString(),
    };

    http.Response response = await http.post(Uri.parse(userVideoHistoryUrl), body: body, headers: {
      "Authorization": "Bearer $userToken",
      "Accept": "application/json",
    });

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'success') {
      var jsonData = jsonDecode(response.body.toString());

      print("itss json data" + jsonData.toString());
      debugPrint("message is  ${jsonData['message']}");
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: ((context) => ChewiScreen(
                    video: widget.video.toString(),
                    title: widget.name.toString(),
                  ))));
      //Toast.show(jsonData['message']);
      setState(() {
        loader = false;
      });
    } else if (response.statusCode == 500) {
      setState(() {
        loader = false;
      });
      Toast.show(
        jsonData['message'],
        gravity: Toast.bottom,
        duration: Toast.lengthLong,
      );
    } else {
      setState(() {
        loader = false;
      });
      Toast.show(
        jsonData['message'],
        gravity: Toast.bottom,
        duration: Toast.lengthLong,
      );
    }
  }

  getShare() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userToken = sharedPreferences.getString('userToken');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getShare();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.video);

    ToastContext().init(context);

    return SafeArea(
        child: Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(width: 2.2, color: yellow800)),
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
                    decoration: BoxDecoration(color: yellow800, borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          widget.name.toString(),
                          style: TextStyle(fontSize: 18, color: kWhite, fontWeight: FontWeight.w500),
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
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              GestureDetector(
                  onTap: () {
                    // uservideohistoryApi();
                    Navigator.push(context, MaterialPageRoute(builder: ((context) => HomePageScreen())));
                  },
                  child: Icon(
                    Icons.home,
                    size: 40,
                  )),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
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
    print("this is new link of images::::::  ${imageBaseurl}${widget.thumnail}");
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(
              // left: MediaQuery.of(context).size.width * 0.02,
              // right: MediaQuery.of(context).size.width * 0.01,
              //   top: MediaQuery.of(context).size.height * 0.02,
              ),
          // height: MediaQuery.of(context).size.height * 1,
          // width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            // color: kLightRed,
          ),
          //  decoration: BoxDecoration(color: klightblue),
          child: Image.network(
            '${imageBaseurl}${widget.thumnail}',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.6,
            // style: TextStyle(
            //     fontSize: 24, color: yellow800, fontWeight: FontWeight.w400),
          ),
        ),
        Positioned(
            top: MediaQuery.of(context).size.height * 0.24,
            left: MediaQuery.of(context).size.height * 0.04,
            right: MediaQuery.of(context).size.height * 0.04,
            child: GestureDetector(
              onTap: () {
                uservideohistoryApi();
              },
              child: Icon(
                Icons.play_arrow,
                size: 80,
                color: yellow800,
              ),
            ))
      ],
    );
  }
}
