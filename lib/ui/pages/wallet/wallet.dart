import 'package:flutter/material.dart';

import '../../../core/constants/app_asset.dart';
import '../../widgets/action_icon.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/profile/profile_image.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          context: context,
          centerTitle: true,
          leadingIcon: ProfileImage(),
          title: 'Explore',
          actions: [
            ActionIcon(label: 'Quick Actions', asset: AppAsset.walletActions,
              onPressed: (){

              },
            )
          ]
      ),
    );
  }
}
