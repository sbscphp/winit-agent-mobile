import 'package:flutter/material.dart';
import 'package:winit_agent/core/constants/app_dimension.dart';

import '../display_image.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: AppDimension.paddingLeft),
      child: Align(
        alignment: Alignment.centerLeft,
        child: DisplayImage(
          imageUrl: 'https://www.shutterstock.com/image-vector/portrait-handsome-man-confident-young-600nw-2616154679.jpg',
          firstName: 'Ayodeji',
          lastName: 'Ogundijo',
          initialsSize: 16,
          size: 32,
        ),
      ),
    );
  }
}
