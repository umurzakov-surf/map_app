import 'package:elementary/elementary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:map_app/service/model/map_place.dart';
import 'package:map_app/service/navigation_helper.dart';
import 'package:map_app/ui/map_page/map_page.dart';
import 'package:map_app/ui/place_page/place_page.dart';
import 'package:map_app/ui/place_page/place_page_model.dart';

PlacePageWM placePageWMFactory(BuildContext _) =>
    PlacePageWM(PlacePageModel(), NavigationHelper());

class PlacePageWM extends WidgetModel<PlacePage, PlacePageModel> {
  final NavigationHelper _navigator;

  PlacePageWM(PlacePageModel model, this._navigator) : super(model);

  void onRouteButtonClick(MapPlace place) {
    _navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (_) => MapPage(
          place: place,
        ),
      ),
    );
  }
}
