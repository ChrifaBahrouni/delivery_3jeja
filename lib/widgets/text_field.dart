import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFieldWidget extends StatefulWidget {
  final String hintText;
  final String label;
  final bool isPasswordField;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType? typeinput;

  const CustomTextFieldWidget({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.isPasswordField,
    this.label = "",
    this.validator,
    this.typeinput,
  }) : super(key: key);

  @override
  State<CustomTextFieldWidget> createState() => _CustomTextFieldWidgetState();
}

class _CustomTextFieldWidgetState extends State<CustomTextFieldWidget> {
  bool hidePassword = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9, //340.0,
      height: 50,
      // padding: const EdgeInsets.all(5),
      /* decoration: BoxDecoration(
        color: Theme.of(context).primaryColorLight,
        border: Border.all(
          color: Theme.of(context).primaryColorDark,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),*/
      child: TextFormField(
        controller:
            widget.controller, // Use widget.controller instead of controller
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        validator: widget.validator,
        obscureText: hidePassword,
        cursorColor: const Color(0xFF151624),
        keyboardType: widget.typeinput,

        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Theme.of(context).textTheme.headline6!.color,
          ),
          label: Text(widget.label),
          labelStyle: GoogleFonts.poppins(
            //fontSize: 14,
            fontSize: 18,
            color: Theme.of(context).primaryColor,
            // fontWeight: FontWeight.w400,
            // color: Theme.of(context).textTheme.headline6!.color,
          ),
          errorStyle: TextStyle(fontSize: 8),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24.0)), //InputBorder.none,
          filled: true,

          fillColor: Theme.of(context).primaryColorLight,

          suffixIcon: widget.isPasswordField
              ? IconButton(
                  icon: Icon(
                    hidePassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      hidePassword = !hidePassword;
                    });
                  },
                )
              : const SizedBox(),
        ),
      ),
    );
  }
}
