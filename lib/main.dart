import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/models/api_response.dart';

import 'models/pokemon.dart';
import 'service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      theme:
          ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.white)),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = MethodChannel("flutter.demo/react.native");

  String? nextUrl;
  String? prevUrl;
  late Future<ApiResponse> fetchPokemon;

  @override
  void initState() {
    super.initState();
    fetchPokemon = fetchPokemonData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Futtler Demo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (prevUrl != null) {
                setState(() {
                  fetchPokemon = fetchPokemonData(url: prevUrl);
                });
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () {
              if (nextUrl != null) {
                setState(() {
                  fetchPokemon = fetchPokemonData(url: nextUrl);
                });
              }
            },
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder<ApiResponse>(
          future: fetchPokemon,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              nextUrl = snapshot.data?.next;
              prevUrl = snapshot.data?.prev;
              return GridView.builder(
                  itemCount: snapshot.data!.results.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 250,
                    mainAxisExtent: 320,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                  ),
                  itemBuilder: (context, index) {
                    var pokemon = snapshot.data!.results[index];
                    return Card.outlined(
                      child: InkWell(
                        onTap: () => openReactNativeScreen(pokemon),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "# ${pokemon.id}",
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                      IconButton(
                                        icon: Icon(pokemon.isFavorite
                                            ? Icons.favorite
                                            : Icons.favorite_border),
                                        onPressed: () {
                                          setState(() {
                                            pokemon.isFavorite =
                                                !pokemon.isFavorite;
                                          });
                                        },
                                      ),
                                    ]),
                                Image.network(
                                  loadingBuilder:
                                      (context, child, loadingProgress) =>
                                          loadingProgress == null
                                              ? child
                                              : const LinearProgressIndicator(),
                                  pokemon.sprite(),
                                  width: 180,
                                  height: 180,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  pokemon.name.toUpperCase(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return const LinearProgressIndicator();
          },
        ),
      ),
    );
  }

  Future<void> openReactNativeScreen(Pokemon pokemon) async {
    try {
      var isFavorite = await platform.invokeMethod(
          'openReactNativeScreen', pokemon.toJson());
      if (isFavorite != null) {
        setState(() {
          pokemon.isFavorite = isFavorite;
        });
      }
    } on PlatformException catch (e) {
      print("Failed to open React Native screen: '${e.message}'.");
    }
  }
}
