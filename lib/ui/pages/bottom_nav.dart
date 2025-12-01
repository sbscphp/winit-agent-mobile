import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/data/view_models/authentication/logout_vm.dart';
import 'package:winit_agent/core/data/view_models/bottom_nav_view_model.dart';
import 'package:winit_agent/ui/widgets/custom_bottom_nav.dart';

import '../../core/data/enum/view_state.dart';

class BottomNav extends ConsumerStatefulWidget {
  const BottomNav({super.key});

  @override
  ConsumerState<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends ConsumerState<BottomNav> {

  @override
  void initState() {

    //init push notification listeners
    //FirebaseMessagingUtils.pushNotificationListenerInit(context: context, ref: ref);

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(bottomNavViewModel);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (didPop) {
          return;
        }
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Scaffold(
            extendBodyBehindAppBar: true,
            bottomNavigationBar: Container(
              decoration: const BoxDecoration(
                color: Colors.transparent,
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.black.withOpacity(0.1),
                //     spreadRadius: 2,
                //     blurRadius: 2,
                //     offset: const Offset(0, 0.75),
                //   ),
                // ],
              ),
              child: Theme(
                data: Theme.of(context).copyWith(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 0.h),
                  child: Consumer(
                    builder: (context, ref, child){
                      final logoutVm = ref.watch(logoutViewModel);
                      return IgnorePointer(
                        ignoring: logoutVm.state == ViewState.busy,
                        child: CustomBottomNav(
                          selectedIndex: vm.currentIndex,
                          onChanged: (index) {
                            vm.updateIndex(index);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            body: SafeArea(
                top: false,
                bottom: false,
                child: IndexedStack(
                    index: vm.currentIndex, children: vm.children)),
          ),
      ),
    );
  }
}
