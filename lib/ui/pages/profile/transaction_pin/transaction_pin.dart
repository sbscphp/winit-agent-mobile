import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/named_routes.dart';
import 'package:winit_agent/core/utilities/navigator.dart';
import 'package:winit_agent/ui/pages/profile/transaction_pin/set_transaction_pin.dart';

import '../../../../core/constants/app_asset.dart';
import '../../../../core/constants/app_dimension.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/profile/profile_option.dart';

class TransactionPin extends StatelessWidget {
  const TransactionPin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'Transaction PIN',
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
                label:'${1 + 1 == 2 ? 'Change':'Setup'} Transaction PiN',
                subtitle: 1 + 1 == 2 ? 'Change your current transaction with ease':'Setup your transaction pin with ease',
                onPressed: (){
                  pushNavigation(context: context, widget: const SetTransactionPin(
                    isChangePin: true,
                  ), routeName: NamedRoutes.setTransactionPin);
                }
            ),
            SizedBox(height: 24.h,),
            if(1 + 1 == 2)ProfileOption(
                asset:AppAsset.bankDetails,
                label:'Forget Transaction PiN?',
                subtitle: 'Forget transaction PIN? Reset today',
                onPressed: (){}
            ),
          ],
        ),
      ),
    );
  }
}
