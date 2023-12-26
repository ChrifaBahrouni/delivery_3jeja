import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "../widgets/button.dart";
import "../widgets/text_field.dart";

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
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
                  height: 35,
                ),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.asset(
                      Theme.of(context).brightness == Brightness.light
                          ? 'assets/logo.png'
                          : 'assets/logo_dark.png',
                    ),
                  ),
                ),
                const  SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Forgot Password'.toUpperCase(),
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'We’ll send a password reset\n link to your email.',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF7D7D7D),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const  SizedBox(
                  height: 25,
                ),
               
                CustomTextFieldWidget(
                  hintText: 'example@gmail.com',
                  isPasswordField: false,
                  controller: _emailController,
                  label: "Email ",
                  typeinput: TextInputType.emailAddress,
                  validator: (value) {
                    if (value != null) {
                      if (value.contains('@') && value.endsWith('.com') ||
                          value.endsWith('.fr')) {
                        return null;
                      }
                      return 'Enter a Valid Email Address';
                    }
                    return null;
                  },
                ),
                const  SizedBox(
                  height: 35,
                ),
                ButtonWidget(
                  text: 'Reset Password',
                  onTap: () => {
                    if (formKey.currentState!.validate())
                      print('Form ok ')
                    else
                      print(" Form Not ok ")
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
