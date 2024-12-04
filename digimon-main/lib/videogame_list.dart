import 'videogame_card.dart';
import 'package:flutter/material.dart';
import 'videogame_model.dart';

class VideogameList extends StatelessWidget {
  final List<Videogame> videogames;
  const VideogameList(this.videogames, {super.key});

  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }

  ListView _buildList(context) {
    return ListView.builder(
      itemCount: videogames.length,
      // ignore: avoid_types_as_parameter_names
      itemBuilder: (context, int) {
        return VideogameCard(videogames[int]);
      },
    );
  }
}
