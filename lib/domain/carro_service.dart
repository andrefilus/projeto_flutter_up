import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:aula2/domain/carro.dart';

class CarroService {
  static Future<List<Carro>> getCarros() async {

//    String s = await rootBundle.loadString("assets/json/carros.json");

    final url = "http://livrowebservices.com.br/rest/carros";
    print("> get: $url");

    final response = await http.get(url);

    final mapCarros = json.decode(response.body);

    List<Carro> carros =
    mapCarros.map<Carro>((json) => Carro.fromJson(json)).toList();

    return carros;
  }

  static List<Carro> getCarros2() {
    List<Carro> carros = [];

    carros.add(Carro("Fusca"));
    carros.add(Carro("Brasilia"));
    carros.add(Carro("Chevette"));

    carros.add(Carro("Opala"));
    carros.add(Carro("Maverick"));
    carros.add(Carro("Corvette"));

    return carros;
  }
}
