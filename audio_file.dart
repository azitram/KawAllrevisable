import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';
import 'package:draftfakecall/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:draftfakecall/detailscreen_audio.dart';

class AudioFile extends StatefulWidget {
  final String audioasset;
  const AudioFile({Key? key, required this.audioasset}) : super(key: key);

  @override
  State<AudioFile> createState() => _AudioFileState();
}

class _AudioFileState extends State<AudioFile> {

  int maxduration = 100;
  String currentpostlabel = "00:00";
  String audioasset = "";
  bool isplaying = false;
  bool audioplayed = false;
  int currentpos = 0;
  late Uint8List audiobytes;

  AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      audioasset = widget.audioasset;
      ByteData bytes = await rootBundle.load(audioasset); //load audio from assets
      audiobytes = bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
      //convert ByteData to Uint8List

      player.onDurationChanged.listen((Duration d) { //get the duration of audio
        maxduration = d.inMilliseconds;
        setState(() {

        });
      });

      player.onAudioPositionChanged.listen((Duration  p){
        currentpos = p.inMilliseconds; //get the current position of playing audio

        //generating the duration label
        int shours = Duration(milliseconds:currentpos).inHours;
        int sminutes = Duration(milliseconds:currentpos).inMinutes;
        int sseconds = Duration(milliseconds:currentpos).inSeconds;

        int rhours = shours;
        int rminutes = sminutes - (shours * 60);
        int rseconds = sseconds - (sminutes * 60 + shours * 60 * 60);

        currentpostlabel = "$rhours:$rminutes:$rseconds";

        setState(() {
          //refresh the UI
        });
      });

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenDivision=MediaQuery.of(context).size.height*(2/5);
    return Column(
      children: [
        Container(
            height: screenDivision/5,
            child: Wrap(
              spacing: 10,
              children: [
                IconButton(
                  onPressed: () async {
                    if(!isplaying && !audioplayed){
                      int result = await player.playBytes(audiobytes);
                      if(result == 1){ //play success
                        setState(() {
                          isplaying = true;
                          audioplayed = true;
                        });
                      }else{
                        print("Error while playing audio.");
                      }
                    }else if(audioplayed && !isplaying){
                      int result = await player.resume();
                      if(result == 1){ //resume success
                        setState(() {
                          isplaying = true;
                          audioplayed = true;
                        });
                      }else{
                        print("Error on resume audio.");
                      }
                    }else{
                      int result = await player.pause();
                      if(result == 1){ //pause success
                        setState(() {
                          isplaying = false;
                        });
                      }else{
                        print("Error on pause audio.");
                      }
                    }
                    },
                  icon: Icon(isplaying?Icons.pause_circle_filled:Icons.play_circle_fill),
                  iconSize: (screenDivision/5)*(5/6),
                  color: Color(0xff7D7A7A),
                ),
              ],
            ),
          ),
               Container(
                height: screenDivision/5,
                    child: Slider(
                      activeColor: Color(0xff646060),
                      inactiveColor: Color(0xffD9D9D9),
                      value: double.parse(currentpos.toString()),
                      min: 0,
                      max: double.parse(maxduration.toString()),
                      divisions: maxduration,
                      label: currentpostlabel,
                      onChanged: (double value) async {
                        int seekval = value.round();
                        int result = await player.seek(Duration(milliseconds: seekval));
                        if(result == 1){ //seek successful
                          currentpos = seekval;
                        }else{
                          print("Seek unsuccessful.");
                        }
                      },
                    )
                ),
               Container(
                  height: screenDivision/5,
                  padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        currentpostlabel, style: TextStyle(fontSize: (screenDivision/5)*(1/4)),
                      ),
                      IconButton(
                        onPressed: () async {
                          int result = await player.stop();
                          if(result == 1){ //stop success
                            setState(() {
                              isplaying = false;
                              audioplayed = false;
                              currentpos = 0;
                            });
                          }else{
                            print("Error on stop audio.");
                          }
                        },
                        icon: Icon(Icons.replay_circle_filled_rounded),
                        iconSize: (screenDivision/5)*(3/5),
                        color: Color(0xff7D7A7A),
                      ),
                    ],
                  ),
                ),
              ],
            );
  }
}