import 'package:flutter/material.dart';
import 'conversion_page.dart';
import '../widgets/currency_flag_card.dart';
import '../services/currency_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CurrencyService _currencyService = CurrencyService();
  Map<String, dynamic> exchangeRates = {};
  bool isLoading = true;
  String errorMessage = '';

  // Define the specific currencies you want to display
  final List<String> selectedCurrencies = ['PKR', 'BDT', 'USD', 'INR', 'EUR'];

  @override
  void initState() {
    super.initState();
    fetchRates();
  }

  Future<void> fetchRates() async {
    try {
      final data = await _currencyService.fetchExchangeRates('GBP');
      setState(() {
        exchangeRates = data['quotes'] ?? {}; // Handle null quotes safely
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GBP to Other Currencies'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    children: exchangeRates.entries
                        .where((entry) => selectedCurrencies.contains(
                            entry.key.substring(3))) // Filter currencies
                        .map((entry) {
                      String currencyCode = entry.key.substring(
                          3); // Extract currency code (GBP is the source)
                      double rate = entry.value;

                      return CurrencyFlagCard(
                        currencyCode: currencyCode,
                        rate: rate,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ConversionPage(
                                fromCurrency: 'GBP',
                                toCurrency: currencyCode,
                                rate: rate,
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
    );
  }
}
