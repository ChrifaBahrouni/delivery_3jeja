import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class VideoDetails extends StatefulWidget {
  const VideoDetails({super.key});

  @override
  State<VideoDetails> createState() => _VideoDetailsState();
}

class _VideoDetailsState extends State<VideoDetails> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "@ yean_yees" , 
             style: 
              Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 15 , color: Colors.white , fontWeight: FontWeight.bold),
          ) , 
          SizedBox(
            height: 8, 
          ) ,
          ExpandableText(' video caption goes here ! video caption goes here !  video caption goes here ! ',
           expandText: 'more' , 
           
           style:Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 13 , color: Colors.white , fontWeight: FontWeight.bold) ,
              collapseText: 'less',
              expandOnTextTap: true ,
              ) , 
           SizedBox(
            height: 8, 
          ) , 
          Row(
            children: [
              Icon(CupertinoIcons.music_note_2 , size:15 , color: Colors.white,) , 
             SizedBox(
            height: 8, 
          ) ,
          Container(
            height: 20 ,
            width: MediaQuery.of(context).size.width /2 ,
            child:  Marquee(text: 'audio name ' , 
            velocity: 8, 
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 13 , 
              color: Colors.white ,
               fontWeight: FontWeight.bold),
               ),
    
          )
            ],
          )
        ],
      ),
    );
  }
}