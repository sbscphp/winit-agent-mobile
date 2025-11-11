import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/color_path.dart';
import '../custom_expansion_tile.dart';

class IdentityDetails extends StatefulWidget {
  final String title;
  final String subtitle;
  final String fullName;
  final String gender;
  final String phone;
  final String dob;
  final GlobalKey? containerKey;
  final ValueChanged<bool>? onChanged;
  final Color? titleColor;
  final Color? nameColor;
  final Color? genderColor;
  final Color? phoneColor;
  final Color? dobColor;
  final Color? bgColor;
  final Color? borderColor;
  const IdentityDetails({super.key, this.bgColor, this.borderColor, this.titleColor, this.nameColor, this.genderColor, this.phoneColor, this.dobColor,  this.onChanged, this.containerKey, required this.title, required this.subtitle, required this.fullName, required this.gender, required this.phone, required this.dob});

  @override
  State<IdentityDetails> createState() => _IdentityDetailsState();
}

class _IdentityDetailsState extends State<IdentityDetails> {

  bool _isExpanded = false;


  @override
  Widget build(BuildContext context) {
    return CustomExpansionTile(
      containerKey: widget.containerKey,
      bgColor: widget.bgColor,
      borderColor: widget.borderColor,
      initiallyExpanded: false,
      onExpansionChanged: (value){
        if(widget.onChanged != null){
          widget.onChanged!(value);
        }
        setState(() {
          setState(() {
            _isExpanded = value;
          });

        });
      },
      showSuffixIcon: false,
      primaryChild: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                 widget.title,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: widget.titleColor ?? ColorPath.hazeGreen
                  ),
                ),
                SizedBox(height: 4.h,),
                Text(
                 widget.subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: ColorPath.troutGrey
                  ),
                ),


              ],
            ),
          ),
          SizedBox(width: 10.w,),
          Icon(_isExpanded ? Icons.keyboard_arrow_up:Icons.keyboard_arrow_down, size: 20, color: widget.titleColor ?? ColorPath.hazeGreen,)

        ],
      ),
      secondaryChild: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Legal Name ',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: ColorPath.charcoalBlack
                ),
              ),
              SizedBox(width: 10.w,),
              Text(
                widget.fullName,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: widget.nameColor ?? ColorPath.charcoalBlack
                ),
              ),


            ],
          ),
          SizedBox(height: 8.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Gender',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: widget.genderColor ?? ColorPath.charcoalBlack
                ),
              ),
              SizedBox(width: 10.w,),
              Text(
                widget.gender,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: ColorPath.charcoalBlack
                ),
              ),


            ],
          ),
          SizedBox(height: 8.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Phone number',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: ColorPath.charcoalBlack
                ),
              ),
              SizedBox(width: 10.w,),
              Text(
                widget.phone,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: widget.phoneColor ?? ColorPath.charcoalBlack
                ),
              ),


            ],
          ),
          SizedBox(height: 8.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Date of Birth',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: ColorPath.charcoalBlack
                ),
              ),
              SizedBox(width: 10.w,),
              Text(
                widget.dob,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: widget.dobColor ?? ColorPath.charcoalBlack
                ),
              ),


            ],
          ),

        ],
      ),
    );
  }
}
