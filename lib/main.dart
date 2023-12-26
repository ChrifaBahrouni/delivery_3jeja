
import 'package:delivery_3jeja/providers/user_provider.dart';
import 'package:delivery_3jeja/router.dart';
import 'package:delivery_3jeja/screens/Partenaire/screens/partenaire_screen.dart';
import 'package:delivery_3jeja/screens/coursie/main_coursie.dart';
import 'package:delivery_3jeja/screens/main_page.dart';
import 'package:delivery_3jeja/screens/splash_page.dart';
import 'package:delivery_3jeja/services/auth_service.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'config/theme.dart';
void main()   {
  //Stripe.publishableKey = 'pk_test_51MBPevKNrVArcxobRF1wtNwVlInrbDSBTnDTBnrj5f6QslHHwYoYoLgO7CoHhFSdWxxFdh6EIIiJICGf9WcNbcqF00uYK1uoAK'; // Replace with your actual publishable key
 //await FirebaseServices(). initNotifications() ; 
 //WidgetsFlutterBinding.ensureInitialized();
 /*await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
).then((value) {
    print("Firebase initialisé avec succès !");
  }).catchError((error) {
    print("Erreur d'initialisation Firebase : $error");
  });*/
 
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context);

  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) => generateRoute(settings),
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? Provider.of<UserProvider>(context).user.type == 'user'
              ? const MainScreen()
              : Provider.of<UserProvider>(context).user.type == 'coursie'
                  ? const MainCoursie()
                  : const PartenaireScreen()
          : const Splash_page(),
    );
  }
   
}
