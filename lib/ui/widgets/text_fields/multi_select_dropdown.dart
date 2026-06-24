import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/ui/widgets/bottom_sheets/select_multiple_options.dart';
import 'package:winit_agent/ui/widgets/clickable.dart';

import '../../../core/constants/color_path.dart';
import '../bottom_sheets/base_bottom_sheet.dart';

class MultiSelectDropdown extends StatefulWidget {
  final String label;
  final String hintText;
  final bool isCompulsory;
  final List<String> options;
  final List<String>? initialValues;
  final String dropdownTitle;
  final String dropdownSubtitle;
  final ValueChanged<List<String>> selectedItemsReturned;
  const MultiSelectDropdown({super.key, this.initialValues, required this.label, required this.hintText, this.isCompulsory = false, required this.options, required this.dropdownTitle, required this.dropdownSubtitle, required this.selectedItemsReturned});

  @override
  State<MultiSelectDropdown> createState() => _MultiSelectDropdownState();
}

class _MultiSelectDropdownState extends State<MultiSelectDropdown> {

  List<String> selectedValues = [];

  @override
  void initState() {
    if(widget.initialValues != null){
      selectedValues = List.from(widget.initialValues!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              widget.label,
              style: textTheme.bodySmall?.copyWith(
                color: ColorPath.oxfordBlue,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (widget.isCompulsory) SizedBox(width: 5.w),
            if (widget.isCompulsory)
              Text(
                '*',
                style: textTheme.bodyMedium?.copyWith(
                  color: ColorPath.ribbonRed,
                  fontWeight: FontWeight.w500,
                ),
              ),
          ],
        ),
        SizedBox(height: 6.h,),
        Clickable(
          onPressed: (){
            baseBottomSheet(
              context: context,
              content: SelectMultipleOptions(
                  options: widget.options,
                  initialItems: selectedValues,
                  title: widget.dropdownTitle,
                  subtitle: widget.dropdownSubtitle,
                  onDone: (value){
                    setState(() {
                      selectedValues = value;
                    });
                    widget.selectedItemsReturned(selectedValues);
                  }
              ),
            );
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: 14.w,
              vertical: 10.h
            ),
            decoration: BoxDecoration(
              border: Border.all(color: ColorPath.mischkaGrey, width: 1.w),
              borderRadius: BorderRadius.all(Radius.circular(8.r))
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child:  Text(
                    selectedValues.isNotEmpty ? selectedValues.join(', '):widget.hintText,
                    style: textTheme.bodySmall?.copyWith(
                      color: selectedValues.isNotEmpty ? colorScheme.textPrimary:ColorPath.paleGrey,
                      fontWeight: selectedValues.isNotEmpty ?FontWeight.w500:FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(width: 8.w,),
                Icon(Icons.keyboard_arrow_down, size: 20.w, color: ColorPath.gullGrey,)
              ],
            ),
          ),
        )

      ],
    );
  }
}
