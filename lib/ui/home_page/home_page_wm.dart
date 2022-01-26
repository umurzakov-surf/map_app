import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:map_app/service/map_places_repository.dart';
import 'package:map_app/service/model/map_place.dart';
import 'package:map_app/service/navigation_helper.dart';
import 'package:map_app/ui/place_page/place_page.dart';

import 'home_page.dart';
import 'home_page_model.dart';

HomePageWM homePageWMFactory(BuildContext _) =>
    HomePageWM(HomePageModel(MapPlacesRepository()), NavigationHelper());

class HomePageWM extends WidgetModel<HomePage, HomePageModel> {
  final NavigationHelper _navigator;

  ValueNotifier<List<MapPlace>> get mapPlaces => model.mapPlaces;

  HomePageWM(HomePageModel model, this._navigator) : super(model);

  void onMapPlaceClick(MapPlace place) {
    _navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (_) => PlacePage(
          place: place,
        ),
      ),
    );
  }
}
