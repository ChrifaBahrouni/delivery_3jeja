import 'dart:convert';

import 'package:delivery_3jeja/config/global_variables.dart';
import 'package:delivery_3jeja/models/brand.dart';
import 'package:delivery_3jeja/models/product.dart';
import 'package:delivery_3jeja/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../config/error_handling.dart';
import '../config/utils.dart';
import '../models/bayer.dart';

class HomeServices {
  Future<List<FastFood>> fetchFastFood({required BuildContext context
      // required String category,
      }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<FastFood> fastfoodList = [];
    try {
      http.Response res = await http
          //.get(Uri.parse('$uri/api/products?category=$category'), headers: {
          .get(Uri.parse('$uri/bayers/read'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            fastfoodList.add(
              FastFood.fromJson(
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
    return fastfoodList;
  }

  Future<List<Brand>> fetchBrands({required BuildContext context
      // required String category,
      }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Brand> BrandsList = [];
    try {
      http.Response res = await http
          //.get(Uri.parse('$uri/api/products?category=$category'), headers: {
          .get(Uri.parse('$uri/brands/read'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            BrandsList.add(
              Brand.fromJson(
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
    return BrandsList;
  }

  Future<List<Product>> fetchProduct({required BuildContext context
      // required String category,
      }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> ProduitsList = [];
    try {
      http.Response res = await http
          //.get(Uri.parse('$uri/api/products?category=$category'), headers: {
          .get(Uri.parse('$uri/products/read'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            ProduitsList.add(
              Product.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
          // showSnackBar(context, "produit list have data ");
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return ProduitsList;
  }

  Future<List<Product>> fetchProductbymagasin({
    required BuildContext context,
    required String magasin,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> ProduitsList1 = [];
    try {
      http.Response res = await http
          .get(Uri.parse('$uri/products/bybayer/?bayer=$magasin'), headers: {
        //.get(Uri.parse('$uri/api/brand/getall'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            ProduitsList1.add(
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
    return ProduitsList1;
  }

  Future<Product> fetchDealOfDay({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    Product product = Product(
      name: '',
      description: '',
      quantity: 0,
      image: '',
      category: '',
      bayer: '',
      price: 0,
    );

    try {
      http.Response res =
          await http.get(Uri.parse('$uri/products/deal-of-day'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          product = Product.fromJson(res.body);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return product;
  }

  Future<List<Brand>> fetchbrands({required BuildContext context}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Brand> frandsList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/brands/read'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            frandsList.add(
              Brand.fromJson(
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
    return frandsList;
  }

/*
 Future<FastFood> fetchFastFood({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    FastFood fast = FastFood(
      id: '',
      title: '',
      image: '',
      items: '',
      distance: '',
     
    );

    try {
      http.Response res =
          await http.get(Uri.parse('$uri/api/Fastfood'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          fast = FastFood.fromJson(res.body);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return fast;
  }
*/
}
