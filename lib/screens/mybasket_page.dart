import "package:delivery_3jeja/models/product.dart";
import "package:delivery_3jeja/screens/order_details_page.dart";
import "package:delivery_3jeja/services/cart_services.dart";
import "package:delivery_3jeja/services/product_details_services.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../providers/user_provider.dart";
import "../widgets/cart_product.dart";

class MyBasketPage extends StatefulWidget {
  // final int index;
  const MyBasketPage({
    Key? key,
    //  required this.index,
  }) : super(key: key);

  @override
  State<MyBasketPage> createState() => _MyBasketPageState();
}

class _MyBasketPageState extends State<MyBasketPage> {
  final ProductDetailsServices productDetailsServices =
      ProductDetailsServices();
  final CartServices cartServices = CartServices();

  void increaseQuantity(Product product) {
    productDetailsServices.addToCart(
      context: context,
      product: product,
    );
  }

  void decreaseQuantity(Product product) {
    cartServices.removeFromCart(
      context: context,
      product: product,
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    int sum = 0;
    user.cart
        .map((e) => sum += e['quantity'] * e['product']['price'] as int)
        .toList();

    /*int sum = 0;
  

    user.cart.forEach((cartItem) {
      int quantity = cartItem['quantity'];
      int price = cartItem['product']['price'];
      print("sum ${sum}");
      sum += quantity * price;
    });
 */
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      bottomNavigationBar: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const OrderDetailsPage(),
            ),
          );
        },
        child: Container(
          width: double.infinity,
          height: 60,
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 40),
          decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.light
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).primaryColorLight,
              borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? const Color(0xFF273244)
                          : const Color(0xFF323232),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    //'   1   ',
                    ' ${user.cart.length} ',
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                 const SizedBox(
                  width: 60,
                ),
                Text(
                  'Go to Checkout',
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                ),
                const  SizedBox(
                  width: 30,
                ),
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? const Color(0xFF273244)
                          : const Color(0xFF323232),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    //'\$10.00',
                    ' ${sum}DT',
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text(
              'My Basket',
              style: Theme.of(context).textTheme.headline3,
            ),
            /*  tileWidget(
              context,
              'assets/images/2.jpeg',
              'Starbucks - CSB Mall',
              '2 Items',
              '28, July 2021',
            ), 

            tileWidget(
              context,
              'assets/images/3.jpeg',
              'KFC Coffee - Kartini Street',
              '2 Items',
              '28, July 2021',
            ),
            tileWidget(
              context,
              'assets/images/1.jpeg',
              'Semasa Coffee',
              '2 Items',
              '28, July 2021',
            ),*/
            const SizedBox(height: 5),
            // error to maps

            ListView.builder(
              itemCount: user.cart.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return CartProduct(
                  index: index,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget tileWidget(BuildContext context, String image, String title,
      String items, String date) {
    return Container(
      padding: const EdgeInsets.all(13),
      width: double.infinity,
      child: Column(
        children: [
          Row(
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 05,
                  ),
                  Text(
                    items,
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontSize: 10,
                        ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                'Edit',
                style: Theme.of(context).textTheme.headline5,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            color: Theme.of(context).dividerColor,
            height: 2,
            width: double.infinity,
          ),
        ],
      ),
    );
  }
}
