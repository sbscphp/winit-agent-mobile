import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';

import '../bottom_dock.dart';
import '../custom_button.dart';
import 'countdown_tile.dart';

class GamePurchaseDock extends StatefulWidget {
  final VoidCallback onPressed;
  const GamePurchaseDock({super.key, required this.onPressed});

  @override
  State<GamePurchaseDock> createState() => _GamePurchaseDockState();
}

class _GamePurchaseDockState extends State<GamePurchaseDock> {

  bool _disableButton = false;

  @override
  Widget build(BuildContext context) {
    return  BottomDock(child: Column(
      children: [
        CountdownTile(
          onTimerElapsed: (value){
            setState(() {
              _disableButton = value;
            });
          },
        ),
        SizedBox(height: 16.h,),
        CustomButton(
            buttonText: 'Continue',
            onPressed: _disableButton ? null : widget.onPressed
        ),
        if(_disableButton)Padding(
          padding: EdgeInsets.only(top: 6.h),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              'Entries closed. Thank you for playing!',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.textPrimary
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
