import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/core/constants/named_routes.dart';
import 'package:winit_agent/core/utilities/navigator.dart';
import 'package:winit_agent/ui/pages/onboarding/add_bank_details.dart';

import '../../../../core/constants/app_dimension.dart';
import '../../../../core/constants/color_path.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_button.dart';

class IdentityVerificationSummary extends StatefulWidget {
  const IdentityVerificationSummary({super.key});

  @override
  State<IdentityVerificationSummary> createState() => _IdentityVerificationSummaryState();
}

class _IdentityVerificationSummaryState extends State<IdentityVerificationSummary> {
  @override
  Widget build(BuildContext context) {
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
                          1+1==2 ? 'Congratulations! Your BVN and NIN details match':'NIN and BVN Details Doesn’t match',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: Theme.of(context).colorScheme.textPrimary
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      if(1+1==3)Container(
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
              CustomButton(
                  buttonText: 'Continue Account Setup',
                  onPressed: () {
                    pushNavigation(context: context, widget: const AddBankDetails(), routeName: NamedRoutes.addBankDetails);
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}
