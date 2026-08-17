import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/core/data/enum/checkout_type.dart';
import 'package:winit_agent/core/data/view_models/games/selected_game_vm.dart';
import 'package:winit_agent/core/data/view_models/checkout/payment_vm.dart';
import 'package:winit_agent/core/data/view_models/profile/profile_vm.dart';
import 'package:winit_agent/core/data/view_models/utility/config_vm.dart';
import 'package:winit_agent/core/data/view_models/wallet/wallet_vm.dart';
import 'package:winit_agent/ui/pages/games/select_payment_channel.dart';
import 'package:winit_agent/ui/widgets/busy_overlay.dart';
import 'package:winit_agent/ui/widgets/clickable.dart';
import 'package:winit_agent/ui/widgets/games/game_appbar_title.dart';
import 'package:winit_agent/ui/widgets/show_flush_bar.dart';

import '../../../core/constants/app_dimension.dart';
import '../../../core/constants/color_path.dart';
import '../../../core/constants/named_routes.dart';
import '../../../core/data/enum/view_state.dart';
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

class SelectPaymentMethod extends ConsumerStatefulWidget {
  const SelectPaymentMethod({super.key});

  @override
  ConsumerState<SelectPaymentMethod> createState() => _SelectPaymentMethodState();
}

class _SelectPaymentMethodState extends ConsumerState<SelectPaymentMethod> {

  @override
  void initState() {
    ref.read(paymentViewModel).reset();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(paymentViewModel);
    final profileVm = ref.watch(profileViewModel);
    final configVm = ref.watch(configViewModel);
    return BusyOverlay(
      show: vm.state == ViewState.busy,
      child: Scaffold(
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
                    if(profileVm.hasWallet && configVm.isWalletEnabled)SizedBox(height: 32.h,),
                    if(profileVm.hasWallet && configVm.isWalletEnabled)ScreenTitle(title: 'Pay With Wallet',
                        subtitle: 'Pay with ease with your wallet'
                    ),
                    if(profileVm.hasWallet && configVm.isWalletEnabled)SizedBox(height: 16.h,),
                    if(profileVm.hasWallet && configVm.isWalletEnabled)Consumer(
                      builder: (context, ref, child){
                        final wVm = ref.watch(walletVm);
                        return Clickable(
                          onPressed: (){
                            vm.checkoutType = CheckoutType.wallet;
                          },
                          child: Container(
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
                                  value: vm.checkoutType == CheckoutType.wallet,
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
                                        amount: wVm.walletBalance,
                                        fontSize: 30.sp,
                                        color:Colors.white,
                                        fontWeight: FontWeight.w800,
                                      ),
                                      if(wVm.addedAmount != 0)SizedBox(height: 4.h,),
                                      if(wVm.addedAmount != 0) FittedBox(
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
                                                    amount: wVm.addedAmount,
                                                    addDecimal: true
                                                )}',
                                              ),
                                              TextSpan(
                                                text: ' added in last ${wVm.duration} ${(int.tryParse(wVm.duration) ?? 0) > 1 ? 'days':'day'}',
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
                        );
                      },
                    ),
                    SizedBox(height: 24.h,),
                    ScreenTitle(title: 'Other payment option',
                        subtitle: 'Connect with Paystack to make payments easily via bank transfer, debit card, USSD, and more'
                    ),
                    SizedBox(height: 16.h,),
                    ListView.separated(
                      itemCount: vm.paymentMethods.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemBuilder: (BuildContext context, int index) {
                        final paymentMethod = vm.paymentMethods[index];
                        return PaymentMethodItem(paymentMethod: paymentMethod,);
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
                onPressed: ()async{

                  if(vm.checkoutType == null){
                    showFlushBar(
                        context: context,
                        message: "Kindly select a payment method to proceed",
                      success: false
                    );
                    return;
                  }

                  if(vm.checkoutType == CheckoutType.wallet){

                    //fetch payment summary
                    await vm.fetchPaymentBreakdown(
                        gameId: ref.read(selectedGameViewModel).gameId,
                        quantity: ref.read(selectedGameViewModel).quantity
                    );

                    if(vm.state == ViewState.retrieved){
                      baseBottomSheet(
                        context: context,
                        content: PaymentBreakdown(),
                      );
                    }

                    showFlushBar(
                        context: context,
                        message: vm.message,
                      success: vm.state == ViewState.retrieved
                    );

                  }else{
                    pushNavigation(context: context, widget: const SelectPaymentChannel(), routeName: NamedRoutes.selectPaymentChannel);
                  }

                }
            )
          ],
        ),
      ),
    );
  }
}
