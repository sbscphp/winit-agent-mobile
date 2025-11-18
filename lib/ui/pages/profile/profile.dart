import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_asset.dart';
import 'package:winit_agent/core/constants/named_routes.dart';
import 'package:winit_agent/core/utilities/navigator.dart';
import 'package:winit_agent/ui/pages/profile/transaction_pin/transaction_pin.dart';
import 'package:winit_agent/ui/widgets/profile/profile_option.dart';
import '../../../core/constants/app_dimension.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/profile/profile_image.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        centerTitle: true,
        leadingIcon: ProfileImage(),
        title: 'My Profile',
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
            left: AppDimension.paddingLeft,
            right: AppDimension.paddingRight,
            top: 32.h,
          bottom: 50.h
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileOption(
                asset:AppAsset.avatar3,
                label:'Personal Information',
               subtitle: 'Setup and Update your personal details',
                onPressed: (){}
            ),
            SizedBox(height: 24.h,),
            ProfileOption(
                asset:AppAsset.bankDetails,
                label:'Bank Account Details',
                subtitle: 'Manage Account number for withdrawal',
                onPressed: (){}
            ),
            SizedBox(height: 24.h,),
            ProfileOption(
                asset:AppAsset.pin,
                label:'Transaction Pin',
                subtitle: 'Setup transaction PIN for your Account',
                onPressed: (){
                  pushNavigation(context: context, widget: const TransactionPin(), routeName: NamedRoutes.transactionPin);
                }
            ),
            SizedBox(height: 24.h,),
            ProfileOption(
                asset:AppAsset.faq,
                label:'FAQ',
                subtitle: 'FAQs on winIt Agent App',
                onPressed: (){}
            ),
            SizedBox(height: 24.h,),
            ProfileOption(
                asset:AppAsset.support,
                label:'Support',
                subtitle: 'Contact support to help solve issue with system use.',
                onPressed: (){}
            ),
            SizedBox(height: 24.h,),
            ProfileOption(
                asset:AppAsset.support,
                label:'Referral Management',
                subtitle: 'Refer other agent and Earn with ease today.',
                onPressed: (){}
            ),
            SizedBox(height: 24.h,),
            ProfileOption(
                asset:AppAsset.legal,
                label:'Legal',
                subtitle: 'Privacy Policy, Terms of Use, Cookies etc. ',
                onPressed: (){}
            ),
            SizedBox(height: 24.h,),
            ProfileOption(
                asset:AppAsset.logout,
                label:'Logout',
                subtitle: 'Log out of your winIt Agent account',
                onPressed: (){}
            ),
            SizedBox(height: 24.h,),
            ProfileOption(
                asset:AppAsset.logout,
                label:'Account Closure',
                subtitle: 'Initiate the process to close your account',
                onPressed: (){}
            ),

          ],
        ),
      ),
    );
  }


}
