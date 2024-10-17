import 'package:flutter/material.dart';

class ConversionPage extends StatefulWidget {
  final String fromCurrency;
  final String toCurrency;
  final double rate;

  const ConversionPage(
      {super.key,
      required this.fromCurrency,
      required this.toCurrency,
      required this.rate});

  @override
  _ConversionPageState createState() => _ConversionPageState();
}

class _ConversionPageState extends State<ConversionPage> {
  final TextEditingController _amountController = TextEditingController();
  double? convertedAmount;

  void convertAmount() {
    final amount = double.tryParse(_amountController.text);
    if (amount != null) {
      setState(() {
        convertedAmount = amount * widget.rate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:
              Text('Convert ${widget.fromCurrency} to ${widget.toCurrency}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter amount in ${widget.fromCurrency}',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: convertAmount,
              child: const Text('Convert'),
            ),
            const SizedBox(height: 16),
            if (convertedAmount != null)
              Text(
                  'Converted Amount: ${convertedAmount?.toStringAsFixed(2)} ${widget.toCurrency}',
                  style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
