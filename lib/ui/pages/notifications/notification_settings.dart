import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';

import '../../../core/constants/app_dimension.dart';
import '../../../core/constants/color_path.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/winit_container.dart';

class NotificationSettings extends StatefulWidget {
  const NotificationSettings({super.key});

  @override
  State<NotificationSettings> createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'Notification Settings',
      ),
      body: SingleChildScrollView(
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
                  SizedBox(
                    height: 20,
                    width: 20,
                    child: Transform.scale(
                        scale: 0.7,
                        child: Padding(
                          padding: EdgeInsets.only(right: 10.w),
                          child: CupertinoSwitch(
                              value:false,
                              activeTrackColor: Theme.of(context).colorScheme.textPrimary,
                              inactiveTrackColor: ColorPath.athensGrey5,
                              thumbColor: Colors.white,
                              onChanged: (value){

                              }),
                        )),
                  ),
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
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: Transform.scale(
                          scale: 0.7,
                          child: Padding(
                            padding: EdgeInsets.only(right: 10.w),
                            child: CupertinoSwitch(
                                value:false,
                                activeTrackColor: Theme.of(context).colorScheme.textPrimary,
                                inactiveTrackColor: ColorPath.athensGrey5,
                                thumbColor: Colors.white,
                                onChanged: (value){

                                }),
                          )),
                    ),
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
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: Transform.scale(
                          scale: 0.7,
                          child: Padding(
                            padding: EdgeInsets.only(right: 10.w),
                            child: CupertinoSwitch(
                                value:false,
                                activeTrackColor: Theme.of(context).colorScheme.textPrimary,
                                inactiveTrackColor: ColorPath.athensGrey5,
                                thumbColor: Colors.white,
                                onChanged: (value){

                                }),
                          )),
                    ),
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
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: Transform.scale(
                          scale: 0.7,
                          child: Padding(
                            padding: EdgeInsets.only(right: 10.w),
                            child: CupertinoSwitch(
                                value:false,
                                activeTrackColor: Theme.of(context).colorScheme.textPrimary,
                                inactiveTrackColor: ColorPath.athensGrey5,
                                thumbColor: Colors.white,
                                onChanged: (value){

                                }),
                          )),
                    ),
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
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: Transform.scale(
                          scale: 0.7,
                          child: Padding(
                            padding: EdgeInsets.only(right: 10.w),
                            child: CupertinoSwitch(
                                value:false,
                                activeTrackColor: Theme.of(context).colorScheme.textPrimary,
                                inactiveTrackColor: ColorPath.athensGrey5,
                                thumbColor: Colors.white,
                                onChanged: (value){

                                }),
                          )),
                    ),
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
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: Transform.scale(
                          scale: 0.7,
                          child: Padding(
                            padding: EdgeInsets.only(right: 10.w),
                            child: CupertinoSwitch(
                                value:false,
                                activeTrackColor: Theme.of(context).colorScheme.textPrimary,
                                inactiveTrackColor: ColorPath.athensGrey5,
                                thumbColor: Colors.white,
                                onChanged: (value){

                                }),
                          )),
                    ),
                  ],
                )
            ),

          ],
        ),
      ),
    );
  }
}
