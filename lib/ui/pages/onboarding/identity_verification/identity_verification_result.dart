import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_dimension.dart';
import '../../../../core/constants/color_path.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/onboarding/identity_details.dart';
import '../../../widgets/screen_title.dart';

class IdentityVerificationResult extends StatefulWidget {
  const IdentityVerificationResult({super.key});

  @override
  State<IdentityVerificationResult> createState() => _IdentityVerificationResultState();
}

class _IdentityVerificationResultState extends State<IdentityVerificationResult> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'BVN Verification Process',
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
                      ScreenTitle(title: 'Congratulations! Your BVN and NIN details match',
                          subtitle: ''
                      ),
                      SizedBox(height: 32.h,),
                      IdentityDetails(
                          title: 'NIN Identity Validation Completed',
                          subtitle: 'Personal information as retrieved \nfrom your NIN',
                          fullName: 'Adekunle, Ibrahim Olamide',
                          gender:  'Male',
                          phone: '+234 90 4747 2791',
                          dob: 'June 20, 2000',
                          onChanged: (value){
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 34.w),
                        child: Transform.translate(
                          offset: Offset(0, -5.h),
                          child: Column(
                            children: [
                              Container(
                                height: 8.h,
                                width: 8.w,
                                decoration: BoxDecoration(
                                    color: ColorPath.hazeGreen,
                                    shape: BoxShape.circle
                                ),
                              ),
                              Container(
                                height: 32.h,
                                width: 1.w,
                                color: ColorPath.hazeGreen,
                              ),
                              Container(
                                height: 8.h,
                                width: 8.w,
                                decoration: BoxDecoration(
                                    color: ColorPath.hazeGreen,
                                    shape: BoxShape.circle
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(0, -8.h),
                        child: IdentityDetails(
                          title: 'BVN Identity Validation Completed',
                          subtitle: 'Personal information as retrieved\n from your BVN',
                          fullName: 'Adekunle, Ibrahim Olamide',
                          gender:  'Male',
                          phone: '+234 90 4747 2791',
                          dob: 'June 20, 2000',
                          bgColor: ColorPath.pippinPink,
                          borderColor: ColorPath.ribbonRed,
                          titleColor: ColorPath.ribbonRed,
                          nameColor: ColorPath.ribbonRed,
                          onChanged: (value){
                          },
                        ),
                      ),
                      SizedBox(height: 24.h,),


                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h,),
              CustomButton(
                  buttonText: 'Continue Account Setup',
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
