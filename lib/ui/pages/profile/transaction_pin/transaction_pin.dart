import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/named_routes.dart';
import 'package:winit_agent/core/data/view_models/profile/profile_vm.dart';
import 'package:winit_agent/core/utilities/navigator.dart';
import 'package:winit_agent/ui/pages/profile/transaction_pin/forgot_transaction_pin.dart';
import 'package:winit_agent/ui/pages/profile/transaction_pin/set_transaction_pin.dart';

import '../../../../core/constants/app_asset.dart';
import '../../../../core/constants/app_dimension.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/profile/profile_option.dart';

class TransactionPin extends ConsumerWidget {
  const TransactionPin({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(profileViewModel);
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
                asset:AppAsset.pin,
                label:'${vm.hasTransactionPin ? 'Change':'Setup'} Transaction PiN',
                subtitle: vm.hasTransactionPin ? 'Change your current transaction with ease':'Setup your transaction pin with ease',
                onPressed: (){
                  pushNavigation(context: context, widget: SetTransactionPin(
                    isChangePin: vm.hasTransactionPin,
                  ), routeName: NamedRoutes.setTransactionPin);
                }
            ),
            SizedBox(height: 24.h,),
            if(vm.hasTransactionPin)ProfileOption(
                asset:AppAsset.pin,
                label:'Forget Transaction PiN?',
                subtitle: 'Forget transaction PIN? Reset today',
                onPressed: (){
                  pushNavigation(context: context, widget: const ForgotTransactionPin(), routeName: NamedRoutes.forgotTransactionPin);
                }
            ),
          ],
        ),
      ),
    );
  }
}
