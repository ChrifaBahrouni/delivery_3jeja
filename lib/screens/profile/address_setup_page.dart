
import "package:flutter/material.dart";

class AddressSetupPage extends StatefulWidget {
  const AddressSetupPage({super.key});

  @override
  State<AddressSetupPage> createState() => _AddressSetupPageState();
}

class _AddressSetupPageState extends State<AddressSetupPage> {
  /*final TextEditingController _villeController = TextEditingController();
  final TextEditingController _rueController = TextEditingController();
  final TextEditingController _code_postalController = TextEditingController();
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon:  const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title:  const Text('Edit Address'),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const  EdgeInsets.symmetric(vertical: 25, horizontal: 12),
          child:  const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                SizedBox(
                height: 25 ,
              ),

             
               
              /*Align(
                alignment: Alignment.center,
                child: Text(
                  'Address Setup'.toUpperCase(),
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                'Rue ',
                style: Theme.of(context).textTheme.headline6,
              ),
              CustomTextFieldWidget(
                hintText: 'rue mouhamed  el 5amess',
                isPasswordField: false,
                controller: _rueController,
              ),
              const  SizedBox(
                height: 18,
              ),
              
              CustomTextFieldWidget(
                hintText: ' haffouz ** ',
                isPasswordField: false,
                controller: _villeController,
              ),
             const  SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /* Text(
                        ' Code,Postal  ',
                        style: Theme.of(context).textTheme.headline6,
                      ),*/
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.2,
                        child: CustomTextFieldWidget(
                          hintText: '3130',
                          label: "Code Postal",
                          isPasswordField: false,
                          typeinput: TextInputType.number,
                          controller: _code_postalController,
                          validator: (value) {

                          },
                        ),
                      ),
                    ],
                  ),
                  /*  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'City',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.2,
                        child: CustomTextFieldWidget(
                          hintText: '+62 8777 2221',
                          isPasswordField: false,
                          controller: _emailController,
                        ),
                      ),
                    ],
                  ),*/
                ],
              ),
              const  SizedBox(
                height: 18,
              ),
              const  SizedBox(
                height: 35,
              ),
             
             InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const login_page(),
                    ),
                  );
                },
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Skip for now',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ),
           */ ],
          ),
        ),
      ),
    );
  }
}
