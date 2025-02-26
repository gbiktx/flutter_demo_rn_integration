import 'pokemon.dart';

class ApiResponse {
  int count;
  String? next;
  String? prev;
  List<Pokemon> results;

  ApiResponse(
      {required this.count, this.next, this.prev, required this.results});

  ApiResponse.fromJson(Map<String, dynamic> json)
      : count = json['count'],
        next = json['next'],
        prev = json['previous'],
        results =
            (json['results'] as List).map((e) => Pokemon.fromJson(e)).toList();
}
