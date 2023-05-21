import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DataService {
  final ValueNotifier<List> tableStateNotifier = ValueNotifier([]);
  int buildQuantity;

  DataService({this.buildQuantity = 5});

  void loadFunctions(int index) {
    List<Function> functions = [
      loadCoffees,
      loadDrinks,
      loadNations,
    ];

    functions[index]();
  }

  void loadObjects(int index) {
    loadFunctions(index);
  }

  Future<void> loadDrinks() async {
    var beersUri = Uri(
      scheme: 'https',
      host: 'random-data-api.com',
      path: 'api/beer/random_beer',
      queryParameters: {'size': buildQuantity.toString()},
    );

    var jsonString = await http.read(beersUri);
    var beersJson = jsonDecode(jsonString);

    List<Map<String, dynamic>> drinksList = [];

    for (var beer in beersJson) {
      drinksList.add({
        "name": beer["name"],
        "type": beer["style"],
        "ibu": beer["ibu"],
      });
    }

    tableStateNotifier.value = drinksList;
  }

  Future<void> loadNations() async {
    var nationsUri = Uri(
      scheme: 'https',
      host: 'random-data-api.com',
      path: 'api/nation/random_nation',
      queryParameters: {'size': buildQuantity.toString()},
    );

    var jsonString = await http.read(nationsUri);
    var nationsJson = jsonDecode(jsonString);

    List<Map<String, dynamic>> nationsList = [];

    for (var nation in nationsJson) {
      nationsList.add({
        "nationality": nation["nationality"],
        "language": nation["language"],
        "capital": nation["capital"],
      });
    }

    tableStateNotifier.value = nationsList;
  }

  Future<void> loadCoffees() async {
    var coffeesUri = Uri(
      scheme: 'https',
      host: 'random-data-api.com',
      path: 'api/coffee/random_coffee',
      queryParameters: {'size': buildQuantity.toString()},
    );

    var jsonString = await http.read(coffeesUri);
    var coffeesJson = jsonDecode(jsonString);

    List<Map<String, dynamic>> coffeesList = [];

    for (var coffee in coffeesJson) {
      coffeesList.add({
        "name": coffee["blend_name"],
        "origin": coffee["origin"],
        "intensity": coffee["intensifier"][0].toUpperCase() +
            coffee["intensifier"].substring(1),
      });
    }

    tableStateNotifier.value = coffeesList;
  }
}
