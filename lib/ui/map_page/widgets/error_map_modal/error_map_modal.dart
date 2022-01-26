import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:map_app/ui/map_page/widgets/error_map_modal/error_map_modal_wm.dart';

class ErrorMapModal extends ElementaryWidget<ErrorMapModalWM> {
  const ErrorMapModal({Key? key}) : super(errorMapModalWMFactory, key: key);

  @override
  Widget build(ErrorMapModalWM wm) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Unable to route'),
          const SizedBox(height: 10),
          const Text('Try to change your location'),
          const SizedBox(height: 20),
          const Text('Simulator > Features > Location > Custom Location'),
          const SizedBox(height: 20),
          const Text('Set this coordinates:'),
          const SizedBox(height: 10),
          const Text('51,1145\n71,4234'),
          const SizedBox(height: 20),
          TextButton(
            onPressed: wm.onOkButtonClick,
            child: const Text(
              'OK',
              style: TextStyle(color: Colors.white),
            ),
            style: TextButton.styleFrom(
              backgroundColor: Colors.blueAccent,
            ),
          ),
        ],
      ),
    );
  }
}
