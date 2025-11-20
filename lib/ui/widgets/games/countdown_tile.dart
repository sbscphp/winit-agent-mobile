import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';

import '../../../core/constants/color_path.dart';
import '../clickable.dart';
import '../count_down_timer.dart';
import '../countdown_circle.dart';

class CountdownTile extends StatefulWidget {
  final bool? initiallyExpanded;
  const CountdownTile({super.key, this.initiallyExpanded = false});

  @override
  State<CountdownTile> createState() => _CountdownTileState();
}

class _CountdownTileState extends State<CountdownTile> {

  bool _isExpanded = false;

  @override
  void initState() {
    _isExpanded = widget.initiallyExpanded!;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Clickable(
            onPressed: (){
              setState(() {
                _isExpanded = !_isExpanded;
              });

            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Time Left to Join the Draw',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                      color: ColorPath.ribbonRed
                  ),
                ),
                SizedBox(width: 10.w,),
                Row(
                  children: [
                    Text(
                      _isExpanded ? 'Minimise':'Expand',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.textSecondary
                      ),
                    ),
                    SizedBox(width: 8.w,),
                    Icon(_isExpanded ?Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded, size: 25, color: Theme.of(context).colorScheme.textPrimary,)
                  ],
                )
              ],
            ),
          ),
          AnimatedCrossFade(
            firstChild: Container(),
            secondChild: Padding(
              padding: EdgeInsets.only(top: 8.h),
              child:  CountdownTimer(
                endTime: DateTime.now().add(Duration(days: 5)),
                onEnd: (){

                },
                builder: (_, time) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CountdownCircle(label: 'Days', value: time.days.toString().padLeft(2, '0'), textColor: Theme.of(context).colorScheme.whiteText),
                    SizedBox(width: 11.47.w,),
                    CountdownCircle(label: 'Hours', value: time.hours.toString().padLeft(2, '0'), textColor: Theme.of(context).colorScheme.whiteText),
                    SizedBox(width: 11.47.w,),
                    CountdownCircle(label: 'Mins', value: time.minutes.toString().padLeft(2, '0'), textColor: Theme.of(context).colorScheme.whiteText),
                    SizedBox(width: 11.47.w,),
                    CountdownCircle(label: 'Secs', value: time.seconds.toString().padLeft(2, '0'), textColor: Theme.of(context).colorScheme.whiteText),
                  ],
                ),
              ),
            ),
            crossFadeState: _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 200),
          ),
        ],
      ),
    );
  }
}
