import 'videogame_model.dart';
import 'videogame_detail_page.dart';
import 'package:flutter/material.dart';


class VideogameCard extends StatefulWidget {
  final Videogame videogame;

  const VideogameCard(this.videogame, {super.key});

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _VideogameCardState createState() => _VideogameCardState(videogame);
}

class _VideogameCardState extends State<VideogameCard> {
  Videogame videogame;
  String? renderUrl;

  _VideogameCardState(this.videogame);

  @override
  void initState() {
    super.initState();
    renderVideogamePic();
  }

  Widget get videogameImage {
    var videogameAvatar = Hero(
      tag: videogame,
      child: Container(
        width: 250.0,
        height: 100.0,
        decoration:
            BoxDecoration(shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(15.0) ,image: DecorationImage(alignment: Alignment.bottomCenter, fit: BoxFit.fill, image: NetworkImage(renderUrl ?? ''))),
      ),
    );

    var placeholder = Container(
      width: 100.0,
      height: 100.0,
      decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient:
              LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Colors.black54, Colors.black, Color.fromARGB(255, 84, 110, 122)])),
      alignment: Alignment.center,
      child: const Text(
        'DIGI',
        textAlign: TextAlign.center,
      ),
    );

    var crossFade = AnimatedCrossFade(
      firstChild: placeholder,
      secondChild: videogameAvatar,
      // ignore: unnecessary_null_comparison
      crossFadeState: renderUrl == null ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: const Duration(milliseconds: 1000),
    );

    return crossFade;
  }

  void renderVideogamePic() async {
    await videogame.getImageUrl();
    if (mounted) {
      setState(() {
        renderUrl = videogame.imageUrl;
      });
    }
  }

  Widget get videogameCard {
    return Positioned(
      right: 0.0,
      child: SizedBox(
        width: 290,
        height: 115,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          color: Colors.transparent, // Hacemos que el Card no tenga un color de fondo
          elevation: 5, // Agrega una sombra para que se vea bien
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0), // Recortamos para aplicar el gradiente
            child: Container(
              decoration: BoxDecoration(//Color degradado de fondo
                gradient: LinearGradient(
                  colors: [Colors.blue.shade50, Colors.purple.shade900],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              padding: const EdgeInsets.only(top: 8, bottom: 8, left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    widget.videogame.title,
                    style: const TextStyle(color: Color(0xFF000600), fontSize: 27.0),
                  ),
                  Text(
                    widget.videogame.genereVideogame.toString(),//toString para convertir String? a String
                    style: const TextStyle(color: Color(0xFF000600), fontSize: 14.0),
                  ),
                  Row(
                    children: <Widget>[
                      const Icon(Icons.star, color: Color(0xFFDCDC10)),
                      Text(
                        ': ${widget.videogame.rating}/10',
                        style: const TextStyle(color: Color(0xFF000600), fontSize: 14.0),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  showVideogameDetailPage() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return VideogameDetailPage(videogame);
    })).then((value) => setState(() {}));//Linea para recaragar y actualizar rating
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showVideogameDetailPage(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: SizedBox(
          height: 115.0,
          child: Stack(
            children: <Widget>[
              videogameCard,
              Positioned(top: 7.5, child: videogameImage),
            ],
          ),
        ),
      ),
    );
  }
}
