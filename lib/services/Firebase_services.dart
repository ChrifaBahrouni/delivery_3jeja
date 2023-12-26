
//import 'package:firebase_messaging/firebase_messaging.dart';
class FirebaseServices {
  /*final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    print('Titre : ${message.notification?.title}');
    print('Body : ${message.notification?.body}');
    print('Payload : ${message.data}');
  }
Future<void> handleMessage(RemoteMessage message) async {
     if (message == null ) return ; 
      //navigatorKey.curretState?.pushNamed()
  } 
  Future<void> initPushNotifications() async {
    await FirebaseMessaging.instance .setForegroundNotificationPresentationOptions(
      alert:  true , 
       badge:  true , 
        sound:  true , 
    ) ; 
    FirebaseMessaging.instance.getInitialMessage()
.then(handleMessage as FutureOr Function(RemoteMessage? value)) ; 
    } 
  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final FCMTocken = await _firebaseMessaging.getToken();
    print("Tocken :$FCMTocken ");
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
*/

  
}
