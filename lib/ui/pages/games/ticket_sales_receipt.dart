import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/ui/widgets/custom_svg.dart';

import '../../../core/constants/app_asset.dart';
import '../../../core/constants/app_dimension.dart';
import '../../../core/constants/color_path.dart';
import '../../../core/constants/named_routes.dart';
import '../../../core/data/view_models/bottom_nav_view_model.dart';
import '../../../core/utilities/navigator.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/naira_display.dart';

class TicketSalesReceipt extends ConsumerStatefulWidget {
  const TicketSalesReceipt({super.key});

  @override
  ConsumerState<TicketSalesReceipt> createState() => _TicketSalesReceiptState();
}

class _TicketSalesReceiptState extends ConsumerState<TicketSalesReceipt> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        ref.read(bottomNavViewModel).setCurrentIndex(4, refreshUi: true);
        popUntilNavigation(context: context, route: NamedRoutes.bottomNav);
      },
      child: Scaffold(
        appBar: customAppBar(
          context: context,
          leadingIconOnPressed: (){
            ref.read(bottomNavViewModel).setCurrentIndex(4, refreshUi: true);
            popUntilNavigation(context: context, route: NamedRoutes.bottomNav);
          },
          title: 'Ticket Sales Receipt',
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: AppDimension.paddingLeft),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: 16.h,
                    horizontal: 16.w
                  ),
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage(AppAsset.ticketBg),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    children: [
                      CustomAssetViewer(asset: AppAsset.logo2, height: 80.09.h, width: 72.48.w,),
                      SizedBox(height: 16.h,),
                      Text(
                        'Ticket Sales Receipt',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: ColorPath.easternBlue
                        ),
                      ),
                      SizedBox(height: 4.h,),
                      Text(
                        'Monday, 4 September 2025 ; 2:34 PM',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: ColorPath.charcoalBlack
                        ),
                      ),
                      SizedBox(height: 24.h,),
                      receiptDetails(label: 'Transaction ID', value: 'AHJF948HDHFOFFN'),
                      SizedBox(height: 16.h,),
                      receiptDetails(label: 'Agent ID', value: '178338673'),
                      SizedBox(height: 16.h,),
                      receiptDetails(label: 'Game Details', value: 'Super Raffle'),
                      SizedBox(height: 16.h,),
                      receiptDetails(label: 'Number of Ticket (s)', value: '22 Entries'),
                      SizedBox(height: 24.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Amount Paid: ',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w800,
                                color: ColorPath.easternBlue
                            ),
                          ),
                          Flexible(
                            child:  NairaDisplay(
                              amount: 2200,
                              fontSize: 16.sp,
                              color:ColorPath.charcoalBlack,
                              fontWeight: FontWeight.w800,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 16.h,),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          vertical: 16.h,
                          horizontal: 16.w
                        ),
                        decoration: BoxDecoration(
                          color: ColorPath.paduaGreen,
                          borderRadius: BorderRadius.all(Radius.circular(16.r))
                        ),
                        child: Column(
                          children: [
                            Text(
                              'More Details',
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.italic,
                                  color: ColorPath.charcoalBlack
                              ),
                            ),
                            SizedBox(height: 8.h,),
                            Text(
                              'After Ticket purchase, we have sent you an SMS & email so you can sign up on the platform to get your Ticket Entries and track game. As a returning Customer, you can check your WinIT App to see ticket entries. ',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.italic,
                                  color: ColorPath.charcoalBlack
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 16.h,),
                            Text(
                              'Download the App (WinIT App) on Google PlayStore or Apple Store for automatic notification',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.italic,
                                  color: ColorPath.charcoalBlack
                              ),
                              textAlign: TextAlign.center,
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32.h,),
                CustomButton(
                    buttonText: 'Share Receipt',
                    suffixIcon: AppAsset.share,
                    onPressed: () {

                    }
                ),
                SizedBox(height: 16.h,),
                CustomButton(
                    bgColor: ColorPath.curiousBlue,
                    buttonText: 'Print Out',
                    suffixIcon: AppAsset.print,
                    onPressed: () {

                    }
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  receiptDetails({required String label, required String value}){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: ColorPath.troutGrey
            ),
          ),
          SizedBox(width: 10.w,),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: ColorPath.charcoalBlack
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),

    );
  }
}
