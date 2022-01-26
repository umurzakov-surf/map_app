import 'model/map_place.dart';

class MapPlacesRepository {
  List<MapPlace> getMapPlaces() {
    return <MapPlace>[
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
  }
}
