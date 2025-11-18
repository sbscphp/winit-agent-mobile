import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/ui/widgets/listview_items/game_item.dart';

import '../../../core/constants/app_dimension.dart';
import '../../../core/constants/color_path.dart';
import '../../../core/data/view_models/bottom_nav_view_model.dart';
import '../../../core/utilities/utilities.dart';
import '../../widgets/balance_summary_card.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/list_header.dart';
import '../../widgets/listview_items/transaction_item.dart';
import '../../widgets/naira_display.dart';
import '../../widgets/profile/profile_image.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          context: context,
          centerTitle: true,
          leadingIcon: ProfileImage(),
          title: 'Home',
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            horizontal: AppDimension.paddingLeft,
            vertical: 32.h
        ),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BalanceSummaryCard(
                label: 'Total Sales',
                balance: 405674,
                amountAdded: 2500
            ),
            SizedBox(height: 16.h,),
            balanceBreakdown(context),
            SizedBox(height: 24.h,),
            ListHeader(
              label: 'Live Games ',
              subtitle: 'Play and buy Ticket for live games today',
              onPressed: (){
                final container =
                ProviderScope.containerOf(context);

                final bottomNavVm =
                container.read(bottomNavViewModel);

                bottomNavVm.updateIndex(0);
              },
            ),
            SizedBox(height: 16.h,),
            SizedBox(
              height: 186.h,
              child: ListView.separated(
                itemCount: 5,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(right: 16.w,),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return GameItem(
                      index: index,
                      returnSmallCard: true,
                    cardWidth: 172.5.w,
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    width: 16.w,
                  );
                },
              ),
            ),
            SizedBox(height: 24.h,),
            ListHeader(
              label: '',
              subtitle: 'List of your most Game purchase.',
              titleWidget: RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: ColorPath.blueBlue,
                  ),
                  children: [
                    TextSpan(
                      text: 'Most Recent:',
                    ),
                    TextSpan(
                      text: ' Game Purchase',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: Theme.of(context).colorScheme.textSecondary
                      ),
                    ),

                  ],
                ),
              ),
              onPressed: (){
                //pushNavigation(context: context, widget: const ViewAllTransactions(), routeName: NamedRoutes.viewAllTransactions);
              },
            ),
            SizedBox(height: 16.h,),
            ListView.separated(
              itemCount: 5,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
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
            )


          ],
        ),
      ),
    );
  }

  balanceBreakdown(BuildContext context){
    return GridView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: 4,
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8.h,
          crossAxisSpacing: 8.w,
          mainAxisExtent: 60.h,
        ),
        itemBuilder: (BuildContext context, int index) {
         if(index == 0){
           return Container(
             padding: EdgeInsets.symmetric(
                 horizontal: 16.w
             ),
             decoration: BoxDecoration(
                 color: ColorPath.hummingBirdBlue,
                 borderRadius: BorderRadius.all(Radius.circular(8.r))
             ),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Text(
                   'Total Ticket Sold',
                   style: Theme.of(context)
                       .textTheme
                       .bodySmall
                       ?.copyWith(
                       fontWeight: FontWeight.w400,
                       color: ColorPath.troutGrey
                   ),
                 ),
                 SizedBox(height: 2.h,),
                 FittedBox(
                   child: Text(
                     Utilities.formatAmount(
                         amount: 1200,
                         addDecimal: false
                     ),
                     style: Theme.of(context)
                         .textTheme
                         .bodyMedium
                         ?.copyWith(
                         fontWeight: FontWeight.w800,
                         color: ColorPath.curiousBlue
                     ),
                   ),
                 ),
               ],
             ),
           );
         }

         if(index == 1){
           return Container(
             padding: EdgeInsets.symmetric(
                 horizontal: 16.w
             ),
             decoration: BoxDecoration(
                 color: ColorPath.foamGreen,
                 borderRadius: BorderRadius.all(Radius.circular(8.r))
             ),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Text(
                   'Commission Balance',
                   style: Theme.of(context)
                       .textTheme
                       .bodySmall
                       ?.copyWith(
                       fontWeight: FontWeight.w400,
                       color: ColorPath.troutGrey
                   ),
                 ),
                 SizedBox(height: 2.h,),
             NairaDisplay(
               amount: 4536,
               fontSize: 14.sp,
               color:ColorPath.hazeGreen,
               fontWeight: FontWeight.w800,
             ),
               ],
             ),
           );
         }

         if(index == 2){
           return Container(
             padding: EdgeInsets.symmetric(
                 horizontal: 16.w
             ),
             decoration: BoxDecoration(
                 color: ColorPath.beeBrown,
                 borderRadius: BorderRadius.all(Radius.circular(8.r))
             ),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Text(
                   'Bonus Income',
                   style: Theme.of(context)
                       .textTheme
                       .bodySmall
                       ?.copyWith(
                       fontWeight: FontWeight.w400,
                       color: ColorPath.troutGrey
                   ),
                 ),
                 SizedBox(height: 2.h,),
                 NairaDisplay(
                   amount: 4536,
                   fontSize: 14.sp,
                   color:ColorPath.piperBrown,
                   fontWeight: FontWeight.w800,
                 ),
               ],
             ),
           );
         }

         return Container(
           padding: EdgeInsets.symmetric(
               horizontal: 16.w
           ),
           decoration: BoxDecoration(
               color: ColorPath.athensGrey2,
               borderRadius: BorderRadius.all(Radius.circular(8.r))
           ),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Text(
                 '5th in Kosofe',
                 style: Theme.of(context)
                     .textTheme
                     .bodySmall
                     ?.copyWith(
                     fontWeight: FontWeight.w400,
                     color: ColorPath.troutGrey
                 ),
               ),
               SizedBox(height: 2.h,),
               FittedBox(
                 child: Text(
                   "+${Utilities.abbreviateAmount(
                     value: 123000
                   )} Tickets Sold Today",
                   style: Theme.of(context)
                       .textTheme
                       .bodyMedium
                       ?.copyWith(
                       fontWeight: FontWeight.w800,
                       color: ColorPath.charcoalBlack
                   ),
                 ),
               ),
             ],
           ),
         );
        });
  }
}
