
import "package:delivery_3jeja/screens/coursie/game_page.dart";
import "package:delivery_3jeja/screens/coursie/taches_page.dart";
import "package:delivery_3jeja/screens/profile/profile_page.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";

class MainCoursie extends StatefulWidget {
  static const String routeName = '/home-coursie';

  const MainCoursie({super.key});

  @override
  State<MainCoursie> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainCoursie> {
  int _currentIndex = 0;

  final List<Widget> _widgetOptions = [
    const TachesPage(),
    const Game_page(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    //final userCartLen = context.watch<UserProvider>().user.cart.length;

    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        /* floatingActionButton: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const MyBasketPage(),
            ));
          },
          child: Container(
            height: 60,
            width: 60,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorLight,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Theme.of(context).primaryColorDark,
                width: 0.6,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: SvgPicture.asset(
              'assets/icons/basket.svg',
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black
                  : Colors.white,
            ),
          ),
        ),*/
        extendBody: true,
        bottomNavigationBar: SafeArea(
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 0,
            ),
            height: 80,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Theme.of(context).bottomAppBarColor),
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => _onItemTapped(0),
                  child: SvgPicture.asset(
                    'assets/icons/home.svg',
                    height: 24,
                    width: 24,
                    color: _currentIndex == 0
                        ? Colors.white
                        : const Color(0xff717171),
                  ),
                ),
                /* InkWell(
                  onTap: () => _onItemTapped(1),
                  child: SvgPicture.asset(
                    'assets/icons/search.svg',
                    height: 24,
                    width: 24,
                    color: _currentIndex == 1
                        ? Colors.white
                        : const Color(0xff717171),
                  ),
                ),*/
                InkWell(
                  onTap: () => _onItemTapped(1),
                  child: SvgPicture.asset(
                    'assets/icons/document.svg',
                    height: 24,
                    width: 24,
                    color: _currentIndex == 1
                        ? Colors.white
                        : const Color(0xff717171),
                  ),
                ),
                InkWell(
                  onTap: () => _onItemTapped(2),
                  child: SvgPicture.asset(
                    'assets/icons/profile.svg',
                    height: 24,
                    width: 24,
                    color: _currentIndex == 2
                        ? Colors.white
                        : const Color(0xff717171),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Container(
          child: _widgetOptions.elementAt(_currentIndex),
        ));
  }
}
