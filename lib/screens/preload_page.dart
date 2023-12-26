import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:preload_page_view/preload_page_view.dart';

import '../controller.dart';
import '../widgets/player.dart';

class PreloadPage extends StatelessWidget {
  static const String routeName = '/reels';
  const PreloadPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(PCC());
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor:
            Colors.transparent, // Set the background color to transparent
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                child: Text(
                  ' Following',
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
                //color: Colors.orange
              ),
              flex: 2,
            ),
            Expanded(
              child: Container(
                child: Text(
                  ' |',
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
                // color: Colors.orange
              ),
              flex: 1,
            ),
            Expanded(
              child: Container(
                child: Text(
                  ' For You ',
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
                // color: Colors.orange
              ),
              flex: 2,
            ),
            //Text(" For You  "),
            Expanded(
              child: InkWell(
                child: const Icon(
                  Icons.add_a_photo_rounded,
                  color: Colors.white,
                ),
                onTap: () {
                  print('add reel ');
                },
              ),
              flex: 4,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          child: PreloadPageView.builder(
            itemBuilder: (ctx, i) {
              return Player(i: i);
            },
            onPageChanged: (i) async {
              c.updateAPI(i);
            },
            //If you are increasing or descrising preaload page count change accordingly in the player widget
            preloadPagesCount: 1,
            controller: PreloadPageController(initialPage: 0),
            itemCount: c.videoURLs.length,
            scrollDirection: Axis.vertical,
            physics: const AlwaysScrollableScrollPhysics(),
          ),
        ),
      ),
    );
  }
}
