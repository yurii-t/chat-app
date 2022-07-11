import 'package:chat_app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CameraPage extends StatelessWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: AppColors.green,
        ),
        const Align(
          alignment: Alignment.topRight,
          child: Icon(Icons.cancel_outlined),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.amber,
            child: Row(
              children: const [
                Text('CAMERA PaGE'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
