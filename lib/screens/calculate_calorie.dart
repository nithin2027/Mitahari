import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> main() async {
  var url = Uri.parse('https://trackapi.nutritionix.com/v2/search/instant/');
  var headers = {
    'x-app-id': '45d1d243',
    'x-app-key': '24c0b2ff6cf568829d434bb6183be378',
  };
  var queryParameters = {'query': 'chicken'};

  var response = await http.get(url.replace(queryParameters: queryParameters),
      headers: headers);

  if (response.statusCode == 200) {
    var result = jsonDecode(response.body);
    print(result['branded'][0]['nf_calories']);
  } else {
    print('Request failed with status: ${response.statusCode}');
  }
}
