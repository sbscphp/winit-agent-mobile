import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/core/utilities/navigator.dart';
import 'package:winit_agent/ui/widgets/clickable.dart';
import 'package:winit_agent/ui/widgets/custom_radio_button.dart';
import 'package:winit_agent/ui/widgets/text_fields/search_field.dart';
import '../../../core/constants/color_path.dart';
import '../close_icon.dart';

class Banks extends StatelessWidget {
  const Banks({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 24.h,
        left: 17.w,
        right: 17.w,
        bottom: 16.h
      ),
      child: SafeArea(
        child: Column(
          //mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bank',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: Theme.of(context).colorScheme.textPrimary
                        ),
                      ),
                      SizedBox(height: 4.h,),
                      Text(
                        'Select a Bank',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.textTertiary
                        ),
                      ),

                    ],
                  ),
                ),
                CloseIcon()

              ],
            ),
            SizedBox(height: 24.h,),
            SearchField(
              hintText: 'Enter Bank name',
              keyboardType: TextInputType.text,
              onChanged: (value){

              },
            ),
            SizedBox(height: 29.h,),
            Expanded(
              child: ListView.separated(
                itemCount: 33,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemBuilder: (BuildContext context, int index) {
                  return Clickable(
                    onPressed: (){
                      popNavigation(context: context);
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                      decoration: BoxDecoration(
                        border: Border.all(color: ColorPath.athensGrey4, width: 1.w),
                        borderRadius: BorderRadius.all(Radius.circular(8.r))
                      ),
                      child: Row(
                        children: [
                          CustomRadioButton(
                            onchanged: (value){

                            },
                          ),
                          SizedBox(width: 8.w,),
                          Expanded(
                            child:   Text(
                              'Access Bank PLC',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).colorScheme.textSecondary
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 16.h,);
                },
              ),
            )

          ],
        ),
      ),
    );
  }
}
