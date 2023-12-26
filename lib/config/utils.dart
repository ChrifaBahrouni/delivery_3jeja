import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}
/*
Future<File?> pickImage() async {
 
  final cloudinary = Cloudinary.signedConfig(
  apiKey: "196881617344692",
  apiSecret: "WCVtHyWMEvCvmrUIR-Lugy_rxrQ",
  cloudName: "deztsmo9g",
);
 /*final cloudinary = Cloudinary.unsignedConfig(
    cloudName: "deztsmo9g",
  );*/
 try {
    var files = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (files != null && files.files.isNotEmpty) {
      File image = File(files.files[0].path!);

      // Upload the picked image to Cloudinary
      try {
      /*  final result = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(image.path),
          resourceType: CloudinaryResourceType.Image,
        );
*/
        // Perform any additional logic you need, such as saving the URL to your backend
       // print('Image uploaded to Cloudinary: ${result.secureUrl}');

        return image;
      } catch (e) {
        // Handle Cloudinary upload errors
        print('Error uploading image to Cloudinary: $e');
      }
    }
  } catch (e) {
    // Handle file picking errors
    print('Error picking image: $e');
  }

  return null;

}

*/
Future<List<File>> pickImages() async {

  List<File> images = [];
  try {
    var files = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );
    if (files != null && files.files.isNotEmpty) {
      for (int i = 0; i < files.files.length; i++) {
        images.add(File(files.files[i].path!));
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return images;
}
 