import 'package:flutter/material.dart';
import 'package:map_app/service/model/map_place.dart';
import 'package:map_app/ui/map_page/map_page.dart';

class PlacePage extends StatelessWidget {
  final MapPlace place;

  const PlacePage({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(place.description),
                    TextButton.icon(
                      onPressed: () {
                        Navigator.of(context).push<void>(MaterialPageRoute(
                          builder: (_) => MapPage(
                            place: place,
                          ),
                        ));
                      },
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
                  ],
                ),
              ),
              for (int i = 0; i <= 20; i++)
                ListTile(
                  title: Text('$i'),
                ),
            ]),
          ),
        ],
      ),
    );
  }
}
