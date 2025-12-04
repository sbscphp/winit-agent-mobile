import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/core/data/models/payment_method.dart';
import 'package:winit_agent/core/data/view_models/checkout/payment_vm.dart';
import 'package:winit_agent/ui/widgets/bottom_sheets/payment_breakdown.dart';
import 'package:winit_agent/ui/widgets/clickable.dart';
import 'package:winit_agent/ui/widgets/custom_divider.dart';
import 'package:winit_agent/ui/widgets/games/game_appbar_title.dart';
import '../../../core/constants/app_dimension.dart';
import '../../../core/constants/color_path.dart';
import '../../../core/utilities/utilities.dart';
import '../../widgets/bottom_sheets/base_bottom_sheet.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_radio_button.dart';
import '../../widgets/games/game_purchase_dock.dart';
import '../../widgets/listview_items/payment_method_item.dart';


class SelectPaymentChannel extends ConsumerStatefulWidget {
  const SelectPaymentChannel({super.key});

  @override
  ConsumerState<SelectPaymentChannel> createState() => _SelectPaymentChannelState();
}

class _SelectPaymentChannelState extends ConsumerState<SelectPaymentChannel> {
  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(paymentViewModel);
    return Scaffold(
      appBar: customAppBar(
        context: context,
        centerTitle: false,
        useCustomTitleWidget: true,
        titleWidget: GameAppbarTitle(),
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
                  PaymentMethodItem(showRadioButton: false, paymentMethod: vm.selectedPaymentMethod ?? PaymentMethod(),),
                  SizedBox(height: 35.h,),
                  ListView.separated(
                    itemCount: vm.paymentTypes.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemBuilder: (BuildContext context, int index) {
                      final paymentType = vm.paymentTypes[index];
                      final isSelected = paymentType.toLowerCase() == vm.selectedPaymentType?.toLowerCase();
                      return Clickable(
                        onPressed: (){
                          vm.selectedPaymentType = paymentType;
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                Utilities.capitalizeWord(paymentType).replaceAll('_', ' '),
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: Theme.of(context).colorScheme.textPrimary
                                ),
                              ),
                            ),
                            SizedBox(width: 20.w,),
                            CustomRadioButton(disableClick: true, value: isSelected,),
                          ],
                        ),
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
