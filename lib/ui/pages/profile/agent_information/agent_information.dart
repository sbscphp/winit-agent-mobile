import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/named_routes.dart';
import 'package:winit_agent/core/utilities/navigator.dart';
import 'package:winit_agent/ui/pages/profile/agent_information/business_details.dart';
import 'package:winit_agent/ui/pages/profile/agent_information/personal_details.dart';

import '../../../../core/constants/app_asset.dart';
import '../../../../core/constants/app_dimension.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/profile/profile_option.dart';

class AgentInformation extends StatelessWidget {
  const AgentInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'Personal Information',
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
                asset:AppAsset.personalDetails,
                label:'Personal Details',
                subtitle: 'Update personal details with ease',
                onPressed: (){
                  pushNavigation(context: context, widget: const PersonalDetails(), routeName: NamedRoutes.personalDetails);
                }
            ),
            SizedBox(height: 24.h,),
            ProfileOption(
                asset:AppAsset.businessDetails,
                label:'Business Details',
                subtitle: 'Update business details with ease',
                onPressed: (){
                  pushNavigation(context: context, widget: const BusinessDetails(), routeName: NamedRoutes.businessDetails);
                }
            ),
          ],
        ),
      ),
    );
  }
}
