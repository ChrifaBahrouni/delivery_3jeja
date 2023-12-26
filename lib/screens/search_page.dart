import "package:delivery_3jeja/services/home_services.dart";
import "package:delivery_3jeja/services/search_services.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:google_fonts/google_fonts.dart";

import "../models/product.dart";

class SearchPage extends StatefulWidget {
  static const String routeName = '/search-screen';
  final String searchQuery;
  const SearchPage({
    Key? key,
    required this.searchQuery,
  }) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Product>? products;
  final SearchServices searchServices = SearchServices();
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchSearchedProduct();
  }

  /*fetchSearchedcategory() async {
    products = await homeServices.(
        context: context, searchQuery: widget.searchQuery);
    setState(() {});
  }*/
  fetchSearchedProduct() async {
    products = await searchServices.fetchSearchedProduct(
        context: context, searchQuery: widget.searchQuery);
    setState(() {});
  }

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchPage.routeName, arguments: query);
  }

  final List<String> chipsList = [
    'Hot Coffee',
    'Iced Coffee',
    'Salads',
    'Burger',
    'Sandwich',
    'Pizza',
  ];
  final List<String> historyList = [
    'Hot Coffee',
    'Iced Coffee',
    'Salads',
    'Burger',
    'Sandwich',
    'Pizza',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 25,
          ),
          child: Column(
            children: [
              Text(
                'Search',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF2D2D2D),
                ),
              ),
               const SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorLight,
                  border: Border.all(
                    color: Theme.of(context).primaryColorDark,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  cursorColor: const Color(0xFF151624),
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).textTheme.headline6!.color,
                    ),
                    border: InputBorder.none,
                    filled: true,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        'assets/icons/search.svg',
                      ),
                    ),
                    fillColor: Theme.of(context).primaryColorLight,
                  ),
                ),
              ),
              const  SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 6,
                  clipBehavior: Clip.hardEdge,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Chip(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    backgroundColor: Theme.of(context).primaryColorLight,
                    label: Text(
                      chipsList[index],
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
              ),
               const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'RECENT',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Text(
                    'Clear All',
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: const Color(0xFF2FDBBC),
                        ),
                  ),
                ],
              ),
               const SizedBox(
                height: 10,
              ),
              historyWidget(context, 'Coffee'),
              historyWidget(context, 'Burger'),
              historyWidget(context, 'Iced Coffee'),
              historyWidget(context, 'Tuna'),
              historyWidget(context, 'Macchiato Short'),
              historyWidget(context, 'Caramel Machiato'),
              const Spacer(
                flex: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget historyWidget(BuildContext context, String title) {
    return Container(
      padding:  const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/history.svg',
            width: 20,
            height: 20,
          ),
           const SizedBox(
            width: 15,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.headline6,
          ),
          const Spacer(),
          const Icon(
            Icons.close,
            color: Color(0xFFA3A3A3),
          ),
        ],
      ),
    );
  }
}
