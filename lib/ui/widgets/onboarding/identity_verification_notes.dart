import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import '../custom_divider.dart';
import '../custom_svg.dart';

class IdentityVerificationNotes extends StatelessWidget {
  final List<Map<String, dynamic>> notes;
  final String asset;
  const IdentityVerificationNotes({super.key, required this.asset, required this.notes});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: notes.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemBuilder: (BuildContext context, int index) {
        final note = notes[index];
        final title = note['title'];
        final subtitle = note['subtitle'];
        final length = note.length;

        if(length == 1){
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAssetViewer(asset: asset, height: 14.h, width: 14.w,),
              SizedBox(width:16.w,),
              Expanded(
                child:Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.textSecondary
                  ),
                ),
              )
            ],
          );
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAssetViewer(asset: asset, height: 14.h, width: 14.w,),
            SizedBox(width:16.w,),
            Expanded(
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.textPrimary
                    ),
                  ),
                  SizedBox(height: 8.h,),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.textTertiary
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
      separatorBuilder: (context, index) {
        final note = notes[index];
        final length = note.length;
        if(length == 1){
          return SizedBox(height: 24.h,);
        }
        return CustomDivider(
          equalVerticalSpace: false,
          verticalSpace: 24.h,
          bottomMargin: 15.h,
        );
      },
    );
  }
}
