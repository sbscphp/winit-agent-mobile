import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/core/constants/named_routes.dart';
import 'package:winit_agent/core/utilities/navigator.dart';
import 'package:winit_agent/ui/pages/wallet/withdraw.dart';

import '../../../core/constants/app_asset.dart';
import '../../../core/constants/color_path.dart';
import '../custom_button.dart';
import '../custom_svg.dart';
import '../naira_display.dart';

class WalletBalanceDialog extends StatelessWidget {
  final VoidCallback onPressed;
  const WalletBalanceDialog({super.key,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: 24.h,
          horizontal: 24.w
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomAssetViewer(asset: AppAsset.warning, height: 48.h, width: 48.w,),
          SizedBox(height: 32.h,),
          FittedBox(
            child: Text(
              'Wallet Balance',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: Theme.of(context).colorScheme.textPrimary
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 16.h,),
          Text(
            'You still have funds in your wallet. Please withdraw your remaining balance to ₦0.00 before proceeding with account closure.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.textSecondary
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h,),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              vertical: 16.h,
              horizontal: 16.w
            ),
            decoration: BoxDecoration(
              color: ColorPath.stratosBlue,
              borderRadius: BorderRadius.all(Radius.circular(16.r))
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Wallet Balance',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: ColorPath.mischkaGrey
                  ),
                ),
                SizedBox(height: 5.h,),
                NairaDisplay(
                  amount: 0,
                  fontSize: 24.sp,
                  color:Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h,),
          CustomButton(
              useSuffixIcon: false,
              buttonText: 1 + 1 == 3 ? 'Proceed to Withdrawal':'Proceed to Account Closure',
              onPressed: 1 + 1 == 3 ? (){
                pushAndClearNavigation(context: context,
                    widget: const Withdraw(), routeName: NamedRoutes.withdraw,
                  clearRoute: NamedRoutes.bottomNav
                );
              }:onPressed
          )


        ],
      ),
    );
  }
}
