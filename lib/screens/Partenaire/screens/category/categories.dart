
import 'package:delivery_3jeja/models/categorie.dart';
import 'package:delivery_3jeja/screens/Partenaire/screens/category/add_category.dart';
import 'package:delivery_3jeja/screens/Partenaire/services/partenaire_services.dart';
import 'package:delivery_3jeja/widgets/text_custom.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatefulWidget {
  static const String routeName = '/category';
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final PartenaireServices partenaireServices = PartenaireServices();
  List<Categorie>? listCategory;
 
  @override
  void dispose() {
    super.dispose();
    
  }

  @override
  void initState() {
    super.initState();
    getallcategoriesbypartenaire();
  }

// get all categories
  getallcategoriesbypartenaire() async {
    listCategory =
        await partenaireServices.fetchcatgoriesbymagasin(context: context);
    setState(() {});
  
  }
 

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const TextCustom(text: 'Listes Categories'),
        centerTitle: true,
        leadingWidth: 80,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child:  const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              Icon(Icons.arrow_back_ios_new_rounded,
                  color: Colors.red, size: 17),
              TextCustom(
                text: 'Back',
                fontSize: 17,
                color: Colors.red,
              )
            ],
          ),
        ),
        elevation: 0,
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>  const AddCategoryScreen(),
                  )),
              child: const TextCustom(
                  text: 'Add', color: Colors.black, fontSize: 17))
        ],
      ),
      body: 
            ListView.builder(
              itemCount: listCategory?.length,
           
              itemBuilder: (context, index) { 
              return  Card(
                  color:  Colors.orange ,
                   margin:   const EdgeInsets.all(15),
                  child :
                   
                  ListTile(
                 
                  title: Text(listCategory![index].name.toString() ),
                 //subtitle: Text(  listCategory![index].subcategories.toString())  , 
                  trailing: SizedBox(
                    width:  100,
                    child: Row(
                      children: [
                        IconButton(
                           color:  Colors.red,
                          icon : const Icon (Icons.delete),
                          onPressed: ()=> {
                           // print("delete ..") 
                          },
                        ) ,  
                      ],
                    ),

                  ),
                   

                  // You can customize the ListTile based on your Livre class properties
                ),
                )  ;  
              }) , 
     
    ) ;        
     /* FutureBuilder<List<Categorie>>(
        future: partenaireServices.fetchcatgoriesbymagasin(context: context),
        builder: (context, snapshot) => !snapshot.hasData
            ? Center(
                child: Row(
                  children: const [
                    CircularProgressIndicator(),
                    TextCustom(text: 'Loading Categories...')
                  ],
                ),
              )
            : ListView(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                physics: const BouncingScrollPhysics(),
                itemExtent: 50.0,
                // Replace 50.0 with your desired item height
                //  itemBuilder: (_, i) => cardcategorie(context),
              ),
      ),
    */
    
  
  }
}

Widget cardcategorie(BuildContext context, String category) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 15.0),
    child: Container(
      height: 55,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
          color: Colors.grey[100], borderRadius: BorderRadius.circular(10.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.0),
                border: Border.all(color: Colors.blue, width: 4.5)),
          ),
          const SizedBox(width: 20.0),
          TextCustom(text: category),
        ],
      ),
    ),
  );
}
