import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_asset.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/ui/pages/games/enter_customer_details.dart';
import 'package:winit_agent/ui/widgets/custom_svg.dart';
import 'package:winit_agent/ui/widgets/games/game_purchase_dock.dart';
import 'package:winit_agent/ui/widgets/games/game_purchase_header.dart';
import '../../../core/constants/app_dimension.dart';
import '../../../core/constants/color_path.dart';
import '../../../core/constants/named_routes.dart';
import '../../../core/utilities/navigator.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/naira_display.dart';
import '../../widgets/quantity_counter.dart';


class SelectQuantity extends StatefulWidget {
  const SelectQuantity({super.key});

  @override
  State<SelectQuantity> createState() => _SelectQuantityState();
}

class _SelectQuantityState extends State<SelectQuantity> {
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
                      title: 'Select Ticket Quantity',
                      subtitle: 'Enter ticket unit(s) you want to purchase',
                      stepValue: 1
                  ),
                  SizedBox(height: 32.h,),
                  QuantityCounter(
                      value: 1,
                      onChanged: (value){

                      }
                  ),
                  SizedBox(height: 16.h,),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Total Price',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.textTertiary
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h,),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 36.w),
                      child: NairaDisplay(
                        amount: 5000,
                        addDecimal: false,
                        fontSize: 36.sp,
                        color:Theme.of(context).colorScheme.textPrimary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h,),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 8.h,
                        horizontal: 8.w
                      ),
                      decoration: BoxDecoration(
                        color: ColorPath.athensGrey,
                        borderRadius: BorderRadius.all(Radius.circular(8.r))
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomAssetViewer(asset: AppAsset.alert4),
                          SizedBox(width: 8.w,),
                          RichText(
                            text: TextSpan(
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w500,
                                color:  ColorPath.charcoalBlack,
                              ),
                              children: [
                                TextSpan(
                                  text: 'One (1) Ticket is ',
                                ),
                                TextSpan(
                                  text: '₦5,000',
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: ColorPath.charcoalBlack
                                  ),
                                ),

                              ],
                            ),
                          )

                        ],
                      ),
                    ),
                  )

                ],
              ),
            ),
          ),
          SizedBox(height: 20.h,),
          GamePurchaseDock(
              onPressed: (){
                pushNavigation(context: context, widget: const EnterCustomerDetails(), routeName: NamedRoutes.enterCustomerDetails);
              }
          )
        ],
      ),
    );
  }
}
