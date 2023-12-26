import "package:delivery_3jeja/screens/Partenaire/services/partenaire_services.dart";
import "package:delivery_3jeja/services/auth_service.dart";
import "package:delivery_3jeja/widgets/button.dart";
import "package:flutter/material.dart";
import "../widgets/text_field.dart";

class PartnerPage extends StatefulWidget {
  static const String routeName = '/partner-screen';
  const PartnerPage({super.key});

  @override
  State<PartnerPage> createState() => _PartnerPageState();
}

class _PartnerPageState extends State<PartnerPage> {
  int _currentStep = 0;
  final AuthService authService = AuthService();
  final _addPartnerFormKey = GlobalKey<FormState>();

  final TextEditingController _Raison_socialeController =
      TextEditingController();
  final TextEditingController _nom_etabController = TextEditingController();
  final TextEditingController _cinController = TextEditingController();
  final TextEditingController _instagramController = TextEditingController();
  final TextEditingController _whatsappController = TextEditingController();
  final TextEditingController _facebookController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _itemsController = TextEditingController();
  final TextEditingController _frais_livraisonController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();
  final PartenaireServices partenaireServices = PartenaireServices();
  String type = 'Fast Food';

  List<String> partenairetypes = [
    'Fast Food',
    'Restaurant',
    'Magasin',
  ];

  void devenir_partenaire() {
    if (_addPartnerFormKey.currentState!.validate()) {
    /*  partenaireServices.Devenir_Partenaire(
        context: context,
        raison: _Raison_socialeController.text,
        nom_etab: _nom_etabController.text,
        cin: _cinController.text,
        instagram: _instagramController.text,
        type: type,
        whatsapp: _instagramController.text,
        facebook: _facebookController.text,
        items: _itemsController.text,
        frais_livraison: _frais_livraisonController.text,
      );
   */ } else {
      print(" form not ok ");
    }
  }

  @override
  void initState() {
    super.initState();
    // ... Initialisez les autres contrôleurs
  }

  @override
  void dispose() {
    super.dispose();
    _Raison_socialeController.dispose();
    _nom_etabController.dispose();
    _instagramController.dispose();
    _facebookController.dispose();
    _cinController.dispose();
    _typeController.dispose();
    _whatsappController.dispose();
    _itemsController.dispose();
    _frais_livraisonController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: const Text('Devenir partenaire'),
        ),
        body: Form(
          key: _addPartnerFormKey,
          child: Stepper(
            currentStep: _currentStep,
            onStepContinue: _currentStep < 1
                ? () {
                    setState(() {
                      _currentStep++;
                    });
                  }
                : null,
            onStepCancel: _currentStep > 0
                ? () {
                    setState(() {
                      _currentStep--;
                    });
                  }
                : null,
            type: StepperType.vertical,
            steps: [
              Step(
                title:
                    const Text("Information concernant votre établissement "),
                content: Column(
                  children: [
                    Text(
                      'Raison sociale ',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    CustomTextFieldWidget(
                      hintText: ' Raison Sociale ',
                      isPasswordField: false,
                      typeinput: TextInputType.text,
                      controller: _Raison_socialeController,
                      //label: "Raison Sociale",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return " Raison Sociale est obligatoire ";
                        }
                        return null;
                      },
                    ),
                    Text(
                      "nom d'établissement",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    CustomTextFieldWidget(
                      hintText: 'ARISCom ',
                      //   label: "nom d'établissement",
                      typeinput: TextInputType.text,
                      isPasswordField: false,
                      controller: _nom_etabController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Nom d'établissement est obligatoire ";
                        }
                        return null;
                      },
                    ),
                    Text(
                      "CIN ",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    CustomTextFieldWidget(
                      hintText: '12345678 ',
                      // label: "CIN ",
                      typeinput: TextInputType.number,
                      isPasswordField: false,
                      controller: _cinController,
                      validator: (value) {
                        if (value == null || value.length == 0)
                          return "CIN  est obligatoire ";
                        if (value.length != 8) return "CIN  : taille 8  ";
                        return null;
                      },
                    ),
                    Text(
                      "Type",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: DropdownButton(
                        value: type,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: partenairetypes.map((String item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (String? newVal) {
                          setState(() {
                            type = newVal!;
                          });
                        },
                      ),
                    ),
                    Text(
                      'items',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    CustomTextFieldWidget(
                      hintText: '10:00 AM - 17:00 AM ',
                      isPasswordField: false,
                      typeinput: TextInputType.text,
                      //label: "Items ",
                      controller: _itemsController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Items est obligatoire ";
                        }
                        return null;
                      },
                    ),
                    Text(
                      'Frais livraison ',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    CustomTextFieldWidget(
                      hintText: '5',
                      // label: "Frais livraison",
                      typeinput: TextInputType.number,
                      isPasswordField: false,
                      controller: _frais_livraisonController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Frais Livraison  est obligatoire  ";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              Step(
                title: const Text("Réseaux sociaux"),
                content: Column(
                  children: [
                    Text(
                      'whatsapp',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    CustomTextFieldWidget(
                      hintText: '+216 99 828 278 ',
                      isPasswordField: false,
                      controller: _whatsappController,
                      typeinput: TextInputType.number,
                    ),
                    Text(
                      'Facebook',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    CustomTextFieldWidget(
                      hintText: ' http://....',
                      isPasswordField: false,
                      typeinput: TextInputType.text,
                      controller: _facebookController,
                    ),
                    Text(
                      'Instagram',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    CustomTextFieldWidget(
                      hintText: ' http://....',
                      isPasswordField: false,
                      typeinput: TextInputType.text,
                      controller: _instagramController,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    ButtonWidget(
                      text: ' Devenir partenaire',
                      onTap: () {
                        if (_addPartnerFormKey.currentState!.validate()) {
                          print('form ok ');
                          devenir_partenaire();
                        } else {
                          print("form not ok ");
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
/*
List<Step> buildStep() {
  var _nameController;
  return [
    Step(
      title: const Text("Information  Personnelle"),
      content: Column(
        children: [
          Text(
            'Raison sociale ',
            //  style: Theme.of(context as BuildContext).textTheme.headline6,
          ),
          CustomTextFieldWidget(
            hintText: ' Rue Mouhamed el hamess n ° 05 ', //'Jason Ranti',
            isPasswordField: false,
            controller: _nameController,
          ),
          Text(
            "nom d'établissement",
            // style: Theme.of(context as BuildContext).textTheme.headline6,
          ),
          CustomTextFieldWidget(
            hintText: ' chrifa bahrouni', //user.name , //'Jason Ranti',
            isPasswordField: false,
            controller: _nameController,
          ),
        ],
      ),
    ),
    Step(
        title: Text("Information concernant votre établissement "),
        content: Container(
          height: 100,
          color: Colors.red,
        )),
    Step(
        title: Text("Réseau sociale "),
        content: Container(
          height: 100,
          color: Colors.red,
        )),
  ];
}
*/