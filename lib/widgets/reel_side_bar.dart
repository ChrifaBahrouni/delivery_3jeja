import "dart:math";

import "package:flutter/material.dart";
class ReelSideBar extends StatefulWidget {
  const ReelSideBar({super.key});

  @override
  State<ReelSideBar> createState() => _ReelSideBarState();
}

class _ReelSideBarState extends State<ReelSideBar> with SingleTickerProviderStateMixin {
  late AnimationController _animationController  ;
  @override
  void initState() {
   _animationController   = AnimationController(vsync:  this ,
    duration:const Duration(seconds: 5 ) , 
      ) ; 
    
    super.initState();
  }
  @override
  void dispose() {
    _animationController.dispose() ; 
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
     TextStyle style = Theme.of(context).textTheme.bodyText1!.copyWith(fontSize:13 , color: Colors.white   ) ; 
   
    return Padding(
      padding: const EdgeInsets.only(right : 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [_profileImageButton() ,
         _SideBarItem('heart', '1.2M', style) ,   
         _SideBarItem('comment', '123', style) ,   
         _SideBarItem('share', 'share', style) ,   
         AnimatedBuilder(animation: _animationController, 
          child: Stack(
            alignment: Alignment.center,
            children: [
            Container( 
              height: 50,
             width: 50 ,
              //color: Colors.amber,
              child: Image.asset('assets/disc.png'),

             ) , 
             const  CircleAvatar(
                radius: 12 , 
                backgroundImage:
                //NetworkImage('') ,
                AssetImage('assets/images/profile_picture.png'),
                )

          ] , 
          ) ,
         builder:  (context , child){
          return  Transform.rotate(angle: 2 * pi * _animationController.value , 
           child:child ,
        ) ; 
         })
         ],
      ),
    );
  }
  GestureDetector _SideBarItem(String iconName, String label, TextStyle style) {
  return GestureDetector(
    onTap: () {
      // This function will be called when the widget is tapped.
      print('Widget tapped!');
    },
    child: Column(
      children: [
        Container(
          height: 50,
          width: 50,
          child: Image.asset('assets/$iconName.png'),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: style,
        ),
      ],
    ),
  );
}

_profileImageButton() {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(25),
              image: DecorationImage(image:
              // NetworkImage('')
              AssetImage('assets/images/profile_picture.png'),
               )),
        ),
        Positioned(
            bottom: -10,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Icon(
                Icons.add,
                 color: Colors.white,
                size: 20,
              ),
            ))
      ],
    );
  }
}
