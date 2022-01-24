import 'package:flutter/material.dart';
import 'package:map_app/model/map_place.dart';
import 'package:map_app/ui/place_page/place_page.dart';

final List<MapPlace> _places = [
  MapPlace(
    name: 'Mega SilkWay',
    latitude: 51.08924264891416,
    longitude: 71.40718394381314,
    img: 'https://ticketon.kz/files/media/trc-mega-silk-way%20(3).jpg',
    description: 'Торгово-развлекательный центр',
  ),
  MapPlace(
    name: 'Ботанический сад',
    latitude: 51.106369502247574,
    longitude: 71.4160205374004,
    img:
        'https://metallsnab.kz/wp-content/uploads/2019/03/Botanicheskij-sad-Astana.jpg',
    description: 'Парк',
  ),
];

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map App'),
      ),
      body: ListView(
        children: [
          for (final MapPlace place in _places)
            GestureDetector(
              onTap: () {
                Navigator.of(context).push<void>(MaterialPageRoute(
                  builder: (_) => PlacePage(
                    place: place,
                  ),
                ));
              },
              child: ListTile(
                leading: Hero(
                  tag: place.name,
                  child: CircleAvatar(backgroundImage: NetworkImage(place.img)),
                ),
                title: Text(place.name),
              ),
            ),
        ],
      ),
    );
  }
}
