import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/core/constants/named_routes.dart';
import 'package:winit_agent/core/data/view_models/onboarding/identity_verification_vm.dart';
import 'package:winit_agent/core/utilities/navigator.dart';
import 'package:winit_agent/ui/pages/onboarding/add_personal_details.dart';
import '../../../../core/constants/app_dimension.dart';
import '../../../../core/constants/color_path.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_button.dart';

class IdentityVerificationSummary extends ConsumerWidget {
  const IdentityVerificationSummary({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.read(identificationViewModel);
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'Identity Verification Summary',
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
                    children: [

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 17.w),
                        child: Text(
                         vm.isBvnVerified ? 'Congratulations! Your BVN and NIN details match':'NIN and BVN Details Doesn’t match',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: Theme.of(context).colorScheme.textPrimary
                          ),
                          textAlign: TextAlign.center,
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
                    pushAndClearNavigation(context: context, widget: const AddPersonalDetails(),  routeName: NamedRoutes.addPersonalDetails, clearRoute: NamedRoutes.login,);
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}


