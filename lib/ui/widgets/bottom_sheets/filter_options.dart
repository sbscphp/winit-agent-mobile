import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/ui/widgets/custom_radio_button.dart';
import 'package:winit_agent/ui/widgets/winit_container.dart';
import '../../../core/utilities/navigator.dart';
import '../clickable.dart';
import '../close_icon.dart';


class FilterOptions extends StatefulWidget {
  final String label;
  final String subtitle;
  final List<String> options;
  final ValueChanged<String> selectedOption;
  final String? initialValue;
  const FilterOptions({super.key, this.initialValue, required this.label, required this.subtitle, required this.options, required this.selectedOption});

  @override
  State<FilterOptions> createState() => _FilterOptionsState();
}

class _FilterOptionsState extends State<FilterOptions> {
  String? _selectedOption;

  @override
  void initState() {
    _selectedOption = widget.initialValue;
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
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.label,
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
                CloseIcon()

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
                  final isSelected = _selectedOption?.toLowerCase() == option.toLowerCase();
                  return Clickable(
                    onPressed: (){
                      widget.selectedOption('sample');
                      popNavigation(context: context);
                    },
                    child: WinitContainer(
                      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                        child: Row(
                          children: [
                            CustomRadioButton(
                              disableClick: true,
                              value: isSelected,
                            ),
                            SizedBox(width: 8.w,),
                            Expanded(
                              child: Text(
                                option,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context).colorScheme.textSecondary
                                ),
                              ),
                            )


                          ],
                        )
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
