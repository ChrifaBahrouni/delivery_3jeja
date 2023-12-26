import "package:flutter/material.dart";

class CustomText extends StatelessWidget {
  /// docummentation classe
  ///  hint hint
  const CustomText(
      {super.key,
      required this.controller,
      this.label = '',
      this.hint = '',
      this.typeinput = TextInputType.text,
      this.uneIcon = Icons.production_quantity_limits,
      this.valide});

  final String label;
  final String hint;
  final IconData uneIcon;
  final TextInputType? typeinput;
  final String? Function(String?)? valide;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
            child: Container(
          //padding:  EdgeInsets.only(top: 14.0 ),
          width: MediaQuery.of(context).size.width * 0.8, //340.0,
          child: TextFormField(
            controller: controller,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              //  fontSize: 20, color: Colors.blue
            ),
            keyboardType: typeinput,
            decoration: InputDecoration(
              label: Text(label),
              labelStyle: TextStyle(
                fontSize: 18,
                color: Theme.of(context).primaryColor, // Colors.pink,
              ),
              hintText: hint, // " Donnez-vous code de l'article  ",
              hintStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).textTheme.headline6!.color,
              ),
              // icon: Icon(Icons.add),
              //prefixIcon: Icon(Icons.production_quantity_limits),
              // prefixIconColor: Colors.green,
              fillColor: Theme.of(context).primaryColorLight,
              filled: true,
              errorStyle: const TextStyle(fontSize: 8),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(24.0)),
            ),
            validator: valide,
          ),
        )),
        const Padding(padding: EdgeInsets.only(bottom: 14)),
      ],
    );
  }
}
