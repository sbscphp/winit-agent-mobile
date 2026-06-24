import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/core/utilities/extensions/color_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/color_path.dart';
import 'clickable.dart';


class CustomExpansionTile extends StatefulWidget {
  final Widget primaryChild;
  final Widget secondaryChild;
  final bool? initiallyExpanded;
  final bool showSuffixIcon;
  final ValueChanged<bool>? onExpansionChanged;
  final GlobalKey? containerKey;
  final Color? bgColor;
  final Color? borderColor;

  const CustomExpansionTile({
    super.key,
    required this.primaryChild,
    required this.secondaryChild,
    this.initiallyExpanded = false,
    this.showSuffixIcon = true,
    this.onExpansionChanged,
    this.containerKey,
    this.borderColor,
    this.bgColor
  });

  @override
  State<CustomExpansionTile> createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile>{
  bool _isExpanded = false;

  @override
  void initState() {
    _isExpanded = widget.initiallyExpanded!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      key: widget.containerKey,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          vertical: 16.h,
          horizontal: 16.w
      ),
      decoration: BoxDecoration(
        color: widget.bgColor?? ColorPath.scandalGreen,
        border: Border.all(color: widget.borderColor ?? ColorPath.hazeGreen, width: 1.w),
        borderRadius: BorderRadius.all(Radius.circular(16.r)),
      ),
      child: Column(
        children: <Widget>[
          Clickable(
            onPressed: (){
              setState(() {
                _isExpanded = !_isExpanded;
              });
              if(widget.onExpansionChanged != null)widget.onExpansionChanged!(_isExpanded);
            },
            child: Row(
              children: [
                Expanded(
                  child: widget.primaryChild,
                ),
                if(widget.showSuffixIcon)SizedBox(width: 20.w,),
                if(widget.showSuffixIcon)Icon(_isExpanded ?Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded, size: 25, color: Theme.of(context).colorScheme.blackText.withCustomOpacity(0.85),)
              ],
            ),
          ),
          AnimatedCrossFade(
            firstChild: Container(),
            secondChild: Padding(
              padding: EdgeInsets.only(top: 16.h),
              child: widget.secondaryChild,
            ),
            crossFadeState: _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 200),
          ),
        ],
      ),
    );
  }
}