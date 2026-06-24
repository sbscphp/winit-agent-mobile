import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_asset.dart';
import 'package:winit_agent/core/constants/app_dimension.dart';
import 'package:winit_agent/core/constants/named_routes.dart';
import 'package:winit_agent/core/utilities/navigator.dart';
import 'package:winit_agent/ui/pages/onboarding/identity_verification/nin/nin_verification.dart';
import 'package:winit_agent/ui/widgets/onboarding/identity_verification_notes.dart';
import 'package:winit_agent/ui/widgets/onboarding/identity_verification_title.dart';
import '../../../../../core/constants/color_path.dart';
import '../../../../widgets/custom_appbar.dart';
import '../../../../widgets/custom_button.dart';

class NinRequirement extends StatefulWidget {
  const NinRequirement({super.key});

  @override
  State<NinRequirement> createState() => _NinRequirementState();
}

class _NinRequirementState extends State<NinRequirement> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'Identity Verification with NIN',
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
                          title: 'Identity Verification Process Using',
                          subtitle: 'Account Successfully Created. Follow these quick steps to securely verify your identity.',
                          highlightedText: 'NIN',
                          imageAsset: AppAsset.avatar,
                          assetBg: ColorPath.chalkBlue,
                          highlightedTextColor: ColorPath.blueBlue
                      ),
                      SizedBox(height: 32.h,),
                      IdentityVerificationNotes(
                        asset: AppAsset.bulletPoint,
                          notes: [
                            {
                              'title': 'Provide Your NIN',
                              'subtitle': 'Enter your National Identification Number (NIN) for verification.'
                            },
                            {
                              'title': 'Liveness Check',
                              'subtitle': 'Take a quick selfie so we can confirm your identity, then your identity verification will then be complete.'
                            },
                            {
                              'title': 'Provide your BVN',
                              'subtitle': 'BVN is required for further identity validation and to set up your WinIT Agent Wallet..'
                            }
                          ]
                      )

                    ],
                  ),
                ),
              ),
              CustomButton(
                  buttonText: 'Proceed',
                  onPressed: () {
                    pushNavigation(context: context, widget: const NinVerification(), routeName: NamedRoutes.ninVerification);
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}
