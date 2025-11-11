import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_asset.dart';
import 'package:winit_agent/core/constants/app_dimension.dart';
import 'package:winit_agent/core/constants/named_routes.dart';
import 'package:winit_agent/core/utilities/navigator.dart';
import 'package:winit_agent/ui/pages/onboarding/identity_verification/bvn/bvn_verification.dart';
import 'package:winit_agent/ui/widgets/onboarding/identity_details.dart';
import 'package:winit_agent/ui/widgets/onboarding/identity_verification_notes.dart';
import 'package:winit_agent/ui/widgets/onboarding/identity_verification_title.dart';
import '../../../../../core/constants/color_path.dart';
import '../../../../widgets/custom_appbar.dart';
import '../../../../widgets/custom_button.dart';

class BvnRequirement extends StatefulWidget {
  const BvnRequirement({super.key});

  @override
  State<BvnRequirement> createState() => _BvnRequirementState();
}

class _BvnRequirementState extends State<BvnRequirement> {

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
                      IdentityVerificationTitle(
                          title: 'You are almost There 🚀 🏃 , Why We need your',
                          subtitle: 'For secure identity validation and Wallet transaction',
                          highlightedText: 'BVN',
                          imageAsset: AppAsset.building2,
                          assetBg: ColorPath.linenBrown,
                          highlightedTextColor: ColorPath.piperBrown
                      ),
                      SizedBox(height: 24.h,),
                      IdentityDetails(
                          title: 'NIN Identity Validation Completed',
                          subtitle: 'Personal information as retrieved \nfrom your NIN',
                          fullName: 'Adekunle, Ibrahim Olamide',
                          gender:  'Male',
                          phone: '+234 90 4747 2791',
                          dob: 'June 20, 2000'
                      ),
                      SizedBox(height: 24.h,),
                      IdentityVerificationNotes(
                          asset: AppAsset.bulletPoint2,
                          notes: [
                            {
                              'title': 'Wallet Creation',
                              'subtitle': 'Your BVN is required to set up your WinIT Wallet.'
                            },
                            {
                              'title': 'Primary Financial ID',
                              'subtitle': 'BVN is the main way to identify you within Nigeria’s financial system.'
                            },
                            {
                              'title': 'Data Consistency',
                              'subtitle': 'Your BVN details (name, gender, date of birth) must match your NIN for verification. '
                            },
                            {
                              'title': 'Security',
                              'subtitle': 'Collecting your BVN helps us keep your account safe and trusted.'
                            }
                          ]
                      )

                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h,),
              CustomButton(
                  buttonText: 'Proceed',
                  onPressed: () {
                    pushNavigation(context: context, widget: const BvnVerification(), routeName: NamedRoutes.bvnVerification);
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}
