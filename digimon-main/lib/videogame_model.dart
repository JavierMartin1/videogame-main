// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'dart:io';
import 'dart:async';

class Videogame {
  final String title;
  String? imageUrl; //? si lo sacas del json
  String? descVideogame;
  String? genereVideogame;
  String idVideojuego; //creamos esta variable para filtrar por id ya que mi api no permite filtrar por title

  int rating = 10;

  Videogame(this.title, this.idVideojuego);

  Future getImageUrl() async {
    if (imageUrl != null) {
      return;
    }
    HttpClient http = HttpClient();
    try {

      var uri = Uri.https('www.freetogame.com', '/api/game', {'id': idVideojuego});//indica filtro
      var request = await http.getUrl(uri);
      var response = await request.close();
      var responseBody = await response.transform(utf8.decoder).join();
      //print(responseBody); comprobar lo que devuelve del json

      var data = json.decode(responseBody);//var en vez de List ya que mi response no me devuelve un array.

      imageUrl = data["thumbnail"];
      descVideogame = data["short_description"];
      genereVideogame = data["genre"];

      //print(levelVideogame);
    } catch (exception) {
      //print(exception);
    }
  }
}
