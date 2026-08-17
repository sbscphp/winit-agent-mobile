import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/core/data/view_models/profile/profile_vm.dart';
import 'package:winit_agent/core/data/view_models/utility/config_vm.dart';
import 'package:winit_agent/core/data/view_models/wallet/transaction_filters_vm.dart';
import 'package:winit_agent/core/data/view_models/wallet/wallet_transactions_vm.dart';
import 'package:winit_agent/ui/widgets/app_loader.dart';
import 'package:winit_agent/ui/widgets/bottom_sheets/filter_options.dart';
import 'package:winit_agent/ui/widgets/error_state.dart';
import 'package:winit_agent/ui/widgets/show_flush_bar.dart';
import '../../../core/constants/app_asset.dart';
import '../../../core/constants/app_dimension.dart';
import '../../../core/constants/color_path.dart';
import '../../../core/data/enum/view_state.dart';
import '../../widgets/action_icon.dart';
import '../../widgets/alert_dialogs/base_dialog.dart';
import '../../widgets/alert_dialogs/transaction_receipt.dart';
import '../../widgets/bottom_sheets/base_bottom_sheet.dart';
import '../../widgets/clickable.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/listview_items/transaction_item.dart';

class ViewAllTransactions extends ConsumerStatefulWidget {
  const ViewAllTransactions({super.key});

  @override
  ConsumerState<ViewAllTransactions> createState() => _ViewAllTransactionsState();
}

class _ViewAllTransactionsState extends ConsumerState<ViewAllTransactions> {

  late ScrollController _scrollController, _filterScrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _filterScrollController = ScrollController();
    _scrollListener();
    _filterScrollListener();
    super.initState();
  }

  _scrollListener() {
    final vm = ref.read(walletTransactionsViewModel);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        //check paginated state
        if(vm.paginatedState != ViewState.error){
          //check if data is not being currently fetched and also check total records
          if (vm.paginatedState != ViewState.busy && vm.transactions.length < vm.totalRecords) {
            //fetch more transactions
            vm.fetchTransactions(
                firstCall: false
            );
          }
        }
      }
    });
  }

  _filterScrollListener() {
    final vm = ref.read(transactionFiltersViewModel);
    final profileVm = ref.read(profileViewModel);
    final configVm = ref.read(configViewModel);
    _filterScrollController.addListener(() {
      if (_filterScrollController.position.pixels ==
          _filterScrollController.position.maxScrollExtent) {
        //check paginated state
        if(vm.paginatedState != ViewState.error){
          //check if data is not being currently fetched and also check total records
          if (vm.paginatedState != ViewState.busy && vm.filteredResults.length < vm.totalRecords) {
            //fetch more transactions(filters)
            vm.fetchFilteredResults(
                hasWallet: profileVm.hasWallet && configVm.isWalletEnabled,
                firstCall: false
            );
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(walletTransactionsViewModel);
    final transactionFiltersVm = ref.watch(transactionFiltersViewModel);
    final profileVm = ref.watch(profileViewModel);
    final configVm = ref.watch(configViewModel);

    return Scaffold(
      appBar: customAppBar(
        context: context,
        centerTitle: false,
        useCustomTitleWidget: true,
        titleWidget: FittedBox(
          child: RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
              children: [
                TextSpan(
                  text: transactionFiltersVm.showFilteredList ? transactionFiltersVm.title(
                    hasWallet: profileVm.hasWallet && configVm.isWalletEnabled
                  ):'Transaction History',
                ),
                TextSpan(
                  text: transactionFiltersVm.showFilteredList ? '(${transactionFiltersVm.totalRecords})':'(${vm.totalRecords})',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: ColorPath.turquoiseGreen
                  ),
                ),
          
              ],
            ),
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
                    options: transactionFiltersVm.getTransactionFilterOptions(
                      includeWalletTransactions: profileVm.hasWallet && configVm.isWalletEnabled,
                    ),
                    initialValue: transactionFiltersVm.selectedFilter,
                    selectedOption: (value)async{
                      transactionFiltersVm.selectedFilter = value;
                      if(transactionFiltersVm.selectedFilter.toLowerCase() != 'show all'){
                        await transactionFiltersVm.fetchFilteredResults(
                          hasWallet: configVm.isWalletEnabled && profileVm.hasWallet
                        );
                        showFlushBar(
                            context: context,
                            message: transactionFiltersVm.message,
                          success: transactionFiltersVm.state == ViewState.retrieved
                        );
                      }else{
                        transactionFiltersVm.showFilteredList = false;
                      }
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
        child: Builder(
          builder: (context) {

            if(transactionFiltersVm.showFilteredList){

              if(transactionFiltersVm.state == ViewState.busy){
                return Center(
                  child: AppLoader(),
                );
              }

              if(transactionFiltersVm.state == ViewState.retrieved){

                if(transactionFiltersVm.filteredResults.isEmpty){
                  return Center(
                    child: EmptyState(
                      asset: AppAsset.emptyState,
                      title: 'No Results',
                      subtitle: 'no results ',
                    ),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: RefreshIndicator.adaptive(
                        onRefresh: () => _refreshTransactions(
                          hasWallet: profileVm.hasWallet && configVm.isWalletEnabled
                        ),
                        backgroundColor: Colors.white,
                        color: Theme.of(context).colorScheme.brandColor,
                        child: ListView.separated(
                          controller: _filterScrollController,
                          itemCount: transactionFiltersVm.filteredResults.length,
                          physics: const AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemBuilder: (BuildContext context, int index) {
                            final transaction = transactionFiltersVm.filteredResults[index];
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
                        ),
                      ),
                    ),
                    if(transactionFiltersVm.paginatedState == ViewState.busy)
                      Padding(
                        padding: EdgeInsets.only(top: 5.h),
                        child: const Align(
                          alignment: Alignment.center,
                          child: AppLoader(
                            size: 16,
                          ),
                        ),
                      ),
                    if(transactionFiltersVm.paginatedState == ViewState.error)
                      ErrorState(
                          message: transactionFiltersVm.message,
                          isPaginationType: true,
                          onPressed: ()=>transactionFiltersVm.fetchFilteredResults(
                              hasWallet: configVm.isWalletEnabled && profileVm.hasWallet,
                              firstCall: false))
                  ],
                );
              }

              if(transactionFiltersVm.state == ViewState.error){
                return Center(
                  child: ErrorState(
                      message: transactionFiltersVm.message,
                      onPressed: ()=>transactionFiltersVm.fetchFilteredResults(
                        hasWallet: configVm.isWalletEnabled && profileVm.hasWallet
                      )),
                );
              }

              return const SizedBox.shrink();

            }
            else{

              if(vm.state == ViewState.busy){
                return Center(
                  child: AppLoader(),
                );
              }

              if(vm.state == ViewState.retrieved){

                if(vm.transactions.isEmpty){
                  return Center(
                    child: EmptyState(
                      asset: AppAsset.emptyState,
                      title: 'No Transactions',
                      subtitle: 'no transactions yet ',
                    ),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: RefreshIndicator.adaptive(
                        onRefresh: () => _refreshTransactions(
                          hasWallet: configVm.isWalletEnabled && profileVm.hasWallet
                        ),
                        backgroundColor: Colors.white,
                        color: Theme.of(context).colorScheme.brandColor,
                        child: ListView.separated(
                          controller: _scrollController,
                          itemCount: vm.transactions.length,
                          physics: const AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemBuilder: (BuildContext context, int index) {
                            final transaction = vm.transactions[index];
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
                        ),
                      ),
                    ),
                    if(vm.paginatedState == ViewState.busy)
                      Padding(
                        padding: EdgeInsets.only(top: 5.h),
                        child: const Align(
                          alignment: Alignment.center,
                          child: AppLoader(
                            size: 16,
                          ),
                        ),
                      ),
                    if(vm.paginatedState == ViewState.error)
                      ErrorState(
                          message: vm.message,
                          isPaginationType: true,
                          onPressed: ()=>vm.fetchTransactions(firstCall: false))
                  ],
                );
              }

              if(vm.state == ViewState.error){
                return Center(
                  child: ErrorState(
                    message: vm.message,
                      onPressed: ()=>vm.fetchTransactions()),
                );
              }

              return const SizedBox.shrink();
            }

          }
        ),
      ),
    );
  }

  Future<void> _refreshTransactions({required bool hasWallet}) async {
    final filterTransactionsVm = ref.read(transactionFiltersViewModel);
    final transactionsVm = ref.read(walletTransactionsViewModel);
    if(filterTransactionsVm.showFilteredList){
      filterTransactionsVm.fetchFilteredResults(
        hasWallet: hasWallet,
          refreshUi: false);
    }else{
      transactionsVm.fetchTransactions(refreshUi: false);
    }
  }
}
