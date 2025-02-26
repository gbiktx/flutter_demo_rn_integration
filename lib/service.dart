import 'dart:convert';

import 'models/api_response.dart';
import 'package:http/http.dart' as http;

const String initialUrl = 'https://pokeapi.co/api/v2/pokemon?limit=151';

Future<ApiResponse> fetchPokemonData({String? url}) async {
  final response = await http.get(
    Uri.parse(url ?? initialUrl),
  );

  if (response.statusCode == 200) {
    return ApiResponse.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load Pokémon');
  }
}
