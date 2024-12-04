import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'videogame_model.dart';
import 'package:flutter/material.dart';

class AddVideogameFormPage extends StatefulWidget {
  const AddVideogameFormPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddVideogameFormPageState createState() => _AddVideogameFormPageState();
}

class _AddVideogameFormPageState extends State<AddVideogameFormPage> {
  TextEditingController nameController = TextEditingController();

  Map horrorVideogames={};//mapa/dicc para guardar id y title

  Future<void> RellenarLista() async {
    HttpClient http = HttpClient();
    try {


      var uri = Uri.https('www.freetogame.com', '/api/filter', {'tag': 'horror'});//indica filtro

      var request = await http.getUrl(uri);
      var response = await request.close();
      var responseBody = await response.transform(utf8.decoder).join();
      //print(responseBody); //comprobar lo que devuelve del json

      List data = json.decode(responseBody);
      for(int i=0;i<data.length;i++){
        horrorVideogames.addAll({data[i]["title"]:data[i]["id"].toString()});
      }
    } catch (exception) {
      //print(exception);
    }
  }

  void submitPup(BuildContext context) {
    if (nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text('You forgot to insert the videogame name'),
      ));
    }
    else if(!horrorVideogames.containsKey(nameController.text)){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text('This videogame does not exist'),
      ));
    }
    else {
      var newVideogame = Videogame(nameController.text, horrorVideogames[nameController.text]); //
      Navigator.of(context).pop(newVideogame);
    }
  }

  @override
  Widget build(BuildContext context) {
    RellenarLista();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new videogame'),
        backgroundColor: const Color(0xFFA645FF),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade50, Colors.purple.shade900],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextField(
                controller: nameController,
                style:TextStyle(color: Colors.black),
                onChanged: (v) => nameController.text = v,
                decoration: const InputDecoration(
                  labelText: 'Videogame Name',
                  labelStyle: TextStyle(color: Colors.black),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () => submitPup(context),
                    child: const Text('Submit Videogame'),
                  );
                },
              ),
            )
          ]),
        ),
      ),
    );
  }
}
