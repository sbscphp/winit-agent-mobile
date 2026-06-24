import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/core/constants/named_routes.dart';
import 'package:winit_agent/core/utilities/navigator.dart';
import 'package:winit_agent/ui/pages/onboarding/identity_verification/nin/nin_requirement.dart';
import '../../../../core/constants/app_asset.dart';
import '../../../../core/constants/app_dimension.dart';
import '../../../../core/constants/color_path.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_painter/dotted_border.dart';
import '../../widgets/custom_svg.dart';
import '../../widgets/screen_title.dart';
import '../bottom_nav.dart';

class OnboardingSuccessful extends StatefulWidget {
  final bool isTemporaryOnboarding;
  final String agentId;
  const OnboardingSuccessful({super.key, this.isTemporaryOnboarding = true, required this.agentId});

  @override
  State<OnboardingSuccessful> createState() => _OnboardingSuccessfulState();
}

class _OnboardingSuccessfulState extends State<OnboardingSuccessful> {

  List<String> temporary = [
    'Congratulations! Your WinIT Agent account has been created. You can continue your onboarding or registration at a later time.',
    'For now, your registered phone number serves as your temporary Agent ID and can be used to log in. A permanent Agent ID will be assigned once you complete the full self-onboarding process. '
  ];
  List<String> permanent = [
    'Congratulations! You have successfully completed your self-onboarding process. A permanent Agent ID has now been issued to you, which should be used for all future logins. '
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: widget.isTemporaryOnboarding ? 'Create a WinIt Agent Account':'WinIt Agent Account Created',
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
                        ScreenTitle(title: 'Agent Account Created Successfully',
                            subtitle: 'Account Successfully Created.'
                        ),
                        SizedBox(height: 24.h,),
                        CustomPaint(
                          painter: DottedBorder(
                              color: ColorPath.fogPurple,
                              borderRadius: BorderRadius.all(Radius.circular(16.r))
                          ),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                            decoration: BoxDecoration(
                              color: ColorPath.chalkBlue,
                              borderRadius: BorderRadius.all(Radius.circular(16.r))
                            ),
                            child: Column(
                              children: [
                                Text(
                                  widget.isTemporaryOnboarding ? 'Your Temporary Agent ID':'Your Agent ID',
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context).colorScheme.textSecondary
                                  ),
                                ),
                                SizedBox(height: 6.h,),
                                Text(
                                  widget.agentId,
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.w800,
                                      color: ColorPath.blueBlue
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h,),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            widget.isTemporaryOnboarding ? ' Your registered Phone Number is your temporary Agent ID.':'This is your permanent Agent ID. ',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).colorScheme.textTertiary
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 32.h,),
                        ListView.separated(
                          itemCount: widget.isTemporaryOnboarding ? temporary.length : permanent.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemBuilder: (BuildContext context, int index) {
                            final label = widget.isTemporaryOnboarding ? temporary[index]:permanent[index];
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomAssetViewer(asset: AppAsset.bulletPoint, height: 18.35.h, width: 24.w,),
                                SizedBox(width: 16.w,),
                                Expanded(
                                  child:  Text(
                                    label,
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: Theme.of(context).colorScheme.textSecondary
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 24.h,);
                          },
                        )




                      ],
                    ),
                  ),
                ),
                CustomButton(
                    buttonText: widget.isTemporaryOnboarding ? 'Continue Onboarding':'Go to Dashboard',
                    onPressed: () async{

                      if(widget.isTemporaryOnboarding){
                        replaceNavigation(context: context, widget: const NinRequirement(), routeName: NamedRoutes.ninRequirement);
                        return;
                      }

                      //completed onboarding ... route user into the app
                      pushAndClearNavigation(context: context, widget: BottomNav(), routeName: NamedRoutes.bottomNav, clearRoute: NamedRoutes.login);



                    }
                ),
              ],
            ),
          )
      ),
    );
  }
}
