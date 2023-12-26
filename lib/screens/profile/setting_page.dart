/*import 'package:fast_food_delivery/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Container(
            width: 80,
            height: 80,
            child: Image.network(user.avatar, fit: BoxFit.cover),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'John Doe',
            // user.name,
            style: Theme.of(context).textTheme.headline3,
          ),
          const SizedBox(
            height: 20,
          ),
       /*   tileWidget(
            context,
            ' Changer Email ',
            'assets/icons/edit.svg',
            () => navigateToPage(context, 'EditEmail'),
          ),
          tileWidget(
            context,
            'Changer mot de passe ',
            'assets/icons/edit.svg',
            () => navigateToPage(context, 'Editpassword'),
          ),
          tileWidget(
            context,
            'Désactive compte',
            'assets/icons/location.svg',
            () => navigateToPage(context, 'bloquecompte'),
          ),*/
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const login_page(),
                ),
              );
            },
            child: Container(
              width: double.infinity,
              height: 54,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  'Logout'.toUpperCase(),
                  style: Theme.of(context).textTheme.button,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

 */
import 'package:delivery_3jeja/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('Paramétre'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Container(
                width: 80,
                height: 80,
                child: Image.network(user.avatar, fit: BoxFit.cover),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                user.name,
                style: Theme.of(context).textTheme.headline3,
              ),
              tileWidget(
                context,
                ' Changer Email ',
                'assets/icons/edit.svg',
                () => navigateToPage(context, 'EditEmail'),
              ),
              tileWidget(
                context,
                'Changer mot de passe ',
                'assets/icons/edit.svg',
                () => navigateToPage(context, 'Editpassword'),
              ),
              tileWidget(
                context,
                'Désactive compte',
                'assets/icons/location.svg',
                () => navigateToPage(context, 'bloquecompte'),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void navigateToPage(BuildContext context, String page) {
  // Naviguer vers la page spécifiée ici
  if (page == 'EditEmail') {
    print("Edit email ");
    /*  Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => EditProfilePage(),
      ));*/
  } else if (page == 'Editpassword') {
    /* Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PreloadPage(),
      ));*/
  } else if (page == 'bloquecompte') {
    /*Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AddressSetupPage(),
      ));
  */
  }
}

Widget tileWidget(
    BuildContext context, String title, String icon, Function() navigateTo) {
  return SizedBox(
    height: 50,
    child: Row(
      children: [
        InkWell(
          // onTap: navigateTo,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorLight,
              borderRadius: BorderRadius.circular(10),
            ),
            child: SvgPicture.asset(
              icon,
              height: 20,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black
                  : Colors.white,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.headline6,
        ),
        const Spacer(),
        InkWell(
          onTap: navigateTo,
          child: SvgPicture.asset('assets/icons/next.svg'),
        ),
      ],
    ),
  );
}
