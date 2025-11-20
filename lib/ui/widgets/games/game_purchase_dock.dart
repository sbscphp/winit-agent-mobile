import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../bottom_dock.dart';
import '../custom_button.dart';
import 'countdown_tile.dart';

class GamePurchaseDock extends StatelessWidget {
  final VoidCallback onPressed;
  const GamePurchaseDock({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return  BottomDock(child: Column(
      children: [
        CountdownTile(),
        SizedBox(height: 16.h,),
        CustomButton(
            buttonText: 'Continue',
            onPressed: onPressed
        ),
      ],
    ));
  }
}
