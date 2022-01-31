import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:map_app/service/model/map_place.dart';
import 'package:map_app/ui/home_page/home_page_wm.dart';

class HomePage extends ElementaryWidget<HomePageWM> {
  const HomePage({Key? key}) : super(homePageWMFactory, key: key);

  @override
  Widget build(HomePageWM wm) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map App'),
      ),
      body: ValueListenableBuilder<List<MapPlace>>(
        valueListenable: wm.mapPlaces,
        builder: (_, places, __) {
          return ListView(
            children: [
              for (final MapPlace place in places)
                GestureDetector(
                  onTap: () => wm.onMapPlaceClick(place),
                  child: ListTile(
                    leading: Hero(
                      tag: place.name,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(50)),
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/images/placeholder-image.png',
                          image: place.img,
                          width: 45,
                          height: 45,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(place.name),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
