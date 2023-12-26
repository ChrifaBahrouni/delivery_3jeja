import 'package:carousel_slider/carousel_slider.dart';
import "package:dotted_border/dotted_border.dart";
import 'package:delivery_3jeja/config/utils.dart';
import "package:delivery_3jeja/services/auth_service.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";
import '../../providers/user_provider.dart';
import '../../widgets/button.dart';
import '../../widgets/text_field.dart';
import 'dart:io';
class EditProfilePage extends StatefulWidget {
  static const String routeName = '/editprofile-screen';
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final AuthService authService = AuthService();
  
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

List<File> images = [];

 void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res ; 
    });
  }

 @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
  }

  Future<void> updateprofile() async {
    authService.UpdateUser(
      context: context,
      avatar: images[0] ,  // selectedImage != null ? selectedImage!.path : "",
      phone: int.parse(_phoneController.text),
      name: _nameController.text,
    );
  }

 
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 12),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
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
                GestureDetector(
                  onTap: selectImages, // selectImage,
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
                          Container(
                            height: 100.0,
                            width: 100.0,
                            child:  images.isEmpty
                                ? const Icon(
                                    Icons.folder_open,
                                    size: 40,
                                  )
                                : Image.network(user.avatar),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            'Select Image',
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
                //:
                /* Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.network(user.avatar
                        //'assets/images/profile_picture.png',
                        ),
                  ),
                ),*/
                /* Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.asset(
                      /*Theme.of(context).brightness == Brightness.light
                          ? 'assets/icons/logo.svg'
                          : 'assets/icons/logo_dark.svg',*/
                      'assets/images/profile_picture.png',
                    ),
                  ),
                ),*/
                
                const SizedBox(
                  height: 25,
                ),
                Text(
                  'Nom ',
                  style: Theme.of(context).textTheme.headline6,
                ),
                CustomTextFieldWidget(
                  hintText: user.name, //'Jason Ranti',
                  isPasswordField: false,
                  controller: _nameController,
                  label: user.name, // "Nom ",
                  typeinput: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.length == 0) {
                      return " Nom  est obligatoire ";
                    }
                    if (value.length < 6) {
                      return "Nom  doit être plus de 6 caractéres";
                    }

                    return null;
                  },
                ),
                const SizedBox(
                  height: 18,
                ),

                Text(
                  'Téléphone ',
                  style: Theme.of(context).textTheme.headline6,
                ),
                CustomTextFieldWidget(
                  hintText: user.phone.toString(),
                  isPasswordField: false,
                  controller: _phoneController,
                  label: user.phone.toString(),
                  typeinput: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "phone est obligatoire ";
                    }
                    if (value.length != 8) {
                      return " Phone  incorrect : taile  8 chiffre ";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 18,
                ),
                const SizedBox(
                  height: 35,
                ),
                ButtonWidget(
                  text: 'Modifier',
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                     // print(" form is ok ");
                      updateprofile();
                    } else {
                      print("form not ok ");
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
