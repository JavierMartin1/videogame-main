import 'package:flutter/material.dart';
import 'videogame_model.dart';
import 'dart:async';


class VideogameDetailPage extends StatefulWidget {
  final Videogame videogame;
  const VideogameDetailPage(this.videogame, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _VideogameDetailPageState createState() => _VideogameDetailPageState();
}

class _VideogameDetailPageState extends State<VideogameDetailPage> {
  final double videogameAvarterSize = 150.0;
  double _sliderValue = 10.0;

  Widget get addYourRating {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Slider(
                  activeColor: const Color(0xFF0B479E),
                  min: 0.0,
                  max: 10.0,
                  value: _sliderValue,
                  onChanged: (newRating) {
                    setState(() {
                      _sliderValue = newRating;
                    });
                  },
                ),
              ),
              Container(
                  width: 50.0,
                  alignment: Alignment.center,
                  child: Text(
                    '${_sliderValue.toInt()}',
                    style: const TextStyle(color: Colors.black, fontSize: 25.0),
                  )),
            ],
          ),
        ),
        submitRatingButton,
      ],
    );
  }

  void updateRating() {
    if (_sliderValue < 5) {
      _ratingErrorDialog();
    } else {
      setState(() {
        widget.videogame.rating = _sliderValue.toInt();
      });
    }
  }
  @override//Para mantener rating en barra al salir y volver a entrar
  void initState() {
    super.initState();
    _sliderValue = widget.videogame.rating.toDouble();
  }

  Future<void> _ratingErrorDialog() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error!'),
            content: const Text("Come on! They're good!"),
            actions: <Widget>[
              TextButton(
                child: const Text('Try Again'),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        });
  }

  Widget get submitRatingButton {
    return ElevatedButton(
      onPressed: () => updateRating(),
      child: const Text('Submit'),
    );
  }


  Widget get videogameImage {
    return Hero(
      tag: widget.videogame,
      child: Container(
        height: videogameAvarterSize,
        width: videogameAvarterSize,
        constraints: const BoxConstraints(),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: const [
              BoxShadow(offset: Offset(1.0, 2.0), blurRadius: 2.0, spreadRadius: -1.0, color: Color(0x33000000)),
              BoxShadow(offset: Offset(2.0, 1.0), blurRadius: 3.0, spreadRadius: 0.0, color: Color(0x24000000)),
              BoxShadow(offset: Offset(3.0, 1.0), blurRadius: 4.0, spreadRadius: 2.0, color: Color(0x1f000000))
            ],
            image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(widget.videogame.imageUrl ?? ""))),
      ),
    );
  }

  Widget get rating {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Icon(
          Icons.star,
          size: 40.0,
          color: Colors.yellow,
        ),
        Text('${widget.videogame.rating}/10', style: const TextStyle(color: Colors.black, fontSize: 30.0))
      ],
    );
  }

  Widget get videogameProfile {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      decoration: const BoxDecoration(
        color: Color(0xABCAED),//color transparente para que el background del otro widget d evea en toda la pantalla
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          videogameImage,
          Text(widget.videogame.title, style: const TextStyle(color: Colors.black, fontSize: 32.0)),
          Text('${widget.videogame.descVideogame}', style: const TextStyle(color: Colors.black, fontSize: 20.0)),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: rating,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFA645FF),
        title: Text('Meet ${widget.videogame.title}'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade50, Colors.purple.shade900],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: <Widget>[videogameProfile, addYourRating],
              ),
            ),
          ],
        ),
      ),
    );
  }
  }
