import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/ui/widgets/alert_dialogs/action_confirmation.dart';
import 'package:winit_agent/ui/widgets/clickable.dart';

import '../../../core/constants/app_asset.dart';
import '../../../core/constants/color_path.dart';
import '../../../core/utilities/navigator.dart';
import '../alert_dialogs/action_completed.dart';
import '../alert_dialogs/base_dialog.dart';
import '../alert_dialogs/enter_transaction_pin.dart';
import '../cross_fade_widget.dart';
import '../custom_radio_button.dart';
import '../custom_svg.dart';
import '../winit_container.dart';

class BankAccountItem extends StatefulWidget {
  final bool canDelete;
  const BankAccountItem({super.key, this.canDelete = false});

  @override
  State<BankAccountItem> createState() => _BankAccountItemState();
}

class _BankAccountItemState extends State<BankAccountItem> {

  final switchNotifier = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return WinitContainer(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(!widget.canDelete)CustomRadioButton(disableClick: true,),
                if(!widget.canDelete)SizedBox(width: 8.w,),
                CustomAssetViewer(asset: AppAsset.building4, height: 32.h, width: 32.w,),
                SizedBox(width: 8.w,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Access Bank PLC',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: Theme.of(context).colorScheme.textPrimary
                        ),
                      ),
                      SizedBox(height: 4.h,),
                      FittedBox(
                        child: Row(
                          children: [
                            Row(
                              children: [
                                CustomAssetViewer(asset: AppAsset.avatar2, height: 14.h, width: 14.w,),
                                SizedBox(width: 4.w,),
                                Text(
                                  'Adekunle',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context).colorScheme.textSecondary
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 16.h,
                              width: 1.w,
                              color: ColorPath.athensGrey3,
                              margin: EdgeInsets.symmetric(horizontal: 11.w),
                            ),
                            Row(
                              children: [
                                CustomAssetViewer(asset: AppAsset.accountNo, height: 14.h, width: 14.w,),
                                SizedBox(width: 4.w,),
                                Text(
                                  '0069000592',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context).colorScheme.textSecondary
                                  ),
                                ),

                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          if(widget.canDelete)Clickable(
            onPressed: (){

              baseDialog(
                context: context,
                content: CrossFadeWidget(
                  switchNotifier: switchNotifier,
                  firstChild: ActionConfirmation(
                    title: 'Remove Bank Account Details ?',
                    subtitle:
                    'Are you sure you want to remove this bank account as a withdrawal option? This action cannot be undone, and all saved details will be permanently deleted."',
                    buttonText: 'Yes, Remove',
                    onPressed: () => switchNotifier.value = true,
                  ),
                  secondChild: EnterTransactionPin(
                      onDone: (value){
                        Future.delayed(const Duration(milliseconds: 50), () {
                          baseDialog(
                            context: context,
                            content: ActionCompleted(
                              title: 'Request Completed',
                              assetSize: 80,
                              subtitle:
                              'Congratulations, your withdrawal request has been successfully completed. A notification will be sent to you when fully processed.',
                              onPressed: () {
                                popNavigation(context: context);
                              },
                            ),
                          );
                        });
                      }
                  ),
                ),
                onClosed: () {
                  switchNotifier.value = false;
                },
              );
            },
              child: CustomAssetViewer(asset: AppAsset.delete2, height: 18.h, width: 18.w,))
        ],
      ),
    );
  }
}
