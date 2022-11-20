import 'dart:developer';

import 'package:apiss/services/animalApi.dart';
import 'package:flutter/material.dart';

class HomeScreemPage extends StatefulWidget {
  const HomeScreemPage({super.key});

  @override
  State<HomeScreemPage> createState() => _HomeScreemPageState();
}

class _HomeScreemPageState extends State<HomeScreemPage> {
  ApiAnimal service = ApiAnimal();

  bool isRazaSelecionada = false;
  List<String> listRazaPerros = [];
  String razaselecionada = "";
  String urlImage = "";
  dynamic getraza() async {
    listRazaPerros = await service.getRazas();
    if (listRazaPerros != null) {
      setState(() {
        razaselecionada = listRazaPerros.first;
      });
    }
  }

  dynamic getImage(String url) async {
    urlImage = await service.getImageurl(url);
    setState(() {});
  }

  String DropdowRazavalue = "seleccionar";
  @override
  void initState() {
    // TODO: implement initState
    getraza();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            width: 200,
            height: 80,
            child: DropdownButton<String>(
                value: razaselecionada,
                items: listRazaPerros
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    razaselecionada = value!;
                    isRazaSelecionada = true;
                    String urlimageraza =
                        "https://dog.ceo/api/breed/${razaselecionada.toString()}/images/random";
                    getImage(urlimageraza);
                    print(urlimageraza);
                  });
                }),
          ),
          isRazaSelecionada == true
              ? Container(
                  height: 300,
                  width: 400,
                  child: Image.network(
                    urlImage,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                          height: 80,
                          width: 80,
                          child: CircularProgressIndicator());
                    },
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
