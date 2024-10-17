import 'package:flutter/material.dart';

class CurrencyCard extends StatelessWidget {
  final String fromCurrency;
  final String toCurrency;
  final VoidCallback onTap;

  const CurrencyCard(
      {super.key,
      required this.fromCurrency,
      required this.toCurrency,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('$fromCurrency / $toCurrency',
                  style: const TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}
