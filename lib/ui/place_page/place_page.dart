import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:map_app/service/model/map_place.dart';
import 'package:map_app/ui/place_page/place_page_wm.dart';

class PlacePage extends ElementaryWidget<PlacePageWM> {
  final MapPlace place;

  const PlacePage({Key? key, required this.place})
      : super(placePageWMFactory, key: key);

  @override
  Widget build(PlacePageWM wm) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                place.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              background: Hero(
                tag: place.name,
                child: Image.network(place.img, fit: BoxFit.cover),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(
                  height: 20,
                ),
                Text(place.description),
                TextButton.icon(
                  onPressed: () => wm.onRouteButtonClick(place),
                  icon: const Icon(
                    Icons.moving,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Маршрут',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                  ),
                ),
                for (int someNum = 0; someNum <= 20; someNum++)
                  ListTile(
                    title: Text('$someNum'),
                  ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
