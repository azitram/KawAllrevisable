import 'package:audioplayers/audioplayers.dart';
import 'package:draftfakecall/audio_file.dart';
import 'package:draftfakecall/resources.dart';
import 'package:flutter/material.dart';
import 'package:draftfakecall/audio_menus.dart';

class DetailScreenAudio extends StatefulWidget{
  final String audioasset;
  final String imageasset;
  const DetailScreenAudio({Key? key, required this.audioasset, required this.imageasset,}) : super(key: key);

  @override
  _DetailScreenAudioState createState() => _DetailScreenAudioState();
}

class _DetailScreenAudioState extends State<DetailScreenAudio>{
  String imageasset = "";
  String audioasset = "";
  AudioPlayer player = AudioPlayer();


  @override
  void initState(){
    super.initState();
    imageasset = widget.imageasset;
    player = AudioPlayer();
  }


  @override
  Widget build(BuildContext context) {
    final double screenHeight=MediaQuery.of(context).size.height;
    final double screenWidth=MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
          children: [
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: screenHeight*(18/25),
                  width: screenWidth,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        imageasset,
                      ),
                      fit: BoxFit.fill,
                    ),
                    color: Colors.transparent,
                  ),
                )),
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: AppBar(
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios,),
                    /*{
                      advancedPlayer.pause();
                      Navigator.of(context).pop();
                    },*/
                      onPressed: () {
                        Navigator.of(context).pop();
                        player.stop();
                         },
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                )
            ),
            Positioned(
              top: screenHeight*(18/25),
              child: Container(
                color: Color(0xffFEFEFE),
                  height: screenHeight*(7/25),
                  width: screenWidth,
                  child: Column(
                    children: [
                      AudioFile(audioasset: widget.audioasset,)
                    ],
                  )
              ),)
          ]
      ),
    );
  }
}