import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_asset.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/core/constants/named_routes.dart';
import 'package:winit_agent/core/utilities/navigator.dart';
import 'package:winit_agent/ui/pages/profile/manage_bank_accounts/verify_bank_details.dart';
import 'package:winit_agent/ui/widgets/clickable.dart';
import 'package:winit_agent/ui/widgets/custom_svg.dart';

import '../../../core/constants/app_dimension.dart';
import '../../../core/constants/color_path.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/screen_title.dart';

class AddBankDetails extends StatefulWidget {
  const AddBankDetails({super.key});

  @override
  State<AddBankDetails> createState() => _AddBankDetailsState();
}

class _AddBankDetailsState extends State<AddBankDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'Add Bank Account Details',
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: AppDimension.paddingTop, horizontal: AppDimension.paddingLeft),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ScreenTitle(title: 'Add Bank Account Information',
                          subtitle: 'You can only add a maximum of two (2) bank accounts.'
                      ),
                      SizedBox(height: 24.h,),
                      ListView.separated(
                        itemCount: 2,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              vertical: 16.h,
                              horizontal: 16.w
                            ),
                            decoration: BoxDecoration(
                              color: ColorPath.athensGrey2,
                              border: Border.all(color: ColorPath.athensGrey3, width: 1.5.w),
                              borderRadius: BorderRadius.all(Radius.circular(8.r))
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '006900592',
                                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                            fontWeight: FontWeight.w700,
                                            color: ColorPath.blueBlue
                                        ),
                                      ),
                                      SizedBox(height: 1.h,),
                                      Text(
                                        'Access bank | Adekunle LLC',
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                            fontWeight: FontWeight.w400,
                                            color: Theme.of(context).colorScheme.textPrimary
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                SizedBox(width: 10.w,),
                                CustomAssetViewer(asset: AppAsset.delete, height: 24.h, width: 24.w,)
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 16.h,);
                        },
                      ),
                      SizedBox(height: 24.h,),
                      Clickable(
                        onPressed: (){
                          pushNavigation(context: context, widget: const VerifyBankDetails(), routeName: NamedRoutes.verifyBankDetails);
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              vertical: 12.h,
                              horizontal: 16.w
                          ),
                          decoration: BoxDecoration(
                              color: ColorPath.athensGrey2,
                              border: Border.all(color: ColorPath.athensGrey3, width: 1.5.w),
                              borderRadius: BorderRadius.all(Radius.circular(8.r))
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Bank Account',
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: Theme.of(context).colorScheme.textPrimary
                                      ),
                                    ),
                                    SizedBox(height: 1.h,),
                                    Text(
                                      'Add account Details for Withdrawal',
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: Theme.of(context).colorScheme.textTertiary
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                              SizedBox(width: 10.w,),
                              Container(
                                height: 48.h,
                                width: 48.w,
                                decoration: BoxDecoration(
                                  color: ColorPath.charcoalBlack,
                                  shape: BoxShape.circle
                                ),
                                child: Center(
                                  child: CustomAssetViewer(asset: AppAsset.add),
                                ),
                              )
                            ],
                          ),
                        ),
                      )






                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h,),
              CustomButton(
                  buttonText: 'Continue',
                  onPressed: () {

                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}
