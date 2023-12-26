import 'package:delivery_3jeja/models/bayer.dart';
import "package:delivery_3jeja/models/brand.dart";
import "package:delivery_3jeja/models/product.dart";
import "package:delivery_3jeja/screens/favourite_items_page.dart";
import "package:delivery_3jeja/screens/shop_details_page.dart";
import "package:delivery_3jeja/services/home_services.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:provider/provider.dart";

import "../providers/user_provider.dart";
import '../widgets/product_card.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Product? product;
  List<FastFood>? fastfoodList;
  List<Brand>? brandsList;
  List<Product>? produitsList;
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchDealOfDay();
    fetchFastFood();
    fetchbrands();
    fetchproduits();
  }

  void fetchDealOfDay() async {
    product = await homeServices.fetchDealOfDay(context: context);
    setState(() {});
  }

  void fetchFastFood() async {
    brandsList = await homeServices.fetchBrands(context: context);
    setState(() {});
  }

  void fetchbrands() async {
    fastfoodList = await homeServices.fetchFastFood(context: context);
    setState(() {});
  }

  void fetchproduits() async {
    produitsList = await homeServices.fetchProduct(context: context);
    setState(() {});
  }

  void navigateToDetailsShop(FastFood fastFood) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ShopDetailsPage(fastFood: fastFood),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: const  EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Hello, ',
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            TextSpan(
                              text: user.name, // 'John!',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(
                                    color: const Color(0xFFFF9314),
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/location.svg',
                            color: Theme.of(context).textTheme.headline5!.color,
                            height: 20,
                            width: 20,
                          ),
                          Text(
                            'Jakarta, Indonesia', // user.adresse,
                            style:
                                Theme.of(context).textTheme.subtitle1!.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFFFF9314),
                                    ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColorLight,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          child: SvgPicture.asset(
                            'assets/icons/ticket.svg',
                            height: 20,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const FavouriteItemsPage(),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColorLight,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            child: SvgPicture.asset(
                              'assets/icons/heart.svg',
                              height: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // publicites

              Image.asset(
                'assets/images/Banner.png',
              ),

              Text(
                'Recommended for you',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (final prod in produitsList ?? [])
                      ProductCardWidget(
                        product: prod,
                      ),
                  ],
                ),
              ),
              Text(
                'popular brand',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (final brand in brandsList ?? [])
                      brandsButton(context, brand.image),
                  ],
                ),
              ),
              Text(
                'Restaurant ',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              for (final fastFood in fastfoodList ?? [])
                tileWidget(context, fastFood.avatar, fastFood.nom_etab,
                    fastFood.items, "2.0 km", fastFood), // fastFood.distance

              /* tileWidget(
                context,
                'assets/images/3.jpeg',
                'KFC Coffee - Kartini',
                '10.00 AM - 12.00 PM',
                '2.0 km',
              ),
              tileWidget(
                context,
                'assets/images/1.jpeg',
                'Semasa Coffee',
                '10.00 AM - 12.00 PM',
                '2.5 km',
              ),*/
            ],
          ),
        ),
      ),
    );
  }

  Widget tileWidget(BuildContext context, String image, String title,
      String items, String distance, fastFood) {
    return InkWell(
      onTap: () {
        navigateToDetailsShop(fastFood);
        /*Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ShopDetailsPage(),
          ),
        );*/
      },
      child: Container(
        height: 100,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).primaryColorLight,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(
                    image,
                  ),
                  /* AssetImage(
                    image,
                  ),*/
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                        fontSize: 12,
                      ),
                ),
                Text(
                  items,
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        fontSize: 10,
                      ),
                ),
                const Spacer(),
                Text(
                  'OPEN NOW',
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFFFF9314),
                      ),
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/location.svg',
                  height: 12,
                  color: Theme.of(context).textTheme.headline6!.color,
                ),
                Text(
                  distance,
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        fontSize: 10,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget brandsButton(BuildContext context, String asset) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 70,
      width: 70,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorLight,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Image.network(asset), // Image.asset(asset),
    );
  }

  Widget categoryButton(BuildContext context, String image, String title) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 70,
      // width: 70,
      margin: const EdgeInsets.all(10),
      /* decoration: BoxDecoration(
        color: Theme.of(context).primaryColorLight,
        borderRadius: BorderRadius.circular(20),
      ),*/
      // child: Image.asset(asset),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                image,
                // GlobalVariables.categoryImages[index]['image']!,
                fit: BoxFit.cover,
                height: 40,
                width: 40,
              ),
            ),
          ),
          Text(
            title,
            //global_variables.categoryImages[index]['title']!,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
