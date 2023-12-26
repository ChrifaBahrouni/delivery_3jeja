import 'package:charts_flutter/flutter.dart' as charts;
import 'package:delivery_3jeja/screens/Partenaire/models/sales.dart';
import 'package:delivery_3jeja/screens/Partenaire/services/partenaire_services.dart';
import 'package:delivery_3jeja/widgets/loader.dart';


import 'package:flutter/material.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final PartenaireServices adminServices = PartenaireServices();
  int? totalSales;
  List<Sales>? earnings;

  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  getEarnings() async {
    var earningData = await adminServices.getEarnings(context);

    totalSales = earningData['totalEarnings'];
    earnings = [
      Sales('Pizza', 0),
      Sales('Sandwiches', 0),
      Sales('Salades', 217),
      Sales('Boissons Fraîches', 22),
      Sales('Bergers', 2),
    ];
    print(" data statis " + earningData['sales']);
    earningData['sales'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return earnings == null || totalSales == null
        ? const Loader()
        : Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(25.0),
              ),
              Text(
                '\$$totalSales',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 250,
                child: CategoryProductsChart(seriesList: [
                  charts.Series(
                    id: 'Sales',
                    data: earnings!,
                    domainFn: (Sales sales, _) => sales.label,
                    measureFn: (Sales sales, _) => sales.earning,
                  ),
                ]),
              )
            ],
          );
  }
}

class CategoryProductsChart extends StatelessWidget {
  final List<charts.Series<Sales, String>> seriesList;
  const CategoryProductsChart({
    Key? key,
    required this.seriesList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: true,
    );
  }
}
