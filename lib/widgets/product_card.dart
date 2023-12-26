
import 'package:delivery_3jeja/models/product.dart';
import 'package:delivery_3jeja/screens/product_details_page.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

class ProductCardWidget extends StatelessWidget {
  final Product product;
  const ProductCardWidget({
    super.key,
    required this.product,
    /* required this.image,
      required this.title,
      required this.price*/
  });
  //final String title, image, price;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => ProductDetailsPage(product: product)),
        );
      },
      child: Container(
          height: 250,
          width: MediaQuery.of(context).size.width / 2.3,
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).primaryColorLight,
          ),
          child: Stack(
            children: [
              Stack(
                children: [
                  Positioned(
                    right: 10,
                    bottom: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.light
                            ? const Color(0xFF5EB7BF) //const Color(0xFF321D0B)
                            : const Color(0xFFFF9314),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        child: SvgPicture.asset(
                          'assets/icons/basket.svg',
                          height: 20,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 160,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(product.image),
                            /* AssetImage(
                              product.image ,
                            ),*/
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Container(
                        padding: const EdgeInsets.all(13),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              //(product.price ) as String,
                              '\$${product.price}',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                    color: const Color(0xFFFF9314),
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Positioned(
                right: 10,
                top: 10,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(5),
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
            ],
          )),
    );
  }
}
