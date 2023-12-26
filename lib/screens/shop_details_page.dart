import 'package:delivery_3jeja/models/bayer.dart';
import "package:delivery_3jeja/models/product.dart";
import "package:delivery_3jeja/services/home_services.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:google_fonts/google_fonts.dart";

import '../widgets/product_card.dart';

class ShopDetailsPage extends StatefulWidget {
  final FastFood fastFood;

  const ShopDetailsPage({Key? key, required this.fastFood}) : super(key: key);

  @override
  State<ShopDetailsPage> createState() => _ShopDetailsPageState();
}

class _ShopDetailsPageState extends State<ShopDetailsPage> {
  List<Product>? ProduitsList;
  final HomeServices homeServices = HomeServices();
  @override
  void initState() {
    super.initState();

    fetchproduits();
  }

  void fetchproduits() async {
    ProduitsList = await homeServices.fetchProductbymagasin(
        context: context, magasin: widget.fastFood.id);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headerWidget(context),
            const SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  tagWidget(context, 'Hot Coffee'),
                  tagWidget(context, 'Iced Coffee'),
                  tagWidget(context, 'Salads'),
                  tagWidget(context, 'Burger & Sandwich'),
                ],
              ),
            ),
            Row(
              children: [
                for (final prod in ProduitsList ?? [])
                  ProductCardWidget(
                    product: prod,
                  ),
                /* ProductCardWidget(
                  image: 'assets/images/coffee2.png',
                  title: 'Macchiato Short',
                  price: '\$ 5.00',
                ),
                ProductCardWidget(
                  image: 'assets/images/coffee1.png',
                  title: 'Americano',
                  price: '\$ 5.00',
                ),**/
              ],
            ),
            /* Row(
                children: const [
                ProductCardWidget(
                  image: 'assets/images/coffee3.png',
                  title: 'Caramel Machiato',
                  price: '\$ 5.00',
                ),
                ProductCardWidget(
                  image: 'assets/images/coffee4.png',
                  title: 'Espresso',
                  price: '\$ 5.00',
                ),
              ],
                ),*/
            Row(
              children: List.generate(
                ((ProduitsList?.length ?? 0) / 2).ceil(),
                (index) {
                  final firstProductIndex = index * 2;
                  final secondProductIndex = index * 2 + 1;

                  return Row(
                    children: [
                      if (firstProductIndex < (ProduitsList?.length ?? 0))
                        Expanded(
                          child: ProductCardWidget(
                            product: ProduitsList![firstProductIndex]!,
                          ),
                        ),
                      SizedBox(width: 10),
                      if (secondProductIndex < (ProduitsList?.length ?? 0))
                        Expanded(
                          child: ProductCardWidget(
                            product: ProduitsList![secondProductIndex]!,
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget tagWidget(BuildContext context, String title) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorLight,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget headerWidget(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 300,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(widget.fastFood.avatar),
              /* AssetImage(
                  widget.fastFood.avatar),*/ //'assets/images/shop.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.7),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: 10,
          bottom: 10,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                //'Starbucks - CSB Mall',
                widget.fastFood.nom_etab,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/location.svg',
                    height: 16,
                    color: Colors.white,
                  ),
                  SizedBox(width: 2),
                  Text(
                    // widget.fastFood.distance,
                    '1.2 Km',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 7),
                  Container(
                    height: 4,
                    width: 4,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  SizedBox(width: 10),
                  SvgPicture.asset(
                    'assets/icons/star.svg',
                    height: 16,
                  ),
                  SizedBox(width: 2),
                  Text(
                    '4.6 (342)',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/bike.svg',
                    height: 16,
                    color: Colors.white,
                  ),
                  SizedBox(width: 2),
                  Text(
                    '\$5.00',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    height: 4,
                    width: 4,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  SizedBox(width: 10),
                  SvgPicture.asset(
                    'assets/icons/time.svg',
                    height: 16,
                  ),
                  SizedBox(width: 2),
                  Text(
                    widget.fastFood.items,
                    //'10.00 AM - 12.00 PM',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          right: 15,
          top: 40,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              margin: const EdgeInsets.all(8),
              child: SvgPicture.asset(
                'assets/icons/heart.svg',
                height: 20,
              ),
            ),
          ),
        ),
        Positioned(
          top: 40,
          left: 15,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                margin: const EdgeInsets.all(8),
                child: const Center(
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
