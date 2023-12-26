import 'package:delivery_3jeja/screens/forgot_password_page.dart';

import 'package:delivery_3jeja/screens/register_page.dart';
import "package:flutter/material.dart";

import 'package:flutter_svg/flutter_svg.dart';

import '../services/auth_service.dart';
import '../widgets/button.dart';
import '../widgets/text_field.dart';


class _Login_pageState extends State<Login_page> {
  final AuthService authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void signInUser() {
    authService.signInUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const  EdgeInsets.symmetric(vertical: 25, horizontal: 12),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 300,
                    height: 200,
                    child: Image.asset(
                      Theme.of(context).brightness == Brightness.light
                          ? 'assets/logo.png'
                          : 'assets/logo_dark.png',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'LOGIN',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                 const SizedBox(
                  height: 25,
                ),
                Text(
                  'Email',
                  style: Theme.of(context).textTheme.headline6,
                ),
                CustomTextFieldWidget(
                  hintText: 'example@gmail.com',
                  isPasswordField: false,
                  //label: "Email",
                  typeinput: TextInputType.emailAddress,
                  controller: _emailController,
                  validator: (value ) {
                    if (value != null) {
                      if (value.contains('@') && value.endsWith('.com') ||
                          value.endsWith('.fr')) {
                        return null;
                      }
                      return 'Enter a Valid Email Address ';
                    }
                    return null;
                  },
                ),
                 const SizedBox(
                  height: 28,
                ),
                Text(
                  'Password',
                  style: Theme.of(context).textTheme.headline6,
                ),
                CustomTextFieldWidget(
                    hintText: '********',
                    controller: _passwordController,
                    isPasswordField: true,
                    // label: "password ",
                    typeinput: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password  est obligatoire ";
                      }
                      if (value.length < 6) {
                        return "Password  doit être plus de 6 caracteré ";
                      }

                      return null;
                    }),
                const SizedBox(
                  height: 8,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ForgotPasswordPage(),
                      ),
                    );
                  },
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Forgot Password ?',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                ButtonWidget(
                  text: 'login',
                  onTap: () => {
                    if (formKey.currentState!.validate())
                      {print('Form ok '), signInUser()}
                    else
                      print(" Form Not ok ")
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const RegisterPage(),
                      ),
                    );
                  },
                  child: Align(
                    alignment: Alignment.center,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Don’t have an account? ',
                            style:
                                Theme.of(context).textTheme.headline6!.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                          TextSpan(
                            text: 'Register ',
                            style:
                                Theme.of(context).textTheme.headline5!.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 1,
                      width: 135,
                      color: Theme.of(context).dividerColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'or'.toUpperCase(),
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                    Container(
                      height: 1,
                      width: 135,
                      color: Theme.of(context).dividerColor,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    socialButton(context, 'assets/icons/google_logo.svg'),
                    socialButton(context, 'assets/icons/facebook_logo.svg'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget socialButton(BuildContext context, String asset) {
    return Container(
      padding: const EdgeInsets.all(22),
      height: 70,
      width: 70,
      decoration: BoxDecoration(
        color: Theme.of(context).shadowColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).primaryColorDark,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: SvgPicture.asset(asset),
    );
  }
}

class Login_page extends StatefulWidget {
  const Login_page({super.key});
  static const String routeName = '/login-screen';
  @override
  State<Login_page> createState() => _Login_pageState();
}
