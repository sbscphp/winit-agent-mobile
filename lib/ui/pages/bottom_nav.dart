// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:winit_agent/core/data/view_models/authentication_view_models/login_view_model.dart';
// import 'package:winit_agent/core/data/view_models/bottom_nav_view_model.dart';
// import 'package:winit_agent/core/data/view_models/notification_view_models/notification_settings_view_model.dart';
// import 'package:winit_agent/core/data/view_models/profile_view_models/profile_view_model.dart';
// import 'package:winit_agent/core/data/view_models/profile_view_models/spend_limit_view_model.dart';
// import 'package:winit_agent/core/data/view_models/referral_view_model.dart';
// import 'package:winit_agent/core/utilities/firebase_messaging_utils.dart';
// import 'package:winit_agent/ui/widgets/custom_bottom_nav.dart';
//
// class BottomNav extends ConsumerStatefulWidget {
//   const BottomNav({super.key});
//
//   @override
//   ConsumerState<BottomNav> createState() => _BottomNavState();
// }
//
// class _BottomNavState extends ConsumerState<BottomNav> {
//
//   @override
//   void initState() {
//
//     //init push notification listeners
//     //FirebaseMessagingUtils.pushNotificationListenerInit(context: context, ref: ref);
//
//     super.initState();
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop: false,
//       onPopInvokedWithResult: (bool didPop, Object? result) async {
//         if (didPop) {
//           return;
//         }
//       },
//       child: AnnotatedRegion<SystemUiOverlayStyle>(
//         value: SystemUiOverlayStyle.light,
//         child: Scaffold(
//             extendBodyBehindAppBar: true,
//           // floatingActionButton: GestureDetector(
//           //   onTap: () {
//           //     // Handle center tap
//           //   },
//           //   child: Container(
//           //     width: 120,
//           //     height: 120,
//           //     decoration: BoxDecoration(
//           //       shape: BoxShape.circle,
//           //       color: Colors.blue,
//           //       boxShadow: [
//           //         BoxShadow(
//           //           color: Colors.black26,
//           //           blurRadius: 8,
//           //           offset: Offset(0, 4),
//           //         ),
//           //       ],
//           //     ),
//           //     child: Icon(Icons.add, color: Colors.white),
//           //   ),
//           // ),
//           // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//             bottomNavigationBar: loginVm.isLoggedIn ? Container(
//               decoration: const BoxDecoration(
//                 color: Colors.transparent,
//                 // boxShadow: [
//                 //   BoxShadow(
//                 //     color: Colors.black.withOpacity(0.1),
//                 //     spreadRadius: 2,
//                 //     blurRadius: 2,
//                 //     offset: const Offset(0, 0.75),
//                 //   ),
//                 // ],
//               ),
//               child: Theme(
//                 data: Theme.of(context).copyWith(
//                   splashColor: Colors.transparent,
//                   highlightColor: Colors.transparent,
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.only(top: 0.h),
//                   child: CustomBottomNav(
//                   selectedIndex: bottomNavVm.currentIndex,
//                   onChanged: (index) {
//                     bottomNavVm.updateIndex(index);
//                   },
//                 ),
//                   // child: BottomNavigationBar(
//                   //     onTap: (index){
//                   //       // if(index == 2){
//                   //       //   pushNavigation(context: context, widget: const Search(), routeName: NamedRoutes.search);
//                   //       //   return;
//                   //       // }
//                   //       bottomNavVm.updateIndex(index);
//                   //     },
//                   //     type: BottomNavigationBarType.fixed,
//                   //     unselectedFontSize: 14.sp,
//                   //     selectedFontSize: 14.sp,
//                   //     selectedItemColor: ColorPath.curiousBlue,
//                   //     unselectedItemColor: Theme.of(context).colorScheme.textPrimary,
//                   //     selectedLabelStyle: const TextStyle(
//                   //       fontWeight: FontWeight.w800
//                   //     ),
//                   //     unselectedLabelStyle: const TextStyle(
//                   //         fontWeight: FontWeight.w500
//                   //     ),
//                   //     elevation: 0,
//                   //     backgroundColor: Colors.transparent,
//                   //     currentIndex: bottomNavVm.currentIndex,
//                   //     items: bottomNavItems(context)),
//                 ),
//               ),
//             ):null,
//             body: SafeArea(
//                 top: false,
//                 bottom: false,
//                 child: IndexedStack(
//                     index: bottomNavVm.currentIndex, children: bottomNavVm.children)),
//           ),
//       ),
//     );
//   }
// }
