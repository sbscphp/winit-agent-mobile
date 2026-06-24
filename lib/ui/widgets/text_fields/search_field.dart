import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_asset.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/ui/widgets/clickable.dart';
import 'package:winit_agent/ui/widgets/custom_svg.dart';



class SearchField extends StatefulWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;
  final double? textSize;
  final Color textColor;
  final bool obscure;
  final  Widget? suffixIcon;
  final  Widget? prefixIcon;
  final  Widget? prefix;
  final String hintText;
  final String bottomHintText;
  final double? hintSize;
  final Color? hintColor;
  final bool enabled;
  final bool readOnly;
  final bool isCompulsory;


  const SearchField(
      {super.key,
        this.controller,
        this.onChanged,
        this.keyboardType = TextInputType.text,
        this.textSize,
        this.textColor = Colors.black,
        this.obscure = false,
        this.suffixIcon,
        this.hintText = '',
        this.hintSize,
        this.hintColor,
        this.enabled = true,
        this.readOnly = false,
        this.prefixIcon,
        this.bottomHintText = '',
        this.isCompulsory = true,
        this.prefix
      });

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {

  final _text = TextEditingController();

  @override
  void dispose() {
   _text.dispose();
    super.dispose();
  }





  @override
  Widget build(BuildContext context) {

    final colorScheme = Theme.of(context).colorScheme;

    return Container(
     height: 40.h,
      padding: EdgeInsets.symmetric(horizontal: 0.w),
      width: double.infinity,
      decoration: BoxDecoration(
          color: colorScheme.searchFieldFillColor,
          borderRadius: BorderRadius.all(Radius.circular(32.r))
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomAssetViewer(asset: AppAsset.searchPrefixIcon, height: 40.h, width: 40.w,),
          Expanded(
            child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                enabled: widget.enabled,
                readOnly: widget.readOnly,
                controller: _text,
                obscureText: widget.obscure,
                textAlign: TextAlign.start,
                style:Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: widget.textSize?.sp,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.brandColor,
                ),
                onChanged: widget.onChanged,
                keyboardType: widget.keyboardType,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: widget.hintText,
                  hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.textSecondary
                  ),
                  suffixIcon: widget.suffixIcon,
                  suffixIconConstraints: BoxConstraints(
                    minWidth: 25.w,
                    minHeight: 25.h,
                  ),
                  prefix: widget.prefix,
                  prefixIconConstraints: BoxConstraints(
                    minWidth: 25.w,
                    minHeight: 25.h,
                  ),
                  //contentPadding: EdgeInsets.only(right: 16.w, top: 9.h, bottom: 9.h),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                )
            ),
          ),
          Clickable(
            onPressed: (){
              setState(() {
                _text.clear();
              });
            },
              child: CustomAssetViewer(asset: AppAsset.searchSuffixIcon, height: 40.h, width: 40.w,)),
        ],
      ),
    );

  }
}
