import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:winit_agent/core/constants/app_asset.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/core/data/view_models/games/all_games_vm.dart';
import 'package:winit_agent/core/data/view_models/profile/profile_vm.dart';
import 'package:winit_agent/core/data/view_models/profile/sales_stat_vm.dart';
import 'package:winit_agent/core/data/view_models/wallet/transaction_filters_vm.dart';
import 'package:winit_agent/core/utilities/extensions/color_extensions.dart';
import 'package:winit_agent/core/utilities/navigator.dart';
import 'package:winit_agent/ui/widgets/error_state.dart';
import 'package:winit_agent/ui/widgets/listview_items/game_item.dart';
import '../../../core/constants/app_dimension.dart';
import '../../../core/constants/color_path.dart';
import '../../../core/constants/named_routes.dart';
import '../../../core/data/enum/view_state.dart';
import '../../../core/data/view_models/bottom_nav_view_model.dart';
import '../../../core/utilities/utilities.dart';
import '../../widgets/alert_dialogs/action_completed.dart';
import '../../widgets/alert_dialogs/base_dialog.dart';
import '../../widgets/alert_dialogs/transaction_receipt.dart';
import '../../widgets/balance_summary_card.dart';
import '../../widgets/clickable.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/list_header.dart';
import '../../widgets/listview_items/transaction_item.dart';
import '../../widgets/naira_display.dart';
import '../../widgets/profile/profile_image.dart';
import '../profile/transaction_pin/set_transaction_pin.dart';
import '../wallet/view_all_transactions.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {

  @override
  void initState() {
    showTransactionPinPrompt();
    final filterTransactionsVm = ref.read(transactionFiltersViewModel);
    final statsVm = ref.read(salesStatViewModel);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      filterTransactionsVm.fetchPurchaseTransactions();
      statsVm.fetchSalesStat();
    });
    super.initState();
  }

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
            salesStats(context),
            SizedBox(height: 24.h,),
            Consumer(
              builder: (context, ref, child){
                final gamesVm = ref.watch(allGamesViewModel);
                return ListHeader(
                  label: 'Live Games ',
                  subtitle: 'Play and buy Ticket for live games today',
                  showAllVisible: gamesVm.state == ViewState.retrieved && gamesVm.allGames.isNotEmpty,
                  onPressed: (){
                    final container =
                    ProviderScope.containerOf(context);

                    final bottomNavVm =
                    container.read(bottomNavViewModel);

                    bottomNavVm.updateIndex(0);
                  },
                );
              },
            ),
            SizedBox(height: 16.h,),
            games(context),
            SizedBox(height: 24.h,),
            recentPurchaseTransactions(context)


          ],
        ),
      ),
    );
  }

  games(BuildContext context){
    return Consumer(
      builder: (context, ref, child){
        final gamesVm = ref.watch(allGamesViewModel);
        if(gamesVm.state == ViewState.busy){
          return SizedBox(
            height: 200.h,
            child: ListView.separated(
              itemCount: 5,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(right: 16.w,),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Shimmer.fromColors(
                  baseColor: ColorPath.silverGrey.withCustomOpacity(0.1),
                  highlightColor: ColorPath.athensGrey2,
                  child: Container(
                    width: 172.5.w,
                    color: Theme.of(context).colorScheme.brandColor2,

                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  width: 16.w,
                );
              },
            ),
          );
        }
        if(gamesVm.state == ViewState.retrieved){
          if(gamesVm.allGames.isEmpty){
            return Center(
                child: EmptyState(
                  asset: AppAsset.emptyState,
                  title: 'No Game Yet',
                  subtitle: 'There are currently no games yet to Purchase Raffle ticket for',
                )
            );
          }
          return SizedBox(
            height: 200.h,
            child: ListView.separated(
              itemCount: gamesVm.allGames.length,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(right: 16.w,),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                final game = gamesVm.allGames[index];
                return GameItem(
                  index: index,
                  returnSmallCard: true,
                  cardWidth: 172.5.w,
                  game: game,
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  width: 16.w,
                );
              },
            ),
          );
        }

        if(gamesVm.state == ViewState.error){
          return Center(
            child: ErrorState(
              message: gamesVm.message,
                onPressed: ()=>gamesVm.fetchAllGames()),
          );
        }

        return const SizedBox.shrink();

      },
    );
  }

  recentPurchaseTransactions(BuildContext context){
    final filterTransactionsVm = ref.watch(transactionFiltersViewModel);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
            pushNavigation(context: context, widget: const ViewAllTransactions(), routeName: NamedRoutes.viewAllTransactions);
          },
        ),
        SizedBox(height: 16.h,),
        Builder(
          builder: (context) {

            if(filterTransactionsVm.secondState == ViewState.busy){
              return Shimmer.fromColors(
                baseColor: ColorPath.silverGrey.withCustomOpacity(0.1),
                highlightColor: ColorPath.athensGrey2,
                child: Container(
                  height: 90.h,
                  width: double.infinity,
                  color: Theme.of(context).colorScheme.brandColor2,

                ),
              );
            }

            if(filterTransactionsVm.secondState == ViewState.retrieved){
              if(filterTransactionsVm.purchaseTransactions.isEmpty){
                return  EmptyState(
                  asset: AppAsset.emptyState,
                  title: 'No Transaction Yet',
                  subtitle: 'You currently have no ticket purchase transaction yet. ',
                );
              }
              return ListView.separated(
                itemCount: filterTransactionsVm.purchaseTransactions.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemBuilder: (BuildContext context, int index) {
                  final transaction = filterTransactionsVm.purchaseTransactions[index];
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

            if(filterTransactionsVm.secondState == ViewState.error){
              return Center(
                child: ErrorState(
                  message: filterTransactionsVm.purchaseMessage,
                    onPressed: ()=>filterTransactionsVm.fetchPurchaseTransactions()),
              );
            }

            return const SizedBox.shrink();

          }
        )
      ],
    );
  }

  salesStats(BuildContext context){
    final salesVm = ref.watch(salesStatViewModel);
    final lga = ref.read(profileViewModel).lga;

    if(salesVm.state == ViewState.busy){
      return Column(
        children: [
          Shimmer.fromColors(
            baseColor: ColorPath.silverGrey.withCustomOpacity(0.1),
            highlightColor: ColorPath.athensGrey2,
            child: Container(
              height: 130.h,
              width: double.infinity,
              color: Theme.of(context).colorScheme.brandColor2,

            ),
          ),
          SizedBox(height: 20.h,),
          GridView.builder(
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
                return Shimmer.fromColors(
                  baseColor: ColorPath.silverGrey.withCustomOpacity(0.1),
                  highlightColor: ColorPath.athensGrey2,
                  child: Container(
                    width: double.infinity,
                    color: Theme.of(context).colorScheme.brandColor2,

                  ),
                );
              })
        ],
      );
    }

    if(salesVm.state == ViewState.retrieved){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BalanceSummaryCard(
            label: 'Total Sales',
            balance: salesVm.totalSales,
            amountAdded: salesVm.amountAdded,
            duration: salesVm.period,
          ),
          SizedBox(height: 16.h,),
          GridView.builder(
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
                        FittedBox(
                          child: Text(
                            'Total Ticket Sold',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                fontWeight: FontWeight.w400,
                                color: ColorPath.troutGrey
                            ),
                          ),
                        ),
                        SizedBox(height: 2.h,),
                        FittedBox(
                          child: Text(
                            Utilities.formatAmount(
                                amount: salesVm.totalTicketSold,
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
                        FittedBox(
                          child: Text(
                            'Commission Balance',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                fontWeight: FontWeight.w400,
                                color: ColorPath.troutGrey
                            ),
                          ),
                        ),
                        SizedBox(height: 2.h,),
                        NairaDisplay(
                          amount: salesVm.commissionsBalance,
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
                        FittedBox(
                          child: Text(
                            'Performance Commission',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                fontWeight: FontWeight.w400,
                                color: ColorPath.troutGrey
                            ),
                          ),
                        ),
                        SizedBox(height: 2.h,),
                        NairaDisplay(
                          amount: salesVm.bonusBalance,
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
                      FittedBox(
                        child: Text(
                          '${Utilities.ordinal(salesVm.position)} in $lga',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                              fontWeight: FontWeight.w400,
                              color: ColorPath.troutGrey
                          ),
                        ),
                      ),
                      SizedBox(height: 2.h,),
                      FittedBox(
                        child: Text(
                          salesVm.ticketsSoldToday == 0 ? 'O Tickets Sold Today':"${Utilities.abbreviateAmount(
                              value: salesVm.ticketsSoldToday
                          )} ${salesVm.ticketsSoldToday > 1 ? 'Tickets':'Ticket'} Sold Today",
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
              })
        ],
      );
    }

    if(salesVm.state == ViewState.error){
      return Center(
        child: ErrorState(
          message: salesVm.message,
          onPressed: ()=>salesVm.fetchSalesStat(),
        ),
      );
    }

    return const SizedBox.shrink();

  }

  showTransactionPinPrompt(){
    final profileVm = ref.read(profileViewModel);
    if(!profileVm.hasTransactionPin){
      Future.delayed(const Duration(milliseconds: 800), () {
        baseDialog(
          isDismissible: false,
          context: context,
          content: ActionCompleted(
            title: 'Transaction PIN',
            asset: AppAsset.warning,
            assetSize: 120,
            subtitle:
            'Create a transaction PIN to authorise account actions.',
            buttonText: 'Set Transaction PIN',
            onPressed: () {
              pushNavigation(context: context, widget: SetTransactionPin(
                isChangePin: false,
              ), routeName: NamedRoutes.setTransactionPin);
            },
          ),
        );
      });
    }
  }
}
