import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_dimension.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/core/constants/named_routes.dart';
import 'package:winit_agent/core/data/view_models/bottom_nav_view_model.dart';
import 'package:winit_agent/core/data/view_models/wallet/wallet_transactions_vm.dart';
import 'package:winit_agent/core/data/view_models/wallet/wallet_vm.dart';
import 'package:winit_agent/core/utilities/navigator.dart';
import 'package:winit_agent/ui/pages/wallet/view_all_transactions.dart';
import 'package:winit_agent/ui/widgets/app_loader.dart';
import 'package:winit_agent/ui/widgets/balance_summary_card.dart';
import 'package:winit_agent/ui/widgets/bottom_sheets/wallet_quick_actions.dart';
import 'package:winit_agent/ui/widgets/clickable.dart';
import 'package:winit_agent/ui/widgets/copy_details.dart';
import 'package:winit_agent/ui/widgets/empty_state.dart';
import 'package:winit_agent/ui/widgets/error_state.dart';
import 'package:winit_agent/ui/widgets/list_header.dart';
import 'package:winit_agent/ui/widgets/listview_items/transaction_item.dart';
import '../../../core/constants/app_asset.dart';
import '../../../core/data/enum/view_state.dart';
import '../../widgets/action_icon.dart';
import '../../widgets/alert_dialogs/base_dialog.dart';
import '../../widgets/alert_dialogs/transaction_receipt.dart';
import '../../widgets/bottom_sheets/base_bottom_sheet.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/profile/profile_image.dart';

class Wallet extends ConsumerStatefulWidget {
  const Wallet({super.key});

  @override
  ConsumerState<Wallet> createState() => _WalletState();
}

class _WalletState extends ConsumerState<Wallet> {

  @override
  void initState() {

    final vm = ref.read(walletVm);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchWalletSummary(vm);
    });
    super.initState();
  }
  
 Future<void> _fetchWalletSummary(WalletVm vm, {bool showLoader = true})async{
    vm.fetchWalletSummary(showLoader: showLoader).then((value){
      if(vm.state == ViewState.retrieved){
        final transactionsVm = ref.read(walletTransactionsViewModel);
        transactionsVm.fetchTransactions(refreshUi: showLoader);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(walletVm);
    return Scaffold(
      appBar: customAppBar(
          context: context,
          centerTitle: true,
          leadingIcon: ProfileImage(),
          title: 'Explore',
          actions: [
            if(vm.state == ViewState.retrieved)ActionIcon(label: 'Quick Actions', asset: AppAsset.walletActions,
              onPressed: (){
                baseBottomSheet(
                  context: context,
                  content: WalletQuickActions(),
                );
              },
            )
          ]
      ),
      body: Builder(
        builder: (context) {
          if(vm.state == ViewState.busy){
            return Center(
              child: AppLoader(),
            );
          }

          if(vm.state == ViewState.retrieved){

            final transactionsVm = ref.watch(walletTransactionsViewModel);

            return RefreshIndicator.adaptive(
              onRefresh: () => _fetchWalletSummary(vm, showLoader: false),
              backgroundColor: Theme.of(context).colorScheme.whiteText,
              color: Theme.of(context).colorScheme.brandColor,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                    horizontal: AppDimension.paddingLeft,
                    vertical: 14.h
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BalanceSummaryCard(
                        label: 'Wallet Balance',
                        balance: vm.walletBalance,
                        amountAdded: vm.addedAmount,
                      duration: vm.duration,
                    ),
                    SizedBox(height: 16.h,),
                    CopyDetails(
                        label: 'Wallet Account No.',
                        subtitle: vm.walletAccountName,
                        detailToCopy: vm.walletAccountNumber
                    ),
                    SizedBox(height: 32.h,),
                    ListHeader(
                      label: 'Wallet Transaction',
                      subtitle: 'Purchase transaction done via wallet',
                      showAllVisible: transactionsVm.state == ViewState.retrieved && transactionsVm.transactions.isNotEmpty,
                      onPressed: (){
                        pushNavigation(context: context, widget: const ViewAllTransactions(), routeName: NamedRoutes.viewAllTransactions);
                      },
                    ),
                    SizedBox(height: 24.h,),
                    Builder(
                      builder: (context) {

                        if(transactionsVm.state == ViewState.busy){
                          return Center(
                            child: AppLoader(),
                          );
                        }

                        if(transactionsVm.state == ViewState.retrieved){
                          if(transactionsVm.transactions.isEmpty){
                            return Column(
                              children: [
                                EmptyState(
                                  asset: AppAsset.emptyState,
                                  title: 'No Transaction Yet',
                                  subtitle: 'You currently have no transaction yet. ',
                                ),
                                SizedBox(height: 16.h,),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 39.5.w),
                                  child: CustomButton(
                                      buttonText: 'Purchase Raffle Ticket',
                                      suffixIcon: AppAsset.ticketPurchase,
                                      onPressed: () {
                                        final bottomNavVm = ref.read(bottomNavViewModel);
                                        bottomNavVm.updateIndex(0);
                                      }
                                  ),
                                )
                              ],
                            );
                          }
                          return ListView.separated(
                            itemCount: transactionsVm.transactions.length > 5 ? 5 : transactionsVm.transactions.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemBuilder: (BuildContext context, int index) {
                              final transaction = transactionsVm.transactions[index];
                              final desc = transaction.description ?? 'N/A';
                              final date = transaction.createdAt ?? DateTime.now();
                              final amount = double.tryParse(transaction.amount?.toString() ?? '0') ?? 0;
                              final status = transaction.status ?? '';

                              return Clickable(
                                onPressed: (){
                                  baseDialog(
                                    context: context,
                                    content: TransactionReceipt(transaction: transaction,),
                                  );
                                },
                                child: TransactionItem(
                                    label: desc,
                                    date: date,
                                    amount: amount,
                                    status: status
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 16.h,);
                            },
                          );
                        }

                        if(transactionsVm.state == ViewState.error){
                          return Center(
                            child: ErrorState(
                              message: transactionsVm.message,
                                onPressed: ()=>transactionsVm.fetchTransactions()
                            ),
                          );
                        }

                        return const SizedBox.shrink();
                      }
                    )
                  ],
                ),
              ),
            );
          }

          if(vm.state == ViewState.error){
            return Center(
              child: ErrorState(
                message: vm.message,
                  onPressed: ()=>_fetchWalletSummary(vm)),
            );
          }

          return const SizedBox.shrink();

        }
      ),
    );
  }
}
