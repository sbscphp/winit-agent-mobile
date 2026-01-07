import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/data/enum/checkout_type.dart';
import 'package:winit_agent/core/data/view_models/checkout/order_details_vm.dart';
import 'package:winit_agent/core/data/view_models/checkout/payment_vm.dart';
import 'package:winit_agent/core/data/view_models/notification/notifications_vm.dart';
import 'package:winit_agent/core/data/view_models/wallet/wallet_vm.dart';
import 'package:winit_agent/core/utilities/date_utilitites.dart';
import 'package:winit_agent/ui/widgets/app_loader.dart';
import 'package:winit_agent/ui/widgets/custom_svg.dart';
import 'package:winit_agent/ui/widgets/error_state.dart';

import '../../../core/constants/app_asset.dart';
import '../../../core/constants/app_dimension.dart';
import '../../../core/constants/color_path.dart';
import '../../../core/constants/named_routes.dart';
import '../../../core/data/enum/view_state.dart';
import '../../../core/data/view_models/bottom_nav_view_model.dart';
import '../../../core/data/view_models/profile/sales_stat_vm.dart';
import '../../../core/data/view_models/wallet/transaction_filters_vm.dart';
import '../../../core/data/view_models/wallet/wallet_transactions_vm.dart';
import '../../../core/utilities/navigator.dart';
import '../../../core/utilities/receipt_utils.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/naira_display.dart';
import 'package:flutter_bluetooth_printer/flutter_bluetooth_printer.dart';


class TicketSalesReceipt extends ConsumerStatefulWidget {
  final CheckoutType checkoutType;
  const TicketSalesReceipt({super.key, this.checkoutType = CheckoutType.wallet});

  @override
  ConsumerState<TicketSalesReceipt> createState() => _TicketSalesReceiptState();
}

class _TicketSalesReceiptState extends ConsumerState<TicketSalesReceipt> {

  late GlobalKey _globalKey;
  ReceiptController? printController;

  bool _showPrintPreview = false;


  @override
  void initState() {
    _globalKey = GlobalKey();

    //fetch recent data
    _fetchData();

    if(widget.checkoutType == CheckoutType.paystack){
      //fetch ticket details
      final orderDetailsVm = ref.read(orderDetailsViewModel);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        orderDetailsVm.fetchTicketDetails(id: ref.read(paymentViewModel).orderId);
      });
    }
    super.initState();
  }

  _fetchData(){
    final wVm = ref.read(walletVm);
    final filterTransactionsVm = ref.read(transactionFiltersViewModel);
    final statsVm = ref.read(salesStatViewModel);
    final notificationVm = ref.read(notificationsViewModel);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      wVm.fetchWalletSummary(showLoader: false).then((value){
        if(wVm.state == ViewState.retrieved){
          final transactionsVm = ref.read(walletTransactionsViewModel);
          transactionsVm.fetchTransactions(refreshUi: false);
        }
      });
      filterTransactionsVm.fetchPurchaseTransactions(showLoader: false);
      statsVm.fetchSalesStat(showLoader: false);
      notificationVm.fetchNotifications(refreshUi: false);
    });
  }


  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(orderDetailsViewModel);
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
          child: Builder(
            builder: (context) {

              if(widget.checkoutType == CheckoutType.wallet){
                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: AppDimension.paddingLeft),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RepaintBoundary(
                        key: _globalKey,
                        child: _showPrintPreview ? Receipt(
                          onInitialized: (controller) {
                            printController = controller;
                          },
                          builder: (context){
                            return Container(
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
                                    '${DateUtilities.dayDateMonthYear(date: vm.ticketPurchaseDate)} ; ${DateUtilities.formatTimeAMPM(dateTime:  vm.ticketPurchaseDate)}',
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: ColorPath.charcoalBlack
                                    ),
                                  ),
                                  SizedBox(height: 24.h,),
                                  receiptDetails(label: 'Transaction ID', value: vm.transactionId),
                                  SizedBox(height: 16.h,),
                                  receiptDetails(label: 'Agent ID', value: vm.agentId),
                                  SizedBox(height: 16.h,),
                                  receiptDetails(label: 'Raffle Details', value: vm.gameName),
                                  SizedBox(height: 16.h,),
                                  receiptDetails(label: 'Number of Ticket (s)', value: '${vm.ticketCount} ${vm.ticketCount > 1 ? 'Entries':'Entry'}'),
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
                                          amount: vm.paidAmount,
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
                                          'After Ticket purchase, we have sent you an SMS & email so you can sign up on the platform to get your Ticket Entries and track raffle. As a returning Customer, you can check your WinIT App to see ticket entries. ',
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
                            );
                          },
                        ):Container(
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
                                '${DateUtilities.dayDateMonthYear(date: vm.ticketPurchaseDate)} ; ${DateUtilities.formatTimeAMPM(dateTime:  vm.ticketPurchaseDate)}',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: ColorPath.charcoalBlack
                                ),
                              ),
                              SizedBox(height: 24.h,),
                              receiptDetails(label: 'Transaction ID', value: vm.transactionId),
                              SizedBox(height: 16.h,),
                              receiptDetails(label: 'Agent ID', value: vm.agentId),
                              SizedBox(height: 16.h,),
                              receiptDetails(label: 'Raffle Details', value: vm.gameName),
                              SizedBox(height: 16.h,),
                              receiptDetails(label: 'Number of Ticket (s)', value: '${vm.ticketCount} ${vm.ticketCount > 1 ? 'Entries':'Entry'}'),
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
                                      amount: vm.paidAmount,
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
                                      'After Ticket purchase, we have sent you an SMS & email so you can sign up on the platform to get your Ticket Entries and track raffle. As a returning Customer, you can check your WinIT App to see ticket entries. ',
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
                      ),
                      SizedBox(height: 32.h,),
                      CustomButton(
                          buttonText: 'Share Receipt',
                          suffixIcon: AppAsset.share,
                          onPressed: () {
                            ReceiptUtils.shareImage(key: _globalKey, context: context);
                          }
                      ),
                      SizedBox(height: 16.h,),
                      CustomButton(
                          bgColor: ColorPath.curiousBlue,
                          buttonText: 'Print Out',
                          suffixIcon: AppAsset.print,
                          onPressed: () {
                            setState(() {
                              _showPrintPreview = true;
                            });
                            ReceiptUtils.printReceipt(
                              context: context,
                              controller: printController,
                              onDone: (value){
                                setState(() {
                                  _showPrintPreview = false;
                                });
                              }
                            );
                          }
                      ),

                    ],
                  ),
                );
              }

              if(vm.secondState == ViewState.busy){
                return Center(
                  child: AppLoader(),
                );
              }

              if(vm.secondState == ViewState.retrieved){
                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: AppDimension.paddingLeft),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RepaintBoundary(
                        key: _globalKey,
                        child: _showPrintPreview ? Receipt(
                          onInitialized: (controller) {
                            printController = controller;
                          },
                          builder: (context){
                            return Container(
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
                                    '${DateUtilities.dayDateMonthYear(date: vm.ticketPurchaseDate)} ; ${DateUtilities.formatTimeAMPM(dateTime:  vm.ticketPurchaseDate)}',
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: ColorPath.charcoalBlack
                                    ),
                                  ),
                                  SizedBox(height: 24.h,),
                                  receiptDetails(label: 'Transaction ID', value: vm.transactionId),
                                  SizedBox(height: 16.h,),
                                  receiptDetails(label: 'Agent ID', value: vm.agentId),
                                  SizedBox(height: 16.h,),
                                  receiptDetails(label: 'Raffle Details', value: vm.gameName),
                                  SizedBox(height: 16.h,),
                                  receiptDetails(label: 'Number of Ticket (s)', value: '${vm.ticketCount} ${vm.ticketCount > 1 ? 'Entries':'Entry'}'),
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
                                          amount: vm.paidAmount,
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
                                          'After Ticket purchase, we have sent you an SMS & email so you can sign up on the platform to get your Ticket Entries and track raffle. As a returning Customer, you can check your WinIT App to see ticket entries. ',
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
                            );
                          },
                        ):Container(
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
                                '${DateUtilities.dayDateMonthYear(date: vm.ticketPurchaseDate)} ; ${DateUtilities.formatTimeAMPM(dateTime:  vm.ticketPurchaseDate)}',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: ColorPath.charcoalBlack
                                ),
                              ),
                              SizedBox(height: 24.h,),
                              receiptDetails(label: 'Transaction ID', value: vm.transactionId),
                              SizedBox(height: 16.h,),
                              receiptDetails(label: 'Agent ID', value: vm.agentId),
                              SizedBox(height: 16.h,),
                              receiptDetails(label: 'Raffle Details', value: vm.gameName),
                              SizedBox(height: 16.h,),
                              receiptDetails(label: 'Number of Ticket (s)', value: '${vm.ticketCount} ${vm.ticketCount > 1 ? 'Entries':'Entry'}'),
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
                                      amount: vm.paidAmount,
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
                                      'After Ticket purchase, we have sent you an SMS & email so you can sign up on the platform to get your Ticket Entries and track raffle. As a returning Customer, you can check your WinIT App to see ticket entries. ',
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
                      ),
                      SizedBox(height: 32.h,),
                      CustomButton(
                          buttonText: 'Share Receipt',
                          suffixIcon: AppAsset.share,
                          onPressed: () {
                            ReceiptUtils.shareImage(key: _globalKey, context: context);
                          }
                      ),
                      SizedBox(height: 16.h,),
                      CustomButton(
                          bgColor: ColorPath.curiousBlue,
                          buttonText: 'Print Out',
                          suffixIcon: AppAsset.print,
                          onPressed: () async{
                            setState(() {
                              _showPrintPreview = true;
                            });
                            ReceiptUtils.printReceipt(
                                context: context,
                                controller: printController,
                                onDone: (value){
                                  setState(() {
                                    _showPrintPreview = false;
                                  });
                                }
                            );
                          }
                      ),
                  
                    ],
                  ),
                );
              }

              if(vm.secondState == ViewState.error){
                return Center(
                  child: ErrorState(
                    message: vm.message,
                      onPressed: ()=>vm.fetchTicketDetails(id: ref.read(paymentViewModel).orderId)
                  ),
                );
              }

              return const SizedBox.shrink();

            }
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
