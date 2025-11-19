import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/core/constants/named_routes.dart';
import 'package:winit_agent/core/utilities/navigator.dart';
import 'package:winit_agent/ui/pages/notifications/notification_settings.dart';

import '../../../core/constants/app_asset.dart';
import '../../../core/constants/app_dimension.dart';
import '../../../core/constants/color_path.dart';
import '../../../core/utilities/date_utilitites.dart';
import '../../widgets/action_icon.dart';
import '../../widgets/bottom_sheets/base_bottom_sheet.dart';
import '../../widgets/bottom_sheets/filter_options.dart';
import '../../widgets/clickable.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_svg.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/winit_container.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          context: context,
          centerTitle: false,
          useCustomTitleWidget: true,
          titleWidget: FittedBox(
            child: RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
                children: [
                  TextSpan(
                    text: 'Notifications',
                  ),
                  TextSpan(
                    text: '(60)',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: ColorPath.turquoiseGreen
                    ),
                  ),
            
                ],
              ),
            ),
          ),
          actions: [
            ActionIcon(label: 'Settings', asset: AppAsset.settings,
              paddingRight: 8.w,
              onPressed: (){
                pushNavigation(context: context, widget: const NotificationSettings(), routeName: NamedRoutes.notificationSettings);
              },
            ),
            ActionIcon(label: 'Filter', asset: AppAsset.filter,
              onPressed: (){
                baseBottomSheet(
                  context: context,
                  content: FilterOptions(
                    label: 'Filter Notification',
                    subtitle: 'Filter notification with ease',
                    options: [
                      'Show All',
                      'General Notification',
                      'Game Ticket Purchase',
                      'Wallet Notification',
                      'Commission',
                      'Bonus Income'
                    ],
                    selectedOption: (value){
                      //todo: fetch filtered data
                    },
                  ),
                );
              },
            )
          ]
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppDimension.paddingLeft,
            vertical: 32.h
        ),
        child: 1 + 1 == 3 ? ListView.separated(
          itemCount: 5,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemBuilder: (BuildContext context, int index) {
            return Clickable(
              onPressed: (){
              },
              child: WinitContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Game Purchase Commission remitted to wallet',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.textPrimary
                      ),
                    ),
                    SizedBox(height: 8.h,),
                    Text(
                      '₦ 200.00 Your subscription fee has been adjusted this month. Discount applied for early renewal.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.textTertiary
                      ),
                    ),
                    SizedBox(height: 8.h,),
                    Row(
                      children: [
                        CustomAssetViewer(asset: AppAsset.calendar, height: 14.h, width: 14.w,),
                        SizedBox(width: 4.w,),
                        Text(
                          DateUtilities.dayMonthYear(date: DateTime.now()),
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).colorScheme.textTertiary
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(height: 16.h,);
          },
        ):Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            EmptyState(
              asset: AppAsset.emptyState,
              title: 'No Notifications Yet',
              subtitle: 'You currently have no notifications yet. ',
            ),
            SizedBox(height: 16.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 39.5.w),
              child: CustomButton(
                  buttonText: 'Purchase Game Ticket',
                  suffixIcon: AppAsset.ticketPurchase,
                  onPressed: () {

                  }
              ),
            )
          ],
        ),
      ),
    );
  }
}
