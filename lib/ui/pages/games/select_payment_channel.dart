import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/ui/widgets/bottom_sheets/payment_breakdown.dart';
import 'package:winit_agent/ui/widgets/custom_divider.dart';
import '../../../core/constants/app_dimension.dart';
import '../../../core/constants/color_path.dart';
import '../../widgets/bottom_sheets/base_bottom_sheet.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_radio_button.dart';
import '../../widgets/games/game_purchase_dock.dart';
import '../../widgets/listview_items/payment_method_item.dart';


class SelectPaymentChannel extends StatefulWidget {
  const SelectPaymentChannel({super.key});

  @override
  State<SelectPaymentChannel> createState() => _SelectPaymentChannelState();
}

class _SelectPaymentChannelState extends State<SelectPaymentChannel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        centerTitle: false,
        useCustomTitleWidget: true,
        titleWidget: RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color:  ColorPath.turquoiseGreen,
            ),
            children: [
              TextSpan(
                text: 'Buy Ticket: ',
              ),
              TextSpan(
                text: 'Mega Raffle',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Colors.white
                ),
              ),

            ],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                  horizontal: AppDimension.paddingLeft,
                  vertical: 24.h
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PaymentMethodItem(showRadioButton: false,),
                  SizedBox(height: 35.h,),
                  ListView.separated(
                    itemCount: 5,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              'Card Payment',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: Theme.of(context).colorScheme.textPrimary
                              ),
                            ),
                          ),
                          SizedBox(width: 20.w,),
                          CustomRadioButton(disableClick: true, value: true,),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return CustomDivider(
                        verticalSpace: 16.h,
                        height: 1.h,
                      );
                    },
                  ),


                ],
              ),
            ),
          ),
          SizedBox(height: 20.h,),
          GamePurchaseDock(
              onPressed: (){
                baseBottomSheet(
                  context: context,
                  content: PaymentBreakdown(),
                );
              }
          )
        ],
      ),
    );
  }
}
