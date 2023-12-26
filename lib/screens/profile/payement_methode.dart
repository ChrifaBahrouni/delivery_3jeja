import 'package:flutter/material.dart';

class PaymentMethodPage extends StatefulWidget {
  const PaymentMethodPage({Key? key}) : super(key: key);

  @override
  _PaymentMethodPageState createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  String selectedPaymentMethod = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('Méthode de paiement '),
      ),
      body: Column(
        children: [
          RadioListTile(
            title: const Text('Credit Card'),
            value: 'Credit Card',
            groupValue: selectedPaymentMethod,
            onChanged: (value) {
              setState(() {
                selectedPaymentMethod = value.toString();
              });
            },
          ),
          RadioListTile(
            title: const Text('PayPal'),
            value: 'PayPal',
            groupValue: selectedPaymentMethod,
            onChanged: (value) {
              setState(() {
                selectedPaymentMethod = value.toString();
              });
            },
          ),
          RadioListTile(
            title: const Text('Google Pay'),
            value: 'Google Pay',
            groupValue: selectedPaymentMethod,
            onChanged: (value) {
              setState(() {
                selectedPaymentMethod = value.toString();
              });
            },
          ),
          RadioListTile(
            title: const Text('Cash on Delivery'),
            value: 'Cash on Delivery',
            groupValue: selectedPaymentMethod,
            onChanged: (value) {
              setState(() {
                selectedPaymentMethod = value.toString();
              });
            },
          ),
          ElevatedButton(
            onPressed: () {
              // Use the value of selectedPaymentMethod to perform an action
              if (selectedPaymentMethod.isNotEmpty) {
                print('Selected payment method: $selectedPaymentMethod');
              }
            },
            child: const Text('Validate'),
          ),
        ],
      ),
    );
  }
}
