import 'package:flutter/material.dart';

class CurrencyFlagCard extends StatelessWidget {
  final String currencyCode;
  final double rate;
  final VoidCallback onTap;

  const CurrencyFlagCard(
      {super.key,
      required this.currencyCode,
      required this.rate,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: ListTile(
          leading: Image.asset(
            'flags/$currencyCode.gif', // Add flag images in assets/flags/
            width: 40,
          ),
          title: Text(currencyCode, style: const TextStyle(fontSize: 18)),
          subtitle: Text('1 GBP = $rate $currencyCode',
              style: const TextStyle(fontSize: 16)),
          trailing: const Icon(Icons.arrow_forward),
        ),
      ),
    );
  }
}
