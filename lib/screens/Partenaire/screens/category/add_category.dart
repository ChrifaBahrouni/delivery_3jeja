import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:delivery_3jeja/config/utils.dart';
import 'package:delivery_3jeja/models/categorie.dart';
import 'package:delivery_3jeja/screens/Partenaire/services/partenaire_services.dart';
import 'package:delivery_3jeja/widgets/text_custom.dart';
import 'package:delivery_3jeja/widgets/text_field.dart';
import 'package:dotted_border/dotted_border.dart';

import 'package:flutter/material.dart';

class AddCategoryScreen extends StatefulWidget {
  static const String routeName = '/add-category';
  const AddCategoryScreen({Key? key}) : super(key: key);

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final TextEditingController _nameController = TextEditingController();
  final PartenaireServices partenaireServices = PartenaireServices();

  late File image = File(''); // or initialize it to null
  final _formKey = GlobalKey<FormState>();
  List<File> images = [];
  String category = 'Aucune';
  List<String> productCategories = [
    'Aucune' , 
    'Pizza',
    'Ma9loub',
    'Sindwich',
      'Salade',
      
  ]; 
 List<Categorie>? categories ; 
  // get all categories
 void fetchcategory() async {
    categories = await partenaireServices.fetchcatgoriesbymagasin(context: context) ; 
     
  } 

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }

@override
  void initState() {
    super.initState();
    fetchcategory() ; 
  }
  void addCategory() {
    if (_formKey.currentState!.validate()) {

       partenaireServices.addCategory(
        context: context,
        name: _nameController.text,
        image: images[0],
      );
    }
  }

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res ; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const TextCustom(text: 'Add Category'),
        centerTitle: true,
        leadingWidth: 80,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.arrow_back_ios_new_rounded,
                  color: Colors.red, size: 17),
              TextCustom(text: 'Back', fontSize: 17, color: Colors.red)
            ],
          ),
        ),
        elevation: 0,
        actions: [
          TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  partenaireServices.addCategory(context: context, name: _nameController.text, image: images[0]) ;
                  }
              },
              child: const TextCustom(text: 'Save', color: Colors.black))
        ],
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                                'Select category  Image',
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
              const SizedBox(height: 20.0),
              const TextCustom(text: 'Category name'),
              const SizedBox(height: 5.0),
              CustomTextFieldWidget(
                controller: _nameController,
                hintText: 'Drinks',
                validator: (value) {
                  if (value != null) {
                    if (value.isEmpty) {
                      return 'Category name is required';
                    }
                  }
                  return null;
                },
                isPasswordField: false,
              ),
              const SizedBox(height: 25.0),
              
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
            ],
          ),
        ),
      ),
    );
  }
}
