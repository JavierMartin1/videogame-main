import 'package:flutter/material.dart';
import 'dart:async';
import 'videogame_model.dart';
import 'videogame_list.dart';
import 'new_videogame_form.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Fav Horror Videogames',
      theme: ThemeData(brightness: Brightness.dark),
      home: const MyHomePage(
        title: 'My Fav Horror Videogames',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Videogame> initialVideogames = [Videogame('Once Human', '584'), Videogame('Deceit 2','577'), Videogame('Stalcraft','594')];

  Future _showNewVideogameForm() async {
    Videogame newVideogame = await Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
      return const AddVideogameFormPage();
    }));
    //print(newVideogame);
    initialVideogames.add(newVideogame);
      setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var key = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color(0xFFA645FF),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showNewVideogameForm,
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(//background difuminat
          gradient: LinearGradient(
            colors: [Colors.blue.shade50, Colors.purple.shade900],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
          //color: const Color.fromARGB(255, 88, 111, 137),
          child: Center(
            child: VideogameList(initialVideogames),
          )),
    );
  }
}
