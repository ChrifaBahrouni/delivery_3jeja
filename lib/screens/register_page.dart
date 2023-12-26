
import "package:delivery_3jeja/screens/login_page.dart";
import "package:delivery_3jeja/services/auth_service.dart";
import "package:flutter/material.dart";
import "../widgets/button.dart";
import "../widgets/text_field.dart";
import "login_page.dart";

class RegisterPage extends StatefulWidget {
  static const String routeName = '/regsiter-screen';
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AuthService authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
  }

  void signUpUser() {
    authService.signUpUser(
        context: context,
        email: _emailController.text,
        password: _passwordController.text,
        name: _nameController.text,
        phone: int.parse(_phoneController.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding:  const EdgeInsets.symmetric(vertical: 25, horizontal: 12),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const  SizedBox(
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
                const  SizedBox(
                  height: 5,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Register'.toUpperCase(),
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                 const SizedBox(
                  height: 25,
                ),
                /*Text(
                  'Full Name',
                  style: Theme.of(context).textTheme.headline6,
                ),*/
                CustomTextFieldWidget(
                  label: "Nom",
                  hintText: 'Jason Ranti',
                  isPasswordField: false,
                  typeinput: TextInputType.text,
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
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
                /*Text(
                  'Email',
                  style: Theme.of(context).textTheme.headline6,
                ),*/
                CustomTextFieldWidget(
                  label: "Email ",
                  hintText: 'example@gmail.com',
                  isPasswordField: false,
                  controller: _emailController,
                  typeinput: TextInputType.emailAddress,
                  validator: (value) {
                    if (value != null) {
                      if (value.contains('@') && value.endsWith('.com') ||
                          value.endsWith('.fr')) {
                        return null;
                      }
                      return 'Email incorrect ';
                    }
                    return null;
                  },
                ),
                const  SizedBox(
                  height: 18,
                ),
                /*  Text(
                  'Phone Number',
                  style: Theme.of(context).textTheme.headline6,
                ),*/
                CustomTextFieldWidget(
                    hintText: '+216 99 828 278 ',
                    isPasswordField: false,
                    controller: _phoneController,
                    label: "Phone",
                    typeinput: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.length == 0) {
                        return "phone est obligatoire ";
                      }
                      if (value.length != 8) {
                        return " Phone  incorrect : taile  8 chiffre ";
                      }
                      return null;
                    }),
               const   SizedBox(
                  height: 18,
                ),
                /* Text(
                  'Password',
                  style: Theme.of(context).textTheme.headline6,
                ),*/
                CustomTextFieldWidget(
                  hintText: '********',
                  label: "Password",
                  isPasswordField: true,
                  typeinput: TextInputType.text,
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return " Password est obligatoire ";
                    }
                    if (value.length < 6) {
                      return " Password doit être plus de 6 caratéres ";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 35,
                ),
                ButtonWidget(
                  text: 'Register',
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      print(" form ok");
                      signUpUser();
                    } else {
                      print(" form not ok ");
                    }
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const Login_page(),
                      ),
                    );
                  },
                  child: Align(
                    alignment: Alignment.center,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Already have an account? ',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          TextSpan(
                            text: 'Login ',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
