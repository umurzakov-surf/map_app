import 'package:flutter/material.dart';

class ErrorMapModal extends StatelessWidget {
  const ErrorMapModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Unable to route'),
          const SizedBox(height: 10),
          const Text('Try to change your location'),
          const SizedBox(height: 20),
          const Text('Set this coordinates:'),
          const SizedBox(height: 10),
          const Text('51,1145\n71,4234'),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'OK',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
