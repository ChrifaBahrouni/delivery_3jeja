import 'package:delivery_3jeja/screens/Partenaire/screens/add_product_screen.dart';
import 'package:delivery_3jeja/screens/Partenaire/screens/category/categories.dart';
import 'package:delivery_3jeja/screens/login_page.dart';
import 'package:delivery_3jeja/screens/profile/address_setup_page.dart';
import 'package:delivery_3jeja/screens/profile/change_password.dart';
import 'package:delivery_3jeja/screens/profile/edit_profile.dart';

import 'package:delivery_3jeja/screens/partner_page.dart';
import 'package:delivery_3jeja/screens/profile/payement_methode.dart';
import 'package:delivery_3jeja/screens/preload_page.dart';
import 'package:delivery_3jeja/screens/profile/setting_page.dart';
import 'package:delivery_3jeja/widgets/item_account.dart';
import 'package:delivery_3jeja/widgets/text_custom.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';
import '../login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          children: [
            const SizedBox(height: 20.0),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 80,
                height: 80,
                child: Image.network(user.avatar, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 20.0),
            Center(
                child: TextCustom(
                    text: user.name,
                    fontSize: 25,
                    fontWeight: FontWeight.w500)),
            const SizedBox(height: 5.0),
            Center(
                child: TextCustom(
                    text: user.email, fontSize: 20, color: Colors.grey)),
            const SizedBox(height: 15.0),
            const TextCustom(text: 'Account', color: Colors.grey),
            const SizedBox(height: 10.0),
            ItemAccount(
                text: 'Modifier Profil ',
                icon: Icons.person,
                colorIcon: 0xff01C58C,
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>  const EditProfilePage(),
                    ))),
            ItemAccount(
                text: 'Change Password',
                icon: Icons.lock_rounded,
                colorIcon: 0xff1B83F5,
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const  ChangePasswordPage(),
                    ))),
            ItemAccount(
                text: 'Add addresses',
                icon: Icons.my_location_rounded,
                colorIcon: 0xffFB5019,
                onPressed: () => // print( ''),
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>  const AddressSetupPage(),
                    ))),
            ItemAccount(
                text: 'Méthode paiement',
                icon: Icons.credit_card,
                colorIcon: 0xffFBAD49,
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>  const PaymentMethodPage(),
                    ))),
            ItemAccount(
                text: 'Bon Plan',
                icon: Icons.newspaper,
                colorIcon: 0xffFBAD49,
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>  const PreloadPage(),
                    ))),
             const ItemAccount(
              text: 'Change Role',
              icon: Icons.arrow_forward,
              colorIcon: 0xff051E2F,
            ),
             const ItemAccount(
              text: 'Dark mode',
              icon: Icons.dark_mode_rounded,
              colorIcon: 0xff051E2F,
            ),
            const SizedBox(height: 15.0),
            const TextCustom(text: 'Fast Food', color: Colors.grey),
            const SizedBox(height: 10.0),
            ItemAccount(
              text: ' Catégories',
              icon: Icons.category_outlined,
              colorIcon: 0xff6dbd63,
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>   const CategoriesScreen() ,
                    ))),
            
            ItemAccount(
              text: 'Produits',
              icon: Icons.add,
              colorIcon: 0xff1F252C,
                 onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>   const AddProductScreen() ,
                    ))),
            
            ItemAccount(
              text: 'Orders',
              icon: Icons.shopping_bag_outlined,
              colorIcon: 0xffFBAD49,
              onPressed: () =>  print(' orders fast food '),
            ),
            ItemAccount(
                text: 'Notifications ',
                icon: Icons.notifications,
                colorIcon: 0xffFB5019,
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>  const ChangePasswordPage(),
                    ))),
            const SizedBox(height: 15.0),
            const TextCustom(text: 'Personal ', color: Colors.grey),
            const SizedBox(height: 10.0),
            const  ItemAccount(
              text: 'Term & Conditions',
              icon: Icons.description_outlined,
              colorIcon: 0xff458bff,
            ),
            const  ItemAccount(
              text: 'Help',
              icon: Icons.help_outline,
              colorIcon: 0xff4772e6,
            ),
            const Divider(),
            ItemAccount(
              text: 'Déconnexion',
              icon: Icons.power_settings_new_sharp,
              colorIcon: 0xffF02849,
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const Login_page(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      //bottomNavigationBar: BottomNavigationFrave(3),
    );
  }

  void navigateToPage(BuildContext context, String page) {
    // Naviguer vers la page spécifiée ici
    if (page == 'Editprofil') {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>  const EditProfilePage(),
      ));
    } else if (page == 'BonsPlans') {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>  const PreloadPage(),
      ));
    } else if (page == 'partner') {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const  PartnerPage(),
      ));
    } else if (page == 'AddressInfo') {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>  const AddressSetupPage(),
      ));
    } else if (page == 'PaymentMethod') {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>  const PaymentMethodPage(),
      ));
    } else if (page == 'RewardsCoupon') {
      // À compléter avec la page RewardsCouponPage
    } else if (page == 'Settings') {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const SettingPage()));
    } else if (page == 'Logout') {
      //print("Logout ");
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const Login_page(),
        ),
      ); // À compléter avec la page PrivacyPolicyPage
    } else if (page == 'AboutApp') {
      // À compléter avec la page AboutAppPage
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
              padding:  const EdgeInsets.all(8),
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
}

Widget cardwidget(
    BuildContext context, String title, String icon, Function() navigateTo) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      color: Colors.blue, // Choisissez la couleur que vous préférez
      child: InkWell(
        onTap: navigateTo,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding:  const EdgeInsets.all(8),
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
           const   SizedBox(
              height: 10,
            ),
             Text(
              title,
              style: const  TextStyle(
                  color: Colors
                      .white), // Choisissez la couleur du texte que vous préférez
            ),
          ],
        ),
      ),
    ),
  );
}

