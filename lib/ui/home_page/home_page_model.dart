import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:map_app/service/map_places_repository.dart';
import 'package:map_app/service/model/map_place.dart';

class HomePageModel extends ElementaryModel {
  final ValueNotifier<List<MapPlace>> mapPlaces =
      ValueNotifier<List<MapPlace>>([]);
  final MapPlacesRepository _mapPlacesRepository;

  HomePageModel(this._mapPlacesRepository) : super();

  @override
  void init() {
    _getPlaces();
    super.init();
  }

  void _getPlaces() {
    mapPlaces.value = _mapPlacesRepository.getMapPlaces();
  }
}
