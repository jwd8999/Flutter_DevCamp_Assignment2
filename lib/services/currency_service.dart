import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrencyService {
  final String apiKey = 'b8641509baae5a4fc20d563269678290';
  final String apiUrl = 'http://api.currencylayer.com/live';

  Future<Map<String, dynamic>> fetchExchangeRates(String baseCurrency) async {
    try {
      final response = await http
          .get(Uri.parse('$apiUrl?access_key=$apiKey&source=$baseCurrency'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Check if the response contains the expected data
        if (data == null || data['quotes'] == null) {
          throw Exception('Invalid data received from the API');
        }

        return data;
      } else {
        throw Exception(
            'Failed to load exchange rates. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching exchange rates: $e');
    }
  }
}
