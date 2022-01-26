import 'package:elementary/elementary.dart';
import 'package:flutter/cupertino.dart';
import 'package:map_app/service/navigation_helper.dart';
import 'package:map_app/ui/map_page/widgets/error_map_modal/error_map_modal.dart';

import 'error_map_modal_model.dart';

ErrorMapModalWM errorMapModalWMFactory(BuildContext _) =>
    ErrorMapModalWM(ErrorMapModalModel(), NavigationHelper());

class ErrorMapModalWM extends WidgetModel<ErrorMapModal, ErrorMapModalModel> {
  final NavigationHelper _navigationHelper;
  ErrorMapModalWM(ErrorMapModalModel model, this._navigationHelper) : super(model);

  void onOkButtonClick() {
    _navigationHelper.pop(context);
  }
}
