import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/core/constants/named_routes.dart';
import 'package:winit_agent/ui/pages/wallet/withdraw.dart';
import 'package:winit_agent/ui/widgets/winit_container.dart';

import '../../../core/constants/app_asset.dart';
import '../../../core/utilities/navigator.dart';
import '../clickable.dart';
import '../close_icon.dart';
import '../custom_svg.dart';

class WalletQuickActions extends StatelessWidget {
  const WalletQuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: 24.h,
          left: 17.w,
          right: 17.w,
          bottom: 16.h
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Quick Actions',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: Theme.of(context).colorScheme.textPrimary
                        ),
                      ),
                      SizedBox(height: 4.h,),
                      Text(
                        'Take quick action on your wallet',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.textTertiary
                        ),
                      ),

                    ],
                  ),
                ),
                CloseIcon()

              ],
            ),
            SizedBox(height: 16.h,),
            walletQuickAction(
                context,
                'Wallet Top Up', 'Top Up your WinIT Wallet with ease', AppAsset.topUp,
                    (){}
            ),
            SizedBox(height: 21.h,),
            walletQuickAction(
                context,
                'Fund Withdrawal',
                'Withdraw Fund from your WinIT Wallet', AppAsset.withdrawal,
                    (){
                      replaceNavigation(context: context, widget: const Withdraw(), routeName: NamedRoutes.withdraw);
                    }
            ),

          ],
        ),
      ),
    );
  }

  walletQuickAction(BuildContext context, String label, String subtitle, String asset, VoidCallback? onPressed){
    return Clickable(
      onPressed: onPressed,
      child: WinitContainer(
          child: Row(
            children: [
              CustomAssetViewer(asset: asset, height: 36.h, width: 36.w,),
              SizedBox(width: 16.w,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: Theme.of(context).colorScheme.textSecondary
                      ),
                    ),
                    SizedBox(height: 4.h,),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.textTertiary
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
      ),
    );
  }
}
