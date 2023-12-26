
import 'package:delivery_3jeja/widgets/reel_side_bar.dart';
import 'package:delivery_3jeja/widgets/video_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:video_player/video_player.dart';

import '../controller.dart';

class Player extends StatelessWidget {
  final int i;
  Player({Key? key, required this.i}) : super(key: key);

  final PCC c = Get.find();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PCC>(
      initState: (x) async {
        //Need to change conditions according preaload page count
        //Don't load too many pages it will cause performance issue.
        // Below is for 1 page preaload.
        if (c.api > 1) {
          await c.disposeController(c.api - 2);
        }
        if (c.api < c.videoPlayerControllers.length - 2) {
          await c.disposeController(c.api + 2);
        }
        if (!c.initilizedIndexes.contains(i)) {
          await c.initializePlayer(i);
        }
        if (c.api > 0) {
          if (c.videoPlayerControllers[c.api - 1] == null) {
            await c.initializeIndexedController(c.api - 1);
          }
        }
        if (c.api < c.videoPlayerControllers.length - 1) {
          if (c.videoPlayerControllers[c.api + 1] == null) {
            await c.initializeIndexedController(c.api + 1);
          }
        }
      },
      builder: (_) {
        if (c.videoPlayerControllers.isEmpty ||
            c.videoPlayerControllers[c.api] == null ||
            !c.videoPlayerControllers[c.api]!.value.isInitialized) {
          return const Center(child: CircularProgressIndicator());
        }

        if (i == c.api) {
          //If Index equals Auto Play Index
          //Set AutoPlay True Here
          if (i < c.videoPlayerControllers.length) {
            if (c.videoPlayerControllers[c.api]!.value.isInitialized) {
              c.videoPlayerControllers[c.api]!.play();
            }
          }
          print('AutoPlaying ${c.api}');
        }
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
              c.videoPlayerControllers.isNotEmpty &&
                    c.videoPlayerControllers[c.api]!.value.isInitialized
                ? GestureDetector(
                    onTap: () {
                      if (c.videoPlayerControllers[c.api]!.value.isPlaying) {
                        print("paused");
                        c.videoPlayerControllers[c.api]!.pause();
                      } else {
                        c.videoPlayerControllers[c.api]!.play();
                        print("playing");
                      }
                    },
                    child: VideoPlayer(c.videoPlayerControllers[c.api]!),
                  )
                : const Center(child: CircularProgressIndicator()),
         
          /*  Container(
              color: Colors.purple,
              
            ),*/
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  flex: 5,
                    child: Container(
                  height: MediaQuery.of(context).size.height / 4,
                 
                  // color:Colors.amber,
                  child: const VideoDetails(),
                )) , 
                 Expanded(
                  flex: 3,
                    child: Container(
                  height: MediaQuery.of(context).size.height / 1.75,
                 // color: Colors.pink,
                 child: const ReelSideBar(),
                ))
              ],
            ),
           ],
        );
      },
    );
  }
}
