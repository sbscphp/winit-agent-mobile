import 'package:flutter/material.dart';

import '../../core/constants/app_asset.dart';
import '../../core/utilities/navigator.dart';
import 'clickable.dart';
import 'custom_svg.dart';

class CloseIcon extends StatelessWidget {
  const CloseIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return  Clickable(
        onPressed: ()=>popNavigation(context: context),
        child: CustomAssetViewer(asset: AppAsset.close));
  }
}
