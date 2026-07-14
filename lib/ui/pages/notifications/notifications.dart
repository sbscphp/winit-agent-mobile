import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/core/constants/named_routes.dart';
import 'package:winit_agent/core/data/view_models/notification/notification_filters_vm.dart';
import 'package:winit_agent/core/data/view_models/notification/notification_settings_vm.dart';
import 'package:winit_agent/core/data/view_models/notification/notifications_vm.dart';
import 'package:winit_agent/core/utilities/navigator.dart';
import 'package:winit_agent/ui/pages/notifications/notification_settings.dart';
import 'package:winit_agent/ui/widgets/listview_items/notification_item.dart';

import '../../../core/constants/app_asset.dart';
import '../../../core/constants/app_dimension.dart';
import '../../../core/constants/color_path.dart';
import '../../../core/data/enum/view_state.dart';
import '../../widgets/action_icon.dart';
import '../../widgets/app_loader.dart';
import '../../widgets/bottom_sheets/base_bottom_sheet.dart';
import '../../widgets/bottom_sheets/filter_options.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/error_state.dart';
import '../../widgets/show_flush_bar.dart';


class Notifications extends ConsumerStatefulWidget {
  const Notifications({super.key});

  @override
  ConsumerState<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends ConsumerState<Notifications> {

  late ScrollController _scrollController, _filterScrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _filterScrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(notificationsViewModel).fetchNotifications();
      ref.read(notificationSettingsViewModel).fetchNotificationSettings();
    });
    _scrollListener();
    _filterScrollListener();
    super.initState();
  }

  _scrollListener() {
    final vm = ref.read(notificationsViewModel);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        //check paginated state
        if(vm.paginatedState != ViewState.error){
          //check if data is not being currently fetched and also check total records
          if (vm.paginatedState != ViewState.busy && vm.notifications.length < vm.totalRecords) {
            //fetch more notifications
            vm.fetchNotifications(
                firstCall: false
            );
          }
        }
      }
    });
  }

  _filterScrollListener() {
    final vm = ref.read(notificationFiltersViewModel);
    _filterScrollController.addListener(() {
      if (_filterScrollController.position.pixels ==
          _filterScrollController.position.maxScrollExtent) {
        //check paginated state
        if(vm.paginatedState != ViewState.error){
          //check if data is not being currently fetched and also check total records
          if (vm.paginatedState != ViewState.busy && vm.filteredResults.length < vm.totalRecords) {
            //fetch more notifications(filters)
            vm.fetchFilteredResults(
                firstCall: false
            );
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(notificationsViewModel);
    final notificationFiltersVm = ref.watch(notificationFiltersViewModel);
    return Scaffold(
      appBar: customAppBar(
          context: context,
          showLeadingIcon: false,
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
                    text: notificationFiltersVm.showFilteredList ? notificationFiltersVm.title():'Notifications',
                  ),
                  TextSpan(
                    text: notificationFiltersVm.showFilteredList ? '(${notificationFiltersVm.totalRecords})':'(${vm.totalRecords})',
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
            ActionIcon(label: 'Settings', asset: AppAsset.settings,
              paddingRight: 8.w,
              onPressed: (){
                pushNavigation(context: context, widget: const NotificationSettings(), routeName: NamedRoutes.notificationSettings);
              },
            ),
            ActionIcon(label: 'Filter', asset: AppAsset.filter,
              onPressed: (){
                baseBottomSheet(
                  context: context,
                  content: FilterOptions(
                    label: 'Filter Notification',
                    subtitle: 'Filter notification with ease',
                    options: notificationFiltersVm.notificationFilterOptions,
                    initialValue: notificationFiltersVm.selectedFilter,
                    selectedOption: (value)async{
                      notificationFiltersVm.selectedFilter = value;
                      if(notificationFiltersVm.selectedFilter.toLowerCase() != 'show all'){
                        await notificationFiltersVm.fetchFilteredResults();
                        showFlushBar(
                            context: context,
                            message: notificationFiltersVm.message,
                            success: notificationFiltersVm.state == ViewState.retrieved
                        );
                      }else{
                        notificationFiltersVm.showFilteredList = false;
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
            vertical: 32.h
        ),
        child: Builder(
          builder: (context) {

            if(notificationFiltersVm.showFilteredList){

              if(notificationFiltersVm.state == ViewState.busy){
                return Center(
                  child: AppLoader(),
                );
              }

              if(notificationFiltersVm.state == ViewState.retrieved){

                if(notificationFiltersVm.filteredResults.isEmpty){
                  return Center(
                    child:EmptyState(
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
                        onRefresh: () => _refreshNotifications(),
                        backgroundColor: Colors.white,
                        color: Theme.of(context).colorScheme.brandColor,
                        child: ListView.separated(
                          controller: _filterScrollController,
                          itemCount: notificationFiltersVm.filteredResults.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemBuilder: (BuildContext context, int index) {
                            final notification = notificationFiltersVm.filteredResults[index];
                            return NotificationItem(notification: notification);
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 16.h,);
                          },
                        ),
                      ),
                    ),
                    if(notificationFiltersVm.paginatedState == ViewState.busy)
                      Padding(
                        padding: EdgeInsets.only(top: 5.h),
                        child: const Align(
                          alignment: Alignment.center,
                          child: AppLoader(
                            size: 16,
                          ),
                        ),
                      ),
                    if(notificationFiltersVm.paginatedState == ViewState.error)
                      ErrorState(
                          message: notificationFiltersVm.message,
                          isPaginationType: true,
                          onPressed: ()=>notificationFiltersVm.fetchFilteredResults(firstCall: false))
                  ],
                );
              }

              if(notificationFiltersVm.state == ViewState.error){
                return Center(
                  child: ErrorState(
                      message: notificationFiltersVm.message,
                      onPressed: ()=>notificationFiltersVm.fetchFilteredResults()),
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

                if(vm.notifications.isEmpty){
                  return Center(
                    child: EmptyState(
                      asset: AppAsset.emptyState,
                      title: 'No Notification Yet',
                      subtitle: 'You currently have no notification yet. ',
                    ),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: RefreshIndicator.adaptive(
                        onRefresh: () => _refreshNotifications(),
                        backgroundColor: Colors.white,
                        color: Theme.of(context).colorScheme.brandColor,
                        child: ListView.separated(
                          controller: _scrollController,
                          itemCount: vm.notifications.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemBuilder: (BuildContext context, int index) {
                            final notification = vm.notifications[index];
                            return NotificationItem(notification: notification);
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
                          onPressed: ()=>vm.fetchNotifications(firstCall: false))
                  ],
                );
              }

              if(vm.state == ViewState.error){
                return Center(
                  child: ErrorState(
                      message: vm.message,
                      onPressed: ()=>vm.fetchNotifications()),
                );
              }

              return const SizedBox.shrink();
            }
          }
        )
      ),
    );
  }

  Future<void> _refreshNotifications() async {
    final vm = ref.read(notificationsViewModel);
    final notificationFilterVm = ref.read(notificationFiltersViewModel);
    if(notificationFilterVm.showFilteredList){
      notificationFilterVm.fetchFilteredResults(refreshUi: false);
    }else{
      vm.fetchNotifications(refreshUi: false);
    }
  }





}
