import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/core/data/view_models/notification/notification_settings_vm.dart';
import 'package:winit_agent/core/data/view_models/profile/profile_vm.dart';
import 'package:winit_agent/core/data/view_models/utility/config_vm.dart';
import 'package:winit_agent/core/utilities/navigator.dart';
import 'package:winit_agent/ui/widgets/app_loader.dart';
import 'package:winit_agent/ui/widgets/busy_overlay.dart';
import 'package:winit_agent/ui/widgets/error_state.dart';

import '../../../core/constants/app_dimension.dart';
import '../../../core/constants/color_path.dart';
import '../../../core/data/enum/view_state.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/show_flush_bar.dart';
import '../../widgets/winit_container.dart';

class NotificationSettings extends ConsumerStatefulWidget {
  const NotificationSettings({super.key});

  @override
  ConsumerState<NotificationSettings> createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends ConsumerState<NotificationSettings> {

  bool _general = false;
  bool _games = false;
  bool _ticketPurchase = false;
  bool _wallet = false;
  bool _commission = false;
  bool _bonus = false;


  @override
  void initState() {
    final vm = ref.read(notificationSettingsViewModel);
    _general = vm.general;
    _games = vm.games;
    _ticketPurchase = vm.ticketPurchase;
    _wallet = vm.wallet;
    _commission = vm.commission;
    _bonus = vm.bonus;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(notificationSettingsViewModel);
    final profileVm = ref.watch(profileViewModel);
    final configVm = ref.watch(configViewModel);
    return BusyOverlay(
      show: vm.secondState == ViewState.busy,
      child: Scaffold(
        appBar: customAppBar(
          context: context,
          title: 'Notification Settings',
        ),
        body: Builder(
          builder: (context) {
            if(vm.state == ViewState.busy){
              return Center(
                child: AppLoader(),
              );
            }

            if(vm.state == ViewState.retrieved){
              return SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppDimension.paddingLeft,
                            vertical: 32.h
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            WinitContainer(
                                child:Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child:  Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'General Notification',
                                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: Theme.of(context).colorScheme.textSecondary
                                            ),
                                          ),
                                          SizedBox(height: 8.h,),
                                          Text(
                                            'Marketing notification and app update',
                                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                fontWeight: FontWeight.w400,
                                                color: Theme.of(context).colorScheme.textTertiary
                                            ),
                                          ),
                
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 30.w,),
                                    Transform.scale(
                                        alignment: Alignment.centerRight,
                                        scale: 0.7,
                                        child: CupertinoSwitch(
                                            value:_general,
                                            activeTrackColor: Theme.of(context).colorScheme.textPrimary,
                                            inactiveTrackColor: ColorPath.athensGrey5,
                                            thumbColor: Colors.white,
                                            onChanged: (value){
                                              setState(() {
                                                _general = value;
                                              });
                                            })),
                                  ],
                                )
                            ),
                            SizedBox(height: 16.h,),
                            WinitContainer(
                                child:Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child:  Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Games Notification',
                                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: Theme.of(context).colorScheme.textSecondary
                                            ),
                                          ),
                                          SizedBox(height: 8.h,),
                                          Text(
                                            'New Game Added, Trending Games etc',
                                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                fontWeight: FontWeight.w400,
                                                color: Theme.of(context).colorScheme.textTertiary
                                            ),
                                          ),
                
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 30.w,),
                                    Transform.scale(
                                        scale: 0.7,
                                        alignment: Alignment.centerRight,
                                        child: CupertinoSwitch(
                                            value:_games,
                                            activeTrackColor: Theme.of(context).colorScheme.textPrimary,
                                            inactiveTrackColor: ColorPath.athensGrey5,
                                            thumbColor: Colors.white,
                                            onChanged: (value){
                                              setState(() {
                                                _games = value;
                                              });
                                            })),
                                  ],
                                )
                            ),
                            SizedBox(height: 16.h,),
                            WinitContainer(
                                child:Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child:  Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Games Ticket Purchase',
                                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: Theme.of(context).colorScheme.textSecondary
                                            ),
                                          ),
                                          SizedBox(height: 8.h,),
                                          Text(
                                            'Ticket purchase confirmation, etc',
                                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                fontWeight: FontWeight.w400,
                                                color: Theme.of(context).colorScheme.textTertiary
                                            ),
                                          ),
                
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 30.w,),
                                    Transform.scale(
                                        scale: 0.7,
                                        alignment: Alignment.centerRight,
                                        child: CupertinoSwitch(
                                            value:_ticketPurchase,
                                            activeTrackColor: Theme.of(context).colorScheme.textPrimary,
                                            inactiveTrackColor: ColorPath.athensGrey5,
                                            thumbColor: Colors.white,
                                            onChanged: (value){
                                              setState(() {
                                                _ticketPurchase = value;
                                              });
                                            })),
                                  ],
                                )
                            ),
                            if(profileVm.hasWallet && configVm.isWalletEnabled)SizedBox(height: 16.h,),
                            if(profileVm.hasWallet && configVm.isWalletEnabled)WinitContainer(
                                child:Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child:  Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Wallet Notification',
                                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: Theme.of(context).colorScheme.textSecondary
                                            ),
                                          ),
                                          SizedBox(height: 8.h,),
                                          Text(
                                            'Fund withdrawal, top up etc. ',
                                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                fontWeight: FontWeight.w400,
                                                color: Theme.of(context).colorScheme.textTertiary
                                            ),
                                          ),
                
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 30.w,),
                                    Transform.scale(
                                        scale: 0.7,
                                        alignment: Alignment.centerRight,
                                        child: CupertinoSwitch(
                                            value:_wallet,
                                            activeTrackColor: Theme.of(context).colorScheme.textPrimary,
                                            inactiveTrackColor: ColorPath.athensGrey5,
                                            thumbColor: Colors.white,
                                            onChanged: (value){
                                              setState(() {
                                                _wallet = value;
                                              });
                                            })),
                                  ],
                                )
                            ),
                            SizedBox(height: 16.h,),
                            WinitContainer(
                                child:Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child:  Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Commission',
                                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: Theme.of(context).colorScheme.textSecondary
                                            ),
                                          ),
                                          SizedBox(height: 8.h,),
                                          Text(
                                            'Ticket purchase commission and settlement',
                                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                fontWeight: FontWeight.w400,
                                                color: Theme.of(context).colorScheme.textTertiary
                                            ),
                                          ),
                
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 30.w,),
                                    Transform.scale(
                                        alignment: Alignment.centerRight,
                                        scale: 0.7,
                                        child: CupertinoSwitch(
                                            value:_commission,
                                            activeTrackColor: Theme.of(context).colorScheme.textPrimary,
                                            inactiveTrackColor: ColorPath.athensGrey5,
                                            thumbColor: Colors.white,
                                            onChanged: (value){
                                              setState(() {
                                                _commission = value;
                                              });
                                            })),
                                  ],
                                )
                            ),
                            SizedBox(height: 16.h,),
                            WinitContainer(
                                child:Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child:  Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Bonus Income',
                                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: Theme.of(context).colorScheme.textSecondary
                                            ),
                                          ),
                                          SizedBox(height: 8.h,),
                                          FittedBox(
                                            child: Text(
                                              'Game Bonus income deposit into your wallet',
                                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                  fontWeight: FontWeight.w400,
                                                  color: Theme.of(context).colorScheme.textTertiary
                                              ),
                                            ),
                                          ),
                
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 30.w,),
                                    Transform.scale(
                                        alignment: Alignment.centerRight,
                                        scale: 0.7,
                                        child: CupertinoSwitch(
                                            value:_bonus,
                                            activeTrackColor: Theme.of(context).colorScheme.textPrimary,
                                            inactiveTrackColor: ColorPath.athensGrey5,
                                            thumbColor: Colors.white,
                                            onChanged: (value){
                                              setState(() {
                                                _bonus = value;
                                              });
                                            })),
                                  ],
                                )
                            ),
                
                
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppDimension.paddingLeft, vertical: 20.h),
                      child: CustomButton(
                          buttonText: 'Save Changes',
                          onPressed: () async{
                
                            await vm.updateNotificationSettings(
                                general: _general,
                                games: _games,
                                ticketPurchase: _ticketPurchase,
                                commission: _commission,
                                wallet: _wallet,
                                bonus: _bonus
                            );
                
                            if(vm.secondState == ViewState.retrieved){
                              popNavigation(context: context);
                            }
                
                            showFlushBar(
                                context: context,
                                message: vm.message,
                                success: vm.secondState == ViewState.retrieved
                            );
                
                          }
                      ),
                    ),
                  ],
                ),
              );
            }

            if(vm.state == ViewState.error){
              return Center(
                child: ErrorState(
                  message: vm.message,
                    onPressed: ()=>vm.fetchNotificationSettings()),
              );
            }

            return const SizedBox.shrink();

          }
        ),
      ),
    );
  }
}
