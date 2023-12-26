

import 'package:delivery_3jeja/screens/Partenaire/screens/analtyics_screen.dart';
import 'package:delivery_3jeja/screens/Partenaire/screens/posts_screen.dart';
import 'package:delivery_3jeja/screens/preload_page.dart';
import 'package:delivery_3jeja/screens/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'orders_screen.dart';

class PartenaireScreen extends StatefulWidget {
  static const String routeName = '/actual-home-Partenaire';
  const PartenaireScreen({Key? key}) : super(key: key);

  @override
  State<PartenaireScreen> createState() => _PartenaireScreenState();
}

class _PartenaireScreenState extends State<PartenaireScreen> {
  int _currentIndex = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    const PostsScreen(),
    const PreloadPage(),
    const AnalyticsScreen(),
    const OrdersScreen(),
    const ProfilePage()
  ];

  void updatePage(int page) {
    setState(() {
      _currentIndex = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final userCartLen = context.watch<UserProvider>().user.cart.length;

    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        // floatingActionButton:
        /* InkWell(
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
        // extendBody: true,
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
                  onTap: () => updatePage(0),
                  child: SvgPicture.asset(
                    'assets/icons/home.svg',
                    height: 24,
                    width: 24,
                    color: _currentIndex == 0
                        ? Colors.white
                        : const Color(0xff717171),
                  ),
                ),
                InkWell(
                  onTap: () => updatePage(1),
                  child: SvgPicture.asset(
                    'assets/icons/instagram-reels-icon.svg',
                    height: 24,
                    width: 24,
                    color: _currentIndex == 1
                        ? Colors.white
                        : const Color(0xff717171),
                  ),
                ),
                InkWell(
                  onTap: () => updatePage(2),
                  child: SvgPicture.asset(
                    'assets/icons/project-analysis-icon.svg',
                    height: 24,
                    width: 24,
                    color: _currentIndex == 2
                        ? Colors.white
                        : const Color(0xff717171),
                  ),
                ),
                InkWell(
                  onTap: () => updatePage(3),
                  child: SvgPicture.asset(
                    'assets/icons/document.svg',
                    height: 24,
                    width: 24,
                    color: _currentIndex == 3
                        ? Colors.white
                        : const Color(0xff717171),
                  ),
                ),
                InkWell(
                  onTap: () => updatePage(4),
                  child: SvgPicture.asset(
                    'assets/icons/profile.svg',
                    height: 24,
                    width: 24,
                    color: _currentIndex == 4
                        ? Colors.white
                        : const Color(0xff717171),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Container(
          child: pages.elementAt(_currentIndex),
        ));
  }
  /* @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /* Container(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'assets/images/amazon_in.png',
                  width: 120,
                  height: 45,
                  color: Colors.black,
                ),
              ),*/
              const Text(
                'Partenaire',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        onTap: updatePage,
        items: [
          // POSTS
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 0
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: const Icon(
                Icons.home_outlined,
              ),
            ),
            label: '',
          ),
          /*// ANALYTICS
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 1
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: const Icon(
                Icons.analytics_outlined,
              ),
            ),
            label: '',
          ),
          */ // ORDERS
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 1
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: const Icon(
                Icons.all_inbox_outlined,
              ),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
*/
}
