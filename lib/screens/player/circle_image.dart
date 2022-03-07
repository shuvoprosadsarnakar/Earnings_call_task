import 'package:flutter/material.dart';
import '../../widgets/styles/color_pallate.dart';

class CircleImage extends StatelessWidget {
  const CircleImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(blurRadius: 16, color: ColorPallate.blur, spreadRadius: 10)
        ],
      ),
      child: const CircleAvatar(
        backgroundImage: AssetImage('assets/images/amazon.png'),
        backgroundColor: Colors.white,
        radius: 85,
      ),
    );
  }
}
