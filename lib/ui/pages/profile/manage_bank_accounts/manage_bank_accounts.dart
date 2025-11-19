import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/named_routes.dart';
import 'package:winit_agent/core/utilities/navigator.dart';
import 'package:winit_agent/ui/pages/profile/manage_bank_accounts/verify_bank_details.dart';
import '../../../../core/constants/app_asset.dart';
import '../../../../core/constants/app_dimension.dart';
import '../../../../core/constants/color_path.dart';
import '../../../widgets/action_icon.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_svg.dart';
import '../../../widgets/listview_items/bank_account_item.dart';

class ManageBankAccounts extends StatefulWidget {
  const ManageBankAccounts({super.key});

  @override
  State<ManageBankAccounts> createState() => _ManageBankAccountsState();
}

class _ManageBankAccountsState extends State<ManageBankAccounts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'Manage Account Number',
          actions: [
            ActionIcon(label: 'New', asset: AppAsset.add2,
              onPressed: (){
                pushNavigation(context: context, widget: const VerifyBankDetails(), routeName: NamedRoutes.verifyBankDetails);
              },
            )
          ]
      ),
      body: Padding(
        padding: EdgeInsets.only(
            left: AppDimension.paddingLeft,
            right: AppDimension.paddingRight,
            top: 32.h,
            bottom: 36.h
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.separated(
                  itemCount: 2,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemBuilder: (BuildContext context, int index) {
                    return BankAccountItem(
                      canDelete: true,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 24.h,);
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: 16.h,
                    horizontal: 16.w
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12.r)),
                    color: ColorPath.remyPink
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 4.8.h,
                          horizontal:4.8.w
                      ),
                      decoration: BoxDecoration(
                        color: ColorPath.pigPink2,
                        borderRadius: BorderRadius.all(Radius.circular(6.r)),
                      ),
                      child: Center(
                        child: CustomAssetViewer(asset: AppAsset.alert, height: 14.4.h, width: 14.4.w,),
                      ),
                    ),
                    SizedBox(width: 12.w,),
                    Expanded(
                      child:  Text(
                        'You can only add a maximum of two (2) Bank Accounts. ',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: ColorPath.charcoalBlack
                        ),
                      ),

                    )
          
                  ],
                ),
              )
          
            ],
          ),
        ),
      ),
    );
  }
}
