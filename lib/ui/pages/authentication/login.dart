import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_dimension.dart';
import 'package:winit_agent/core/constants/app_asset.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/core/constants/color_path.dart';
import 'package:winit_agent/core/constants/named_routes.dart';
import 'package:winit_agent/core/utilities/navigator.dart';
import 'package:winit_agent/core/utilities/validator.dart';
import 'package:winit_agent/ui/pages/bottom_nav.dart';
import 'package:winit_agent/ui/widgets/busy_overlay.dart';
import 'package:winit_agent/ui/widgets/clickable.dart';
import 'package:winit_agent/ui/widgets/custom_appbar.dart';
import 'package:winit_agent/ui/widgets/custom_button.dart';
import 'package:winit_agent/ui/widgets/custom_svg.dart';
import 'package:winit_agent/ui/widgets/custom_text_field.dart';



class Login extends ConsumerStatefulWidget {
  final String? visitingRoute;
  final String? destinationRoute;
  const Login({super.key, this.visitingRoute, this.destinationRoute});

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  final _loginChoice = TextEditingController();
  final _pwd = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _hidePwd = true;

  @override
  Widget build(BuildContext context) {
    final hasVisitingRoute = widget.visitingRoute != null;
    final hasDestinationRoute = widget.destinationRoute != null;
    return BusyOverlay(
      show: false,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Scaffold(
          appBar: customAppBar(
              context: context,
              title: 'Login',
              // actions: [
              //   const AppBarLogo()
              // ]
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(vertical: AppDimension.paddingTop, horizontal: AppDimension.paddingLeft),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               Expanded(
                 child: SingleChildScrollView(
                   child: Form(
                     key: _formKey,
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text(
                           'WinIt Agent Ticket Purchase System ',
                           style: Theme.of(context).textTheme.titleMedium?.copyWith(
                             fontSize: 30.sp,
                               fontWeight: FontWeight.w600,
                               color: Theme.of(context).colorScheme.brandColor
                           ),
                         ),
                         SizedBox(height: 24.h,),
                         CustomTextField(
                           label: 'Agent ID / Phone Number',
                           keyboardType: TextInputType.text,
                           controller: _loginChoice,
                           validator: FieldValidator.validate,
                           prefixIcon: Padding(
                             padding: EdgeInsets.only(left: 16.w, right: 8.w),
                             child: CustomSvg(asset: AppAsset.building, height: 24.h, width: 24.w,),
                           ),
                         ),
                         SizedBox(height: 24.h,),
                         CustomTextField(
                           label: 'Password',
                           obscure: _hidePwd,
                           controller: _pwd,
                           validator: FieldValidator.validate,
                           keyboardType: TextInputType.text,
                           prefixIcon: Padding(
                             padding: EdgeInsets.only(left: 16.w, right: 8.w),
                             child: CustomSvg(asset: AppAsset.password, height: 24.h, width: 24.w,),
                           ),
                           suffixIcon: Padding(
                             padding: EdgeInsets.only(right: 16.w, left: 16.w),
                             child: Clickable(
                               onPressed: (){
                                 setState(() {
                                   _hidePwd = !_hidePwd;
                                 });
                               },
                               child: CustomSvg(
                                   asset:_hidePwd ? AppAsset.pwdHidden : AppAsset.pwdVisible),
                             ),
                           ),
                           onChanged: (value){},
                         ),
                         SizedBox(height: 12.h,),
                         Align(
                           alignment: Alignment.centerRight,
                           child: Clickable(
                             onPressed: (){

                             },
                             child: Text(
                               'Forgot Password?',
                               style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                   fontWeight: FontWeight.w700,
                                   color: ColorPath.curiousBlue
                               ),
                             ),
                           ),
                         ),
                         SizedBox(height: 82.h,),
                         Column(
                           children: [
                             CustomButton(
                                 buttonText: 'Login',
                                 suffixIcon: AppAsset.login,
                                 onPressed: () {
                                   pushNavigation(context: context, widget: const BottomNav(), routeName: NamedRoutes.bottomNav);
                                 }
                             ),
                             SizedBox(height: 13.h,),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Text(
                                   'Don’t have an account?',
                                   style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                       fontWeight: FontWeight.w600,
                                       color: Theme.of(context).colorScheme.textPrimary
                                   ),
                                 ),
                                 SizedBox(width: 6.w,),
                                 Clickable(
                                   onPressed: (){

                                   },
                                   child: Text(
                                     'Sign Up',
                                     style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                       fontWeight: FontWeight.w600,
                                       color: ColorPath.curiousBlue,
                                       decoration: TextDecoration.underline,
                                       decorationColor:ColorPath.curiousBlue,
                                     ),
                                   ),
                                 ),
                               ],
                             ),
                           ],
                         )

                       ],
                     ),
                   ),
                 ),
               ),
                // Column(
                //   children: [
                //     CustomButton(
                //         buttonText: 'Login',
                //         onPressed: () async{
                //
                //           final validate = _formKey.currentState!.validate();
                //           if(validate){
                //
                //             Utilities.hideKeyboard(context);
                //
                //             await vm.login(
                //                 username: _loginChoice.text,
                //                 pwd: _pwd.text
                //             );
                //
                //             if(vm.state == ViewState.retrieved){
                //
                //               if(hasVisitingRoute && !hasDestinationRoute){
                //
                //                 //fetch user details
                //                 fetchUserDetails();
                //
                //
                //                 locator<NavigationService>().popUntil(
                //                   routeName: widget.visitingRoute!,
                //                 );
                //
                //                 //show success message
                //                 showFlushBar(
                //                   context: context,
                //                   message: vm.message,
                //                 );
                //                 return;
                //               }
                //
                //               if(hasVisitingRoute && hasDestinationRoute){
                //
                //                 //fetch user details
                //                 fetchUserDetails();
                //
                //
                //                 locator<NavigationService>().pushAndClearRoutes(
                //                     routeName: widget.destinationRoute!,
                //                     clearRoute: widget.visitingRoute!
                //                 );
                //
                //                 //show success message
                //                 showFlushBar(
                //                   context: context,
                //                   message: vm.message,
                //                 );
                //                 return;
                //               }
                //
                //               pushNavigation(context: context, widget: const BottomNav(), routeName: NamedRoutes.bottomNav);
                //             }else{
                //               showFlushBar(
                //                   context: context,
                //                   message: vm.message,
                //                   success: false
                //               );
                //             }
                //
                //           }
                //
                //
                //         }
                //     ),
                //     SizedBox(height: 13.h,),
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Text(
                //           'Don’t have an account?',
                //           style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                //               fontWeight: FontWeight.w700,
                //               color: Theme.of(context).colorScheme.textPrimary
                //           ),
                //         ),
                //         SizedBox(width: 6.w,),
                //         Clickable(
                //           onPressed: (){
                //             replaceNavigation(
                //                 context: context,
                //                 widget: Registration(
                //                   visitingRoute: widget.visitingRoute,
                //                   destinationRoute: widget.destinationRoute,
                //                 ),
                //               routeName: NamedRoutes.registration
                //             );
                //           },
                //           child: Text(
                //             'Sign Up',
                //             style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                //                 fontWeight: FontWeight.w700,
                //                 color: ColorPath.curiousBlue,
                //                 decoration: TextDecoration.underline,
                //                 decorationColor:ColorPath.curiousBlue,
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ],
                // )


              ],
            ),
          ),
        ),
      ),
    );
  }

}
