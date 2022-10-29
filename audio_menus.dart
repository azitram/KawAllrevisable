import 'package:audioplayers/audioplayers.dart';
import 'package:draftfakecall/detailscreen_audio.dart';
import 'package:draftfakecall/resources.dart';
import 'package:flutter/material.dart';
//import 'package:draftfakecall/detailscreen_audio.dart';
//import 'package:draftfakecall/resources.dart';

class AudioMenus extends StatefulWidget {
  const AudioMenus({Key? key,}) : super(key: key);

  @override
  _MenusState createState() => _MenusState();
}

class _MenusState extends State<AudioMenus> {
  @override
  Widget build(BuildContext context) {
    final double screenheight=MediaQuery.of(context).size.height;
    final double screenwidth=MediaQuery.of(context).size.width;
    return Stack(
      children: <Widget>[
        Image.asset(
          "images/fcbg.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    height: screenheight*(3/4),
                    width: screenwidth,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      color: Color(0xffFFFFFF),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: screenheight*(1/32),
                        ),
                        Container(
                          height: screenheight*(2/32),
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Text(
                            "Pick the Actor!",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.0,
                              color: Colors.black,
                              shadows: [
                                Shadow(
                                  blurRadius: 15.0,
                                  color: Colors.black.withOpacity(0.3),
                                  offset: Offset(0.0, 8.0),
                                )],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenheight*(1/32),
                        ),
                        Container(
                          height: screenheight/2,
                          child: PageView.builder(
                            controller: PageController(viewportFraction: 0.8),
                            itemCount: fakeCallAudioResources.length,
                            itemBuilder: (context, index) {
                              final AudioResources myresources = fakeCallAudioResources[index];
                              return InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    return DetailScreenAudio(audioasset: fakeCallAudioResources[index].audiooke, imageasset: fakeCallAudioResources[index].background,);
                                  }));
                                },
                                  child: Padding(
                                  padding: EdgeInsets.only(
                                    left: 10,
                                    right: 10,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                          image: AssetImage(
                                             // myresources.imageList
                                            myresources.imageList,
                                          ),
                                          fit: BoxFit.cover,
                                        )
                                    ),
                                  )));
                            },
                          ),
                        ),
                      ],
                    )
                  /**/
                ),
              ]
          ),
        )
      ],
    );
  }
}