import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:delivery_3jeja/config/utils.dart';
import 'package:delivery_3jeja/models/categorie.dart';
import 'package:delivery_3jeja/widgets/text_custom.dart';
import 'package:dotted_border/dotted_border.dart';

import 'package:flutter/material.dart';
import '../../../config/global_variables.dart';
import '../../../widgets/text_field.dart';
import '../services/partenaire_services.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = '/add-product';
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {

  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  
  final PartenaireServices partenaireServices = PartenaireServices();
   List<Categorie>? categories ; 
 
  //late File image = File(''); // or initialize it to null
  final _addProductFormKey = GlobalKey<FormState>();
  String category = 'Pizza';
  List<File> images = []; 
 
  @override
  void dispose() {
    super.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
  }

// get all categories
 void fetchcategory() async {
    categories = await partenaireServices.fetchcatgoriesbymagasin(context: context) ; 
     
  }
  List<String> productCategories = [
    'Pizza',
    'Ma9loub',
    'Sindwich',
      'Salade',
  ];

  void addProduct() {
    if (_addProductFormKey.currentState!.validate()) {
   
      partenaireServices.addProduct(
        context: context,
        name: productNameController.text,
        description: descriptionController.text,
        price: double.parse(priceController.text),
        quantity: double.parse(quantityController.text),
        category: category,
        image:images[0] ,
         //image: null,
      );
    }
  }

 void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }
  @override
  void initState() {
    super.initState();
    fetchcategory() ; 
  }
 
  @override
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
          title: const Text(
            'Add Product',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          centerTitle:  true  , 
           elevation:  0 ,
            actions: [
          TextButton(
              onPressed: () {
                if (_addProductFormKey.currentState!.validate()) {
                  partenaireServices.addProduct(context: context, name: productNameController.text,
        description: descriptionController.text,
        price: double.parse(priceController.text),
        quantity: double.parse(quantityController.text),
        category: category,
        image:images[0] , ) ;
                   }
              },
              child: const TextCustom(text: 'Save', color: Colors.black))
        ], 
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _addProductFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                const SizedBox(height: 20),

                  images.isNotEmpty
                
                    ? CarouselSlider(
                        items: images.map(
                          (i) {
                            return Builder(
                              builder: (BuildContext context) => Image.file(
                                i,
                                fit: BoxFit.cover,
                                height: 200,
                              ),
                            );
                          },
                        ).toList(),
                        options: CarouselOptions(
                          viewportFraction: 1,
                          height: 200,
                        ),
                      )
                    : 
                
               /* image != null
                    ? Image.file(
                        image,
                        fit: BoxFit.cover,
                        height: 150,
                      )*/
                    
                    GestureDetector(
                        onTap: selectImages,
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(10),
                          dashPattern: const [10, 4],
                          strokeCap: StrokeCap.round,
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.folder_open,
                                  size: 40,
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  'Select Product Images',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                const SizedBox(height: 30),
                CustomTextFieldWidget(
                  controller: productNameController,
                  isPasswordField: false,
                  hintText: 'Product Name',
                  label: "Nom porduit ",
                  typeinput: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nom produit obligatoire ';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                CustomTextFieldWidget(
                  controller: descriptionController,
                  hintText: 'Description',
                  isPasswordField: false,
                  typeinput: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return " Description est obligatoire ";
                    }
                    return null;
                  },
                  //maxLines: 7,
                ),
                const SizedBox(height: 10),
                CustomTextFieldWidget(
                  controller: priceController,
                  label: " Prix ",
                  hintText: '5.00',
                  typeinput: TextInputType.number,
                  isPasswordField: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return " prix  est obligatoire ";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                CustomTextFieldWidget(
                  controller: quantityController,
                  hintText: 'Quantity',
                  label: " Quantite ",
                  isPasswordField: false,
                  typeinput: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return " Quantite  est obligatoire ";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                    value: category,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: productCategories.map((String item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (String? newVal) {
                      setState(() {
                        category = newVal!;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 10),
               /* ButtonWidget(
                  text: 'Ajouter produit ',
                  onTap: () {
                    if (_addProductFormKey.currentState!.validate()) {
                    
                      addProduct;
                        print("form ok ");
                    } else
                      print("form not ok ");
                  },
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
