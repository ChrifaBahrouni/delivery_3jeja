
import 'package:delivery_3jeja/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../widgets/loader.dart';
import '../../../widgets/single_product.dart';
import '../services/partenaire_services.dart';
import 'add_product_screen.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  List<Product>? products;
  final PartenaireServices partenaireServices = PartenaireServices();

  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  fetchAllProducts() async {
    products = await partenaireServices.fetchAllProductsBybayer(context);
    setState(() {});
  }

  void deleteProduct(Product product, int index) {
    partenaireServices.deleteProduct(
      context: context,
      product: product,
      onSuccess: () {
        products!.removeAt(index);
        setState(() {});
      },
    );
  }

  void navigateToAddProduct() {
    // Navigator.pushNamed(context, AddProductScreen.routeName);
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const AddProductScreen(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? const Loader()
        : Scaffold(
            body: GridView.builder(
              itemCount: products!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                final productData = products![index];
                return Column(
                  children: [
                    SizedBox(
                      height: 100,
                      child: SingleProduct(
                        image: productData.image,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Text(
                            productData.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        IconButton(
                          onPressed: () => deleteProduct(productData, index),
                          icon: const Icon(
                            Icons.delete_outline,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: navigateToAddProduct,
              tooltip: 'Add a Product',
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }

  Widget ProductWidget(Product p, {required double screenHeight}) {
    return InkWell(
      onTap: () {
        print(" delete product ");
      },
      child: Container(
          height: screenHeight, // Ajustez le coefficient selon vos besoins
          width: MediaQuery.of(context).size.width,
          //height: 250,
          //width: MediaQuery.of(context).size.width / 2.3,
          margin: const EdgeInsets.all(1),
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
                            image: NetworkImage(p.image),
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
                              p.name,
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
                              '\$${p.price}',
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
