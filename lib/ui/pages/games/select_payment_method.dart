import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/ui/pages/games/select_payment_channel.dart';

import '../../../core/constants/app_dimension.dart';
import '../../../core/constants/color_path.dart';
import '../../../core/constants/named_routes.dart';
import '../../../core/utilities/navigator.dart';
import '../../../core/utilities/utilities.dart';
import '../../widgets/bottom_sheets/base_bottom_sheet.dart';
import '../../widgets/bottom_sheets/payment_breakdown.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_radio_button.dart';
import '../../widgets/games/game_purchase_dock.dart';
import '../../widgets/games/game_purchase_header.dart';
import '../../widgets/listview_items/payment_method_item.dart';
import '../../widgets/naira_display.dart';
import '../../widgets/screen_title.dart';

class SelectPaymentMethod extends StatefulWidget {
  const SelectPaymentMethod({super.key});

  @override
  State<SelectPaymentMethod> createState() => _SelectPaymentMethodState();
}

class _SelectPaymentMethodState extends State<SelectPaymentMethod> {
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
                  vertical: 14.h
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GamePurchaseHeader(
                    title: 'Select a Payment Method',
                    subtitle: 'Select an option for payment',
                    stepValue: 3,
                  ),
                  SizedBox(height: 32.h,),
                  ScreenTitle(title: 'Pay With Wallet',
                      subtitle: 'Pay with ease with your wallet'
                  ),
                  SizedBox(height: 16.h,),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                        vertical: 16.h,
                        horizontal: 16.w
                    ),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.brandColor,
                        borderRadius: BorderRadius.all(Radius.circular(16.r))
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomRadioButton(
                          disableClick: true,
                          value: true,
                          size: 20,
                          inactiveColor: Colors.white,
                        ),
                        SizedBox(width: 16.w,),
                        Expanded(
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
                              SizedBox(height: 4.h,),
                              NairaDisplay(
                                amount: 22000,
                                fontSize: 30.sp,
                                color:Colors.white,
                                fontWeight: FontWeight.w800,
                              ),
                              SizedBox(height: 4.h,),
                              FittedBox(
                                child: RichText(
                                  textAlign: TextAlign.left,
                                  text: TextSpan(
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.italic,
                                      color: ColorPath.magnoliaGrey,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: '+ ₦ ${Utilities.formatAmount(
                                            amount: 234543,
                                            addDecimal: true
                                        )}',
                                      ),
                                      TextSpan(
                                        text: ' added in last 4 days',
                                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                            fontWeight: FontWeight.w400,
                                            color: ColorPath.magnoliaGrey
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h,),
                  ScreenTitle(title: 'Other payment option',
                      subtitle: 'Connect with Paystack to make payments easily via bank transfer, debit card, USSD, and more'
                  ),
                  SizedBox(height: 16.h,),
                  ListView.separated(
                    itemCount: 1,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemBuilder: (BuildContext context, int index) {
                      return PaymentMethodItem();
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 24.h,);
                    },
                  ),


                ],
              ),
            ),
          ),
          SizedBox(height: 20.h,),
          GamePurchaseDock(
              onPressed: (){
                if(1 + 1 == 3){
                  baseBottomSheet(
                    context: context,
                    content: PaymentBreakdown(),
                  );
                  return;
                }
                pushNavigation(context: context, widget: const SelectPaymentChannel(), routeName: NamedRoutes.selectPaymentChannel);
              }
          )
        ],
      ),
    );
  }
}
