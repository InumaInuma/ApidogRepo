import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/model.dart';

var base = 'https://dog.ceo/api/breeds/list/all';

class ApiAnimal {
  Future<String> getImageurl(String urlImage) async {
    Uri url = Uri.parse(urlImage);
    String imageur = "";
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      if (responseData["message"] != null) {
        print(responseData["message"]);
        imageur = responseData["message"];
      }
    }

    return imageur;
  }

  Future<List<String>> getRazas() async {
    List<String> listRazas = [];
    try {
      Uri url = Uri.parse(base);
      final response = await http.get(url);
      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        //return Album.fromJson(jsonDecode(response.body));
        //dynamic data = modelFromJson(response.body);
        var responseData = json.decode(response.body);

        if (responseData["message"] != null) {
          Map<String, dynamic> map = responseData["message"];
          //recorremos el mapa
          //for (dynamic element in responseData["message"]) {
          //  print(element);
          // }
          // print(map);
          //  print(map.keys);
          //  print(map.values);
          for (var raza in map.keys) {
            print(raza);
            listRazas.add(raza);
          }
        }
        // print(listRazas);
        print(listRazas);
        // print(responseData);
        return listRazas;
      } else {
        throw Exception('Falla conexion');
      }
    } catch (e) {
      print(e.toString());
    }
    return listRazas;
  }
}
