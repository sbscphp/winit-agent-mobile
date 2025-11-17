import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/ui/widgets/bottom_sheets/filter_options.dart';

import '../../../core/constants/app_asset.dart';
import '../../../core/constants/app_dimension.dart';
import '../../../core/constants/color_path.dart';
import '../../widgets/action_icon.dart';
import '../../widgets/bottom_sheets/base_bottom_sheet.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/listview_items/transaction_item.dart';

class ViewAllTransactions extends StatefulWidget {
  const ViewAllTransactions({super.key});

  @override
  State<ViewAllTransactions> createState() => _ViewAllTransactionsState();
}

class _ViewAllTransactionsState extends State<ViewAllTransactions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        centerTitle: false,
        useCustomTitleWidget: true,
        titleWidget: RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
            children: [
              TextSpan(
                text: 'Wallet Transaction ',
              ),
              TextSpan(
                text: '(60)',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: ColorPath.turquoiseGreen
                ),
              ),

            ],
          ),
        ),
          actions: [
            ActionIcon(label: 'Filter', asset: AppAsset.filter,
              onPressed: (){
                baseBottomSheet(
                  context: context,
                  content: FilterOptions(
                      label: 'Filter Transaction',
                      subtitle: 'Filter wallet transactions with ease',
                    options: [
                      'Show All',
                      'Credit',
                      'Debit'
                    ],
                    selectedOption: (value){
                        //todo: fetch filtered data
                    },
                  ),
                );
              },
            )
          ]
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppDimension.paddingLeft,
            vertical: 14.h
        ),
        child: ListView.separated(
          itemCount: 5,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemBuilder: (BuildContext context, int index) {
            return TransactionItem(
                label: 'Purchased of 15 Ticket Unit',
                date: DateTime.now(),
                amount: 2500,
                status: 'successful'
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(height: 16.h,);
          },
        ),
      ),
    );
  }
}
