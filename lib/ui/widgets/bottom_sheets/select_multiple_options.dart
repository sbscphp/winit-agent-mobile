import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/core/utilities/navigator.dart';
import 'package:winit_agent/ui/widgets/clickable.dart';
import 'package:winit_agent/ui/widgets/custom_check_box.dart';
import 'package:winit_agent/ui/widgets/custom_radio_button.dart';
import 'package:winit_agent/ui/widgets/custom_svg.dart';
import 'package:winit_agent/ui/widgets/show_flush_bar.dart';
import 'package:winit_agent/ui/widgets/text_fields/search_field.dart';

import '../../../core/constants/app_asset.dart';
import '../../../core/constants/color_path.dart';
import '../custom_button.dart';

class SelectMultipleOptions extends StatefulWidget {
  final List<String> initialItems;
  final List<String> options;
  final String title;
  final String subtitle;
  final ValueChanged<List<String>> onDone;

  const SelectMultipleOptions({super.key, required this.options, required this.initialItems, required this.title, required this.subtitle, required this.onDone});

  @override
  State<SelectMultipleOptions> createState() => _SelectMultipleOptionsState();
}

class _SelectMultipleOptionsState extends State<SelectMultipleOptions> {

  List<String> selectedItems = [];

  @override
  void initState() {
    if(widget.initialItems.isNotEmpty){
      selectedItems = List.from(widget.initialItems);
    }
    super.initState();
  }


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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
                              widget.title,
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: Theme.of(context).colorScheme.textPrimary
                              ),
                            ),
                            SizedBox(height: 4.h,),
                            Text(
                              widget.subtitle,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context).colorScheme.textTertiary
                              ),
                            ),

                          ],
                        ),
                      ),
                      Clickable(
                          onPressed: ()=>popNavigation(context: context),
                          child: CustomAssetViewer(asset: AppAsset.close))

                    ],
                  ),
                  SizedBox(height: 16.h,),
                  Flexible(
                    child: ListView.separated(
                      itemCount: widget.options.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemBuilder: (BuildContext context, int index) {
                        final option = widget.options[index];
                        final isSelected = selectedItems.contains(option);
                        return Clickable(
                          onPressed: (){
                            handleClick(isSelected, option);
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
                                Container(
                                  height: 20.h,
                                  width: 20.w,
                                  padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 3.w),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: ColorPath.mischkaGrey, width: 1.w),
                                      borderRadius: BorderRadius.all(Radius.circular(6.r))
                                  ),
                                  child: Center(
                                    child: isSelected ? CustomAssetViewer(asset: AppAsset.checkMark, height: 14.h, width: 14.w,):SizedBox.shrink(),
                                  ),
                                ),
                                SizedBox(width: 8.w,),
                                Expanded(
                                  child:Text(
                                   option,
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
            SizedBox(height: 40.h,),
            CustomButton(
                buttonText: 'Done',
                onPressed: () {
                 if(selectedItems.isEmpty){
                   showFlushBar(
                       context: context,
                       message: 'Kindly select an option to proceed',
                     success: false
                   );
                   return;
                 }
                 widget.onDone(selectedItems);
                 popNavigation(context: context);
                }
            )

          ],
        ),
      ),
    );
  }

  handleClick(bool value, String option){
    if(value){
      print('remove>>>');
      selectedItems.remove(option);
    }else{
      print('add>>>');
      selectedItems.add(option);
    }
    print('length:${selectedItems.length}>>>');
    setState(() {});
  }
}
