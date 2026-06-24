import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/core/data/view_models/onboarding/identity_verification_vm.dart';

import '../../../../core/constants/app_dimension.dart';
import '../../../../core/constants/color_path.dart';
import '../../../../core/constants/named_routes.dart';
import '../../../../core/utilities/navigator.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/onboarding/identity_details.dart';
import '../../../widgets/screen_title.dart';
import '../../profile/agent_information/personal_details.dart';

class IdentityVerificationResult extends ConsumerStatefulWidget {
  const IdentityVerificationResult({super.key});

  @override
  ConsumerState<IdentityVerificationResult> createState() => _IdentityVerificationResultState();
}

class _IdentityVerificationResultState extends ConsumerState<IdentityVerificationResult> {

  @override
  Widget build(BuildContext context) {
    final vm = ref.read(identificationViewModel);
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
                      ScreenTitle(title: vm.isBvnVerified ? 'Congratulations! Your BVN and NIN details match':'NIN and BVN Details Doesn’t match',
                          subtitle: ''
                      ),
                      SizedBox(height: 32.h,),
                      IdentityDetails(
                          title: 'NIN Identity Validation Completed',
                          subtitle: 'Personal information as retrieved \nfrom your NIN',
                          fullName: '${vm.ninFirstname} ${vm.ninLastname}',
                          gender:  vm.ninGender,
                          phone: vm.ninPhone,
                          dob: vm.ninDob,
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
                          fullName: '${vm.bvnFirstname} ${vm.bvnLastname}',
                          gender:  vm.bvnGender,
                          phone: vm.bvnPhone,
                          dob: vm.bvnDob,
                          bgColor: vm.isBvnVerified ? null : ColorPath.pippinPink,
                          borderColor: vm.isBvnVerified ? null : ColorPath.ribbonRed,
                          titleColor:  vm.isBvnVerified ? null : ColorPath.ribbonRed,
                          nameColor:  (vm.firstnameMatched && vm.lastnameMatched) ? null : ColorPath.ribbonRed,
                          genderColor: vm.genderMatched ? null : ColorPath.ribbonRed,
                          phoneColor: vm.phoneMatched ? null : ColorPath.ribbonRed,
                          dobColor: vm.dobMatched ? null : ColorPath.ribbonRed,
                          onChanged: (value){
                          },
                        ),
                      ),
                      if(!vm.isBvnVerified)Container(
                        margin: EdgeInsets.only(top: 16.h),
                        padding: EdgeInsets.symmetric(
                            vertical: 12.h,
                            horizontal: 12.w
                        ),
                        decoration: BoxDecoration(
                            color: ColorPath.pippinPink,
                            border: Border.all(color: ColorPath.ribbonRed, width: 1.w),
                            borderRadius: BorderRadius.all(Radius.circular(12.r))
                        ),
                        child: Text(
                          'Your NIN details do not match your BVN records, so we can’t continue with your account setup at this time.   Please review and correct your information with the appropriate authority (either NIN or BVN).   Once updated, you can return to complete your agent registration by logging in with your Agent ID (phone number) and password',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic,
                              color: Theme.of(context).colorScheme.textPrimary
                          ),
                        ),
                      )


                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h,),
              if(vm.isBvnVerified)CustomButton(
                  buttonText: 'Continue Account Setup',
                  onPressed: () {
                    pushAndClearNavigation(context: context, widget: const PersonalDetails(),  routeName: NamedRoutes.personalDetails, clearRoute: NamedRoutes.login,);
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}
