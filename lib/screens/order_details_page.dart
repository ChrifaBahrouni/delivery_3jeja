import "dart:convert";

import "package:delivery_3jeja/models/product.dart";
import 'package:delivery_3jeja/screens/profile/address_setup_page.dart';

import "package:delivery_3jeja/screens/main_page.dart";
import 'package:delivery_3jeja/screens/profile/payement_methode.dart';
import "package:delivery_3jeja/services/product_details_services.dart";

import "package:flutter/material.dart";
//import "package:flutter_stripe/flutter_stripe.dart";
import "package:flutter_svg/svg.dart";

import "package:provider/provider.dart";

import "../config/utils.dart";
import "../providers/user_provider.dart";
import "../services/cart_services.dart";
import 'package:http/http.dart' as http;

class OrderDetailsPage extends StatefulWidget {
  //static const String routeName = '/actual-home';

  const OrderDetailsPage({super.key});

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  final ProductDetailsServices productDetailsServices =
      ProductDetailsServices();
  final CartServices cartServices = CartServices();
  //List<PaymentItem> paymentItems = [];

  String addressToBeUsed = "";

  // payement methode
  Map<String, dynamic>? payementIntent;
  @override
  void initState() {
    super.initState();
    /*paymentItems.add(
      PaymentItem(
        amount:  '100' , //widget.totalAmount,
        label: 'Total Amount',
        status: PaymentItemStatus.final_price,
      ),
    );*/
  }

  @override
  void dispose() {
    super.dispose();
    /*flatBuildingController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    cityController.dispose();*/
  }

  void onGooglePayResult(res) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .adresse
        .isEmpty) {
      /* addressServices.saveUserAddress(
          context: context, address: addressToBeUsed);*/
    }
    /*addressServices.placeOrder(
      context: context,
      address: addressToBeUsed,
      totalSum: double.parse(widget.totalAmount),
    );*/
  }

  void payPressed(String addressFromProvider) {
    addressToBeUsed = "";

    /*  bool isForm = flatBuildingController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        pincodeController.text.isNotEmpty ||
        cityController.text.isNotEmpty;

    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
            '${flatBuildingController.text}, ${areaController.text}, ${cityController.text} - ${pincodeController.text}';
      } else {
        throw Exception('Please enter all the values!');
      }
    } else */
    if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      showSnackBar(context, 'ERROR');
    }
  }

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

  void handleCheckout() async {
    cartServices.handleCheckout();
  }

  void onApplePayResult() {
    /*  if (Provider.of<UserProvider>(context, listen: false)
        .user
        .adresse
        .isEmpty) {
      cartServices.saveUserAddress(context: context, address: addressToBeUsed);
    }*/
    cartServices.placeOrder(
        context: context,
        address: addressToBeUsed,
        totalSum: double.parse('12000')
        //totalSum: double.parse(1200.00 as String),
        );
  }

/*Future<void> _startStripeCheckout() async {
    try {
      final response = await http.post(
        Uri.parse('http://your-node-js-server.com/create-checkout-session'),
        body: {
          // Add the necessary data to create the checkout session
          // For example, you might need to send the user ID and cart items
          'userId': 'user_id_here',
          'cartItems': '[{"name": "Product 1", "price": 10}, {"name": "Product 2", "price": 20}]',
        },
      );

      if (response.statusCode == 200) {
        // Extract the session URL from the response
        final data = json.decode(response.body);
        final sessionUrl = data['url'];

        // Launch the Stripe Checkout URL in the user's web browser
        // Make sure to add the url_launcher dependency in your pubspec.yaml file
        // You can also use the webview_flutter package to open the checkout page inside your app
        // For demonstration purposes, we'll use url_launcher here.
        await launch(sessionUrl);
      } else {
        // Handle any errors or display an error message to the user
      }
    } catch (e) {
      // Handle any exceptions or display an error message to the user
    }
  }
 */
  /*

 Future<void> makePayment() async {
    try {
      //STEP 1: Create Payment Intent
      payementIntent = await createPaymentIntent('100', 'USD');

      //STEP 2: Initialize Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
            
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: payementIntent!['client_secret'], //Gotten from payment intent
                  style: ThemeMode.light,
                  merchantDisplayName: 'Ikay'))
          .then((value) {});

      //STEP 3: Display Payment sheet
      displayPaymentSheet();
    } catch (err) {
      throw Exception(err);
    }
  }
*/
  createPaymentIntent(String amount, String currency) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': 100, //calculateAmount(amount),
        'currency': currency,
      };

      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer ', //'Bearer ${dotenv.env['STRIPE_SECRET']}',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

/*
displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        
        //Clear paymentIntent variable after successful payment

        //PaymentIntent = null;
      
      })
      .onError((error, stackTrace) {
        throw Exception(error);
      });
    } 
    on StripeException catch (e) {
    print('Error is:---> $e'); 
    } 
    catch (e) {
      print('$e');
    }
  } 
  */
  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    int sum = 0;
    user.cart
        .map((e) => sum += e['quantity'] * e['product']['price'] as int)
        .toList();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      bottomNavigationBar: InkWell(
        onTap: () {
          onApplePayResult();
          /*Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const  OrderAcceptedPage(),
          ));*/
          //}, () async {
          /* try {
payementIntent = (await createPaymentIntent('10' , 'USD')) as Map<String, dynamic>?; ///) as Map<String, dynamic>?; 
await Stripe.instance.initPaymentSheet(
  paymentSheetParameters: SetupPaymentSheetParameters(
 paymentIntentClientSecret:  payementIntent!['client_secret'] ,
 applePay: const PaymentSheetApplePay(merchantCountryCode: '+93')  , 
 googlePay:  const PaymentSheetGooglePay( testEnv : true ,
  currencyCode:"", 
  merchantCountryCode: 'IN' 
  ) , 
  style: ThemeMode.dark , merchantDisplayName: 'Adnan' ,


 ) ) ;  
  } catch (e, s) {
      
      debugPrint('exception in initPaymentSheet method:$e$s');
    } */
          /* () async {
           final clientSecret = await createPaymentIntent();
                await Stripe.instance.initPaymentSheet(
                  paymentSheetParameters: SetupPaymentSheetParameters(
                    paymentIntentClientSecret: clientSecret,
                    //applePay: false,
                    //googlePay: false,
                    merchantDisplayName: "OpenSourceX",
                    //merchantCountryCode: "IN",
                  ),
                );
                await Stripe.instance.presentPaymentSheet();
          final url = Uri.parse("");
          Map<String, dynamic> body = {"amount": 1000, "currency": "USD"};
          final response = await http.post(url, body: body);
          var jsonResponse = jsonDecode(response.body);
          Map<String, dynamic> paymentIntentData = jsonResponse;
          if (paymentIntentData['paymentIntent'] != "" &&
              paymentIntentData['paymentIntent'] != null) {
            String _intent = paymentIntentData['paymentIntent'];
            await Stripe.instance.initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                paymentIntentClientSecret: _intent,
                //applePay: false,
                //googlePay: false,
                merchantDisplayName: "OpenSourceX",
                // merchantCountryCode : "IN" ,
              ),
            );
          } else {
            // Handle error or invalid response
          }
        }*/
        },
        child: Container(
          width: double.infinity,
          height: 60,
          margin:  const EdgeInsets.symmetric(horizontal: 12, vertical: 40),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: Text(
              'Place Order',
              style: Theme.of(context).textTheme.button,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headerWidget(context),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              color: Theme.of(context).primaryColorLight,
              child: Text(
                'Deliver to',
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                       Padding(
                        padding:
                           const  EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                        child: SvgPicture.asset(
                          'assets/icons/location_fill.svg',
                          height: 30,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Rifqi Arkaanul',
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          Text(
                            'Cirebon, West Java, Indonesia',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ],
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) =>  const AddressSetupPage(),
                        ),
                      );
                    },
                    child: SvgPicture.asset(
                      'assets/icons/next.svg',
                      height: 30,
                      color: const Color(0xFFA8A8A8),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                         padding:
                           const  EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                        child: SvgPicture.asset(
                          'assets/icons/bike.svg',
                          height: 30,
                          color: const Color(0xFFFF9314),
                        ),
                      ),
                       const SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Delivery',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ],
                  ),
                  Text(
                    'Change Options',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              color: Theme.of(context).primaryColorLight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order Summary',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) =>  const MainScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Add Items',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  for (final productCart in user.cart ?? [])
                    // tileWidget(productCart['product'], productCart['quantity']),
                    tileWidget(Product.fromMap(productCart['product']),
                        productCart['quantity']),
                  /*tileWidget(
                        productCart['product']['image'],
                        productCart['product']['name'],
                        //  'assets/images/3.jpeg',
                        // 'KFC Coffee - Kartini Street',
                        '${productCart['quantity']} Items', // '2 Items'
                        productCart['quantity']),
                 
                  ListView.builder(
                    itemCount: user.cart.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return CartProduct(
                        index: index,
                      );
                    },
                  ),*/
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Container(
                color: Theme.of(context).dividerColor,
                height: 1,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Subtotal',
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: const Color(0xFFFF9314),
                        ),
                  ),
                  Text(
                    // '\$5.00',
                    '\DT $sum ',
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: const Color(0xFFFF9314),
                        ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Delivery Fee',
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: const Color(0xFFFF9314),
                        ),
                  ),
                  Text(
                    '\$5.00',
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: const Color(0xFFFF9314),
                        ),
                  ),
                ],
              ),
            ),
            const  SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              color: Theme.of(context).primaryColorLight,
              child: Text(
                'Payment Details',
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              color: Theme.of(context).primaryColorLight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Payment Details',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) =>  const PaymentMethodPage(),
                        ),
                      );
                    },
                    child: Text(
                      'change',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding:
                            const  EdgeInsets.symmetric(horizontal: 16, vertical: 3),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFFFF9314),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          '\$',
                          style:
                              Theme.of(context).textTheme.headline3!.copyWith(
                                    color: const Color(0xFFFF9314),
                                  ),
                        ),
                      ),
                      const  SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Cash',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ],
                  ),
                  Text(
                    'Add a Promo',
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: const Color(0xFFFF9314),
                        ),
                  ),
                  /*  ApplePayButton(
                    width: double.infinity,
                    style: ApplePayButtonStyle.whiteOutline,
                    type: ApplePayButtonType.buy,
                    paymentConfigurationAsset: 'applepay.json',
                    onPaymentResult: onApplePayResult,
                    paymentItems: paymentItems,
                    margin: const EdgeInsets.only(top: 15),
                    height: 50,
                    onPressed: () => payPressed('address'),
                  ),
                  const SizedBox(height: 10),
                  GooglePayButton(
                    onPressed: () => payPressed('address'),
                    paymentConfigurationAsset: 'gpay.json',
                    onPaymentResult: onGooglePayResult,
                    paymentItems: paymentItems,
                    height: 50,
                   // style: GooglePayButtonStyle.black,
                    type: GooglePayButtonType.buy,
                    margin: const EdgeInsets.only(top: 15),
                    loadingIndicator: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                */
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget tileWidget(
    Product product,
    int quantity,
  ) {
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
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(
                      product.image,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const  SizedBox(
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
                        product.name,
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ],
                  ),
                  const  SizedBox(
                    height: 05,
                  ),
                  Text( 
                    '${quantity}Items', // quantity.toString() + 'Items', 
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
              const Spacer(),
              InkWell(
                child: Text(
                  'Edit',
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                        color: const Color(0xFFFF9314),
                      ),
                ),
                onTap: () {
                  //print(' on tap Edit order ');
                },
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black12,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.black12,
                  ),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () => decreaseQuantity(product),
                        child: Container(
                          width: 35,
                          height: 32,
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.remove,
                            size: 18,
                          ),
                        ),
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12, width: 1.5),
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: Container(
                          width: 35,
                          height: 32,
                          alignment: Alignment.center,
                          child: Text(
                            quantity.toString(),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => increaseQuantity(product),
                        child: Container(
                          width: 35,
                          height: 32,
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.add,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget headerWidget(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 90,
        ),
        Positioned(
          right: 0,
          top: 50,
          left: 0,
          child: Column(
            children: [
              Text(
                'Starbucks - CSB Mall',
                style: Theme.of(context).textTheme.headline3,
              ),
              Text(
                'Distance from you: 1.2 km',
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
        ),
        Positioned(
          top: 55,
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
