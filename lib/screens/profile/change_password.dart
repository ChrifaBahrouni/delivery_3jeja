import "package:delivery_3jeja/services/auth_service.dart";
import 'package:delivery_3jeja/widgets/text_custom.dart';
import "package:flutter/material.dart";
import "package:provider/provider.dart";

import '../../providers/user_provider.dart';

import '../../widgets/text_field.dart';

class ChangePasswordPage extends StatefulWidget {
  static const String routeName = '/editpassword-screen';
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final AuthService authService = AuthService();
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();

    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _repeatPasswordController.dispose();
  }

  void changerpassword() {
    /*authService.UpdateUser(
      context: context,
      avatar: selectedImage != null ? selectedImage!.path : "",
      phone: int.parse(_phoneController.text),
      name: _nameController.text,
    );*/
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        /*  leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Change password '),*/

        backgroundColor: Colors.blue,
        elevation: 0,
        title: const TextCustom(text: 'Change Password'),
        centerTitle: true,
        leadingWidth: 80,
        leading: TextButton(
            onPressed: () => Navigator.pop(context),
            child: const TextCustom(
                text: 'Cancel', fontSize: 17, color: Colors.white)),
        actions: [
          TextButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  // userBloc.add( OnChangePasswordEvent(_currentPasswordController.text, _newPasswordController.text) );
                }
              },
              child: const TextCustom(
                  text: 'Save', fontSize: 16, color: Colors.white))
        ],
      ),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20.0),
                const TextCustom(text: 'Current Password'),
                const SizedBox(height: 5.0),
                CustomTextFieldWidget(
                  controller: _currentPasswordController,
                  isPasswordField: true,
                  validator: (value) {},
                  hintText: 'password ',
                ),
                const SizedBox(height: 20.0),
                const TextCustom(text: 'New Password'),
                const SizedBox(height: 5.0),
                CustomTextFieldWidget(
                  controller: _newPasswordController,
                  isPasswordField: true,
                  // isPassword: state.isNewPassword,
                  /* suffixIcon: IconButton(
                          splashRadius: 20,
                          icon: state.isNewPassword ? Icon(Icons.remove_red_eye_outlined) : Icon(Icons.visibility_off_rounded) ,
                          onPressed: () {
                    
                            bool isShowPassword =! generalBloc.state.isNewPassword;
                            generalBloc.add( OnShowOrHideNewPasswordEvent(isShowPassword) );
                    
                          }
                        ),
                        */
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return "password est obligatoire ";
                    if (value.length < 6) return " password  : taile min 6";
                    return null;
                  },
                  hintText: 'password ',
                ),
                const SizedBox(height: 20.0),
                const TextCustom(text: 'Repeat Password'),
                const SizedBox(height: 5.0),
                CustomTextFieldWidget(
                  controller: _repeatPasswordController,
                  isPasswordField: true,
                  validator: (val) {
                    if (val != _newPasswordController.text) {
                      return 'Passwords do not match';
                    } else {
                      return 'Repeat password is required';
                    }
                  },
                  hintText: 'Repeat password',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
