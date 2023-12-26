// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'package:delivery_3jeja/config/error_handling.dart';
import 'package:delivery_3jeja/config/global_variables.dart';
import 'package:delivery_3jeja/config/utils.dart';
import 'package:delivery_3jeja/models/categorie.dart';
import 'package:delivery_3jeja/models/order.dart';
import 'package:delivery_3jeja/models/product.dart';
import 'package:delivery_3jeja/providers/user_provider.dart';

import '../models/sales.dart';

class PartenaireServices {
 
  void addProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required File image,
    //required List<File> images,
  }) async {
    
    try {
     final cloudinary = CloudinaryPublic('deztsmo9g', 'rttteggd');
      String imageUrl = "";
    
      CloudinaryResponse res = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(image.path, folder: name),
      );
      imageUrl = res.secureUrl;
 final userProvider = Provider.of<UserProvider>(context, listen: false);
   
      Product product = Product(
        name: name,
        description: description,
        quantity: quantity,
        image: imageUrl,
        category: "6580b663d0fea940a4de0cf4",
        //subcategory: category,
        bayer:userProvider.user.id  , 
        price: price,
      );
      http.Response res1 = await http.post(
        Uri.parse('$uri/products/create'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: product.toJson(),
      );

      httpErrorHandle(
        response: res1,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Product Added Successfully!');
          Navigator.pop(context);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
  void addCategory({
    required BuildContext context,
    required String name,

    required File image,
  
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      //deztsmo9g
      //rttteggd
      final cloudinary = CloudinaryPublic('deztsmo9g', 'rttteggd');
      
      String imageUrl = "";
      
      CloudinaryResponse res = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(image.path, folder: name),
      );
      imageUrl = res.secureUrl;
      Categorie categ = Categorie( photo: imageUrl, name: name , bayer :userProvider.user.id ) ; 
  
      http.Response res1 = await http.post(
        Uri.parse('$uri/categories/create'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: categ.toJson(),
      );

      httpErrorHandle(
        response: res1,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Categorie Added Successfully!');
          Navigator.pop(context);
        },
      );
    } catch (e) {
      showSnackBar(context,e.toString());
    }
  }

  // get all the catgories  by id partenaire/ bayer

  Future<List<Categorie>> fetchcatgoriesbymagasin({
      required BuildContext context
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Categorie> catgoriesList = [];
    //String bayer = userProvider.user.id;

    try {
      http.Response res = await http
          .get(Uri.parse('$uri/categories/read'), headers: { // /?bayer=$bayer 
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            catgoriesList.add(
              Categorie.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return catgoriesList;
  }

  // get all the products by id partenaire/ bayer
  Future<List<Product>> fetchAllProductsBybayer(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    //String magasin = userProvider.user.id;
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/products/read'), headers: {
        //.get(Uri.parse('$uri/products/bybayer/?bayer=$magasin'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            productList.add(
              Product.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }

  void deleteProduct({
    required BuildContext context,
    required Product product,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.delete(
        Uri.parse('$uri/products/delete?id=$product.id'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id,
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          onSuccess();
          showSnackBar(context, "Prduit supprimer avec succées ");
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Order>> fetchAllOrders(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Order> orderList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/orders/read'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            orderList.add(
              Order.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return orderList;
  }

  void changeOrderStatus({
    required BuildContext context,
    required int status,
    required Order order,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/change-order-status'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': order.id,
          'status': status,
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: onSuccess,
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<Map<String, dynamic>> getEarnings(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Sales> sales = [];
    int totalEarning = 0;

    try {
      http.Response res =
          await http.get(Uri.parse('$uri/products/analytics'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          var response = jsonDecode(res.body);
          //  print("  responce analyses " + response);
          totalEarning = response['totalEarnings'];
          //  earnings = response['earnings'];
          /*for ( int i=0 ; i < response['earnings']   ;  i++;){
          
          }*/
          /* sales = [
            Sales('Mobiles', response['mobileEarnings']),
            Sales('Essentials', response['essentialEarnings']),
            Sales('Books', response['booksEarnings']),
            Sales('Appliances', response['applianceEarnings']),
            Sales('Fashion', response['fashionEarnings']),
          ];*/
          // Assuming that 'earnings' is an array, you can map it to the Sales model
          if (response['earnings'] is List) {
            sales = List<Sales>.from(response['earnings'].map((item) {
              // sales.add(Sales(item['subcategory'], item['earning']));
              return Sales(item['subcategory'], item['earning']);
            }));
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }

    return {
      'sales': sales,
      'totalEarnings': totalEarning,
    };
  }

 /* void Devenir_Partenaire({
    required BuildContext context,
    required String raison,
    required String nom_etab,
    required String cin,
    required String instagram,
    required String type,
    required String whatsapp,
    required String facebook,
    required String items,
    required String frais_livraison,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      Partenaire partenaire = Partenaire(
        nom_etab: nom_etab,
        Raison_sociale: raison,
        cin: cin,
        type: type,
        instagram: instagram,
        facebook: facebook,
        whatsapp: whatsapp,
        items: items,
        frais_livraison: frais_livraison,
      );
      http.Response res1 = await http.post(
        Uri.parse('$uri/bayers/create'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: partenaire.toJson(),
      );

      httpErrorHandle(
        response: res1,
        context: context,
        onSuccess: () {
          showSnackBar(
              context, 'Demande devenir partenaire  envyer avec succées ..');
          Navigator.pop(context);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

*/
}
