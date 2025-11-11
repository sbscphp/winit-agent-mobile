import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_asset.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/core/constants/named_routes.dart';
import 'package:winit_agent/core/utilities/navigator.dart';
import 'package:winit_agent/ui/pages/onboarding/identity_verification/bvn/bvn_requirement.dart';
import 'package:winit_agent/ui/widgets/custom_svg.dart';
import '../../../../../core/constants/app_dimension.dart';
import '../../../../../core/constants/color_path.dart';
import '../../../../widgets/custom_appbar.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/onboarding/identity_verification_notes.dart';
import '../../../../widgets/screen_title.dart';

class NinLivelinessCheck extends StatefulWidget {
  const NinLivelinessCheck({super.key});

  @override
  State<NinLivelinessCheck> createState() => _NinLivelinessCheckState();
}

class _NinLivelinessCheckState extends State<NinLivelinessCheck> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'NIN Liveliness Check',
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
                      ScreenTitle(title: 'NIN Liveness Check TIPS',
                          subtitle: 'We want to verify that you are real, live person and not a photo, video, or digital spoof'
                      ),
                      SizedBox(height: 40.h,),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Sample',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic,
                              color:ColorPath.blueBlue
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h,),
                      // Stack(
                      //   clipBehavior: Clip.none,
                      //   children: [
                      //     Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //       children: [
                      //         Column(
                      //           children: [
                      //             Stack(
                      //               clipBehavior: Clip.none,
                      //               children: [
                      //                 LgbtqContainer(
                      //                     isCircle: true,
                      //                     child: Container(
                      //                       height: 74.h,
                      //                       width: 74.w,
                      //                       decoration: BoxDecoration(
                      //                           color: Colors.black,
                      //                           shape: BoxShape.circle
                      //                       ),
                      //                     )
                      //                 ),
                      //                 Positioned(
                      //                     top: 0,
                      //                     bottom: 0,
                      //                     right: -15,
                      //                     child: Center(child: CustomAssetViewer(asset: AppAsset.internet, height: 28.h, width: 28.w,))),
                      //                 Positioned(
                      //                   top: 0,
                      //                   bottom: 0,
                      //                   right: -80,
                      //                   child: Row(
                      //                     mainAxisAlignment: MainAxisAlignment.center,
                      //                     children: [
                      //                       Container(
                      //                         height: 10.h,
                      //                         width: 10.w,
                      //                         decoration: BoxDecoration(
                      //                             color: ColorPath.hazeGreen,
                      //                             shape: BoxShape.circle
                      //                         ),
                      //                       ),
                      //                       Container(
                      //                         height: 2.h,
                      //                         width: 55.w,
                      //                         color: ColorPath.hazeGreen,
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 )
                      //               ],
                      //             ),
                      //             SizedBox(height: 13.h,),
                      //             Text(
                      //               'Picture on',
                      //               style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      //                   fontWeight: FontWeight.w400,
                      //                   color:Theme.of(context).colorScheme.textTertiary
                      //               ),
                      //             ),
                      //             SizedBox(height: 2.h,),
                      //             Text(
                      //               'NIN Slip',
                      //               style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      //                   fontWeight: FontWeight.w600,
                      //                   fontStyle: FontStyle.italic,
                      //                   color:ColorPath.blueBlue
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //         Column(
                      //           children: [
                      //             Stack(
                      //               clipBehavior: Clip.none,
                      //               children: [
                      //                 LgbtqContainer(
                      //                     isCircle: true,
                      //                     child: Container(
                      //                       height: 74.h,
                      //                       width: 74.w,
                      //                       decoration: BoxDecoration(
                      //                           color: Colors.black,
                      //                           shape: BoxShape.circle
                      //                       ),
                      //                     )
                      //                 ),
                      //                 Positioned(
                      //                     top: 0,
                      //                     bottom: 0,
                      //                     left: -15,
                      //                     child: Center(child: CustomAssetViewer(asset: AppAsset.internet, height: 28.h, width: 28.w,))),
                      //                 Positioned(
                      //                   top: 0,
                      //                   bottom: 0,
                      //                   left: -80,
                      //                   child: Row(
                      //                     mainAxisAlignment: MainAxisAlignment.center,
                      //                     children: [
                      //                       Container(
                      //                         height: 2.h,
                      //                         width: 55.w,
                      //                         color: ColorPath.hazeGreen,
                      //                       ),
                      //                       Container(
                      //                         height: 10.h,
                      //                         width: 10.w,
                      //                         decoration: BoxDecoration(
                      //                             color: ColorPath.hazeGreen,
                      //                             shape: BoxShape.circle
                      //                         ),
                      //                       )
                      //                     ],
                      //                   ),
                      //                 )
                      //               ],
                      //             ),
                      //             SizedBox(height: 13.h,),
                      //             Text(
                      //               'Liveliness',
                      //               style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      //                   fontWeight: FontWeight.w600,
                      //                   fontStyle: FontStyle.italic,
                      //                   color:ColorPath.blueBlue
                      //               ),
                      //             ),
                      //             SizedBox(height: 2.h,),
                      //             Text(
                      //               'Picture',
                      //               style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      //                   fontWeight: FontWeight.w400,
                      //                   color:Theme.of(context).colorScheme.textTertiary
                      //               ),
                      //             ),
                      //           ],
                      //         )
                      //       ],
                      //     ),
                      //     // Positioned(
                      //     //   top: -50,
                      //     //   bottom: 0,
                      //     //   left: 0,
                      //     //   right: 0,
                      //     //   child: Row(
                      //     //     mainAxisAlignment: MainAxisAlignment.center,
                      //     //     children: [
                      //     //       Container(
                      //     //         height: 10.h,
                      //     //         width: 10.w,
                      //     //         decoration: BoxDecoration(
                      //     //           color: ColorPath.hazeGreen,
                      //     //           shape: BoxShape.circle
                      //     //         ),
                      //     //       ),
                      //     //       Container(
                      //     //         height: 2.h,
                      //     //         width: 55.w,
                      //     //         color: ColorPath.hazeGreen,
                      //     //       ),
                      //     //       Container(
                      //     //         height: 10.h,
                      //     //         width: 10.w,
                      //     //         decoration: BoxDecoration(
                      //     //             color: ColorPath.hazeGreen,
                      //     //             shape: BoxShape.circle
                      //     //         ),
                      //     //       )
                      //     //     ],
                      //     //   ),
                      //     // )
                      // ],)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  CustomAssetViewer(asset: AppAsset.ninSamplePics, height: 74.h, width: 74.w,),
                                  // LgbtqContainer(
                                  //     isCircle: true,
                                  //     child: Container(
                                  //       height: 74.h,
                                  //       width: 74.w,
                                  //       decoration: BoxDecoration(
                                  //           color: Colors.black,
                                  //           shape: BoxShape.circle
                                  //       ),
                                  //     )
                                  // ),
                                  Positioned(
                                      top: 0,
                                      bottom: 0,
                                      right: -15,
                                      child: Center(child: CustomAssetViewer(asset: AppAsset.ninStack, height: 28.h, width: 28.w,))),
                                  Positioned(
                                    top: 0,
                                    bottom: 0,
                                    right: -80,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 10.h,
                                          width: 10.w,
                                          decoration: BoxDecoration(
                                              color: ColorPath.hazeGreen,
                                              shape: BoxShape.circle
                                          ),
                                        ),
                                        Container(
                                          height: 2.h,
                                          width: 55.w,
                                          color: ColorPath.hazeGreen,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 13.h,),
                              Text(
                                'Picture on',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color:Theme.of(context).colorScheme.textTertiary
                                ),
                              ),
                              SizedBox(height: 2.h,),
                              Text(
                                'NIN Slip',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.italic,
                                    color:ColorPath.blueBlue
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  CustomAssetViewer(asset: AppAsset.bvnSamplePics, height: 74.h, width: 74.w,),
                                  // LgbtqContainer(
                                  //     isCircle: true,
                                  //     child: Container(
                                  //       height: 74.h,
                                  //       width: 74.w,
                                  //       decoration: BoxDecoration(
                                  //           color: Colors.black,
                                  //           shape: BoxShape.circle
                                  //       ),
                                  //     )
                                  // ),
                                  Positioned(
                                      top: 0,
                                      bottom: 0,
                                      left: -15,
                                      child: Center(child: CustomAssetViewer(asset: AppAsset.bvnStack, height: 28.h, width: 28.w,))),
                                  Positioned(
                                    top: 0,
                                    bottom: 0,
                                    left: -80,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 2.h,
                                          width: 55.w,
                                          color: ColorPath.hazeGreen,
                                        ),
                                        Container(
                                          height: 10.h,
                                          width: 10.w,
                                          decoration: BoxDecoration(
                                              color: ColorPath.hazeGreen,
                                              shape: BoxShape.circle
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 13.h,),
                              Text(
                                'Liveliness',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.italic,
                                    color:ColorPath.blueBlue
                                ),
                              ),
                              SizedBox(height: 2.h,),
                              Text(
                                'Picture',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color:Theme.of(context).colorScheme.textTertiary
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 40.h,),
                      IdentityVerificationNotes(
                          asset: AppAsset.bulletPoint3,
                          notes: [
                            {
                              'title': 'Find a well lit place',
                            },
                            {
                              'title': 'Ensure your face is within the frame',
                            },
                            {
                              'title': 'Don’t wear hat, glasses and mask',
                            },
                            {
                              'title': 'Slowly turn your head left or right when prompted/required',
                            },
                            {
                              'title': 'Smile or move slightly to show a natural facial movement.',
                            }
                          ]
                      )




                    ],
                  ),
                ),
              ),
              CustomButton(
                  buttonText: 'Start Liveliness Check',
                  onPressed: (){
                    pushNavigation(context: context, widget: const BvnRequirement(), routeName: NamedRoutes.bvnRequirement);
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}
