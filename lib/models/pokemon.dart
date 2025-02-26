class Pokemon {
  String id;
  String name;
  String url;
  bool isFavorite = false;

  Pokemon({required this.name, required this.url})
      : id = url
            .replaceAll("https://pokeapi.co/api/v2/pokemon/", "")
            .replaceAll("/", "");

  Pokemon.fromJson(Map<String, dynamic> json)
      : this(name: json['name'], url: json['url']);

  Map<String, String> toJson() {
    return {
      "id": id,
      "name": name,
      "url": url,
      "sprite": sprite(),
      "favorite": isFavorite.toString(),
    };
  }

  String sprite() {
    return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png";
  }
}
