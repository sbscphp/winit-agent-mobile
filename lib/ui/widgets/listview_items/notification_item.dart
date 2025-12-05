import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/core/data/models/app_notification.dart';

import '../../../core/constants/app_asset.dart';
import '../../../core/utilities/date_utilitites.dart';
import '../clickable.dart';
import '../custom_svg.dart';
import '../winit_container.dart';

class NotificationItem extends StatelessWidget {
  final AppNotification notification;
  const NotificationItem({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    final title = notification.title ?? 'N/A';
    final message = notification.message ?? 'N/A';
    final date = notification.createdAt ?? DateTime.now();

    return Clickable(
      onPressed: (){
      },
      child: WinitContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.textPrimary
              ),
            ),
            SizedBox(height: 8.h,),
            Text(
              message,
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
                  DateUtilities.dayMonthYear(date: date),
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
  }
}
