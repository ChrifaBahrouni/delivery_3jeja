import "package:flutter/material.dart";

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Text(
            'Transactions',
            style: Theme.of(context).textTheme.headline3,
          ),
          tileWidget(
            context,
            'assets/images/2.jpeg',
            'Starbucks - CSB Mall',
            '2 Items',
            '28, July 2021',
          ),
          tileWidget(
            context,
            'assets/images/3.jpeg',
            'KFC Coffee - Kartini Street',
            '2 Items',
            '28, July 2021',
          ),
          tileWidget(
            context,
            'assets/images/1.jpeg',
            'Semasa Coffee',
            '2 Items',
            '28, July 2021',
          ),
        ],
      ),
    );
 
  }
   Widget tileWidget(BuildContext context, String image, String title,
      String items, String date) {
    return Container(
      height: 120,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).primaryColorLight,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blue,
              image: DecorationImage(
                image: AssetImage(
                  image,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const  SizedBox(
            width: 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headline3!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              Text(
                items,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const Spacer(),
              Text(
                'Reorder',
                style: Theme.of(context).textTheme.headline5,
              ),
            ],
          ),
          const Spacer(),
          Expanded(
            child: Column(
              children: [
                 const SizedBox(
                  height: 5,
                ),
                Text(
                  date,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}