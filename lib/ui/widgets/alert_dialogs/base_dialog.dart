import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/utilities/extensions/color_extensions.dart';




Future<void> baseDialog({
  required BuildContext context,
  required Widget content,
  bool isDismissible = true,
  VoidCallback? onClosed,
}) async{
  await showGeneralDialog(
    context: context,
    barrierDismissible: isDismissible,
    barrierLabel: "BaseDialog",
    barrierColor: Colors.black.withCustomOpacity(0.32),
    transitionDuration: const Duration(milliseconds: 50),
    pageBuilder: (_, __, ___) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Center(
          child: SlideInDown(
            from: MediaQuery.of(context).size.height,
            duration: const Duration(milliseconds: 800),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: PopScope(
                canPop: isDismissible,
                child: Dialog(
                  insetPadding: EdgeInsets.symmetric(horizontal: 32.w),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width, // now respected
                    child: content,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
  if (onClosed != null) onClosed();
}



Future<void> controllableBaseDialog({
  required BuildContext context,
  Widget Function(BuildContext, void Function(bool))? builder,
  bool isDismissible = true,
  VoidCallback? onClosed,
}) async {
  final ValueNotifier<bool> dismissibleNotifier = ValueNotifier(isDismissible);
  await showGeneralDialog(
    context: context,
    barrierLabel: "BaseDialog",
    barrierColor: Colors.black.withCustomOpacity(0.32),
    transitionDuration: const Duration(milliseconds: 50),
    barrierDismissible: dismissibleNotifier.value,
    pageBuilder: (_, __, ___) {
      return ValueListenableBuilder<bool>(
        valueListenable: dismissibleNotifier,
        builder: (_, canDismiss, __) {
          return PopScope(
            canPop: canDismiss,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Center(
                child: SlideInDown(
                  from: MediaQuery.of(context).size.height,
                  duration: const Duration(milliseconds: 800),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Dialog(
                      insetPadding:
                      EdgeInsets.symmetric(horizontal: 32.w),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      child: builder != null ? builder(context, (bool value) {
                        dismissibleNotifier.value = value;
                      }):null,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    },
  );

  if (onClosed != null) onClosed();
}



























// Future<void> baseDialog({
//   required BuildContext context,
//   required Widget content,
//   bool isDismissible = true
// }) {
//   return showGeneralDialog(
//     context: context,
//     barrierDismissible: isDismissible,
//     barrierLabel: "BaseDialog",
//     barrierColor: Colors.black.withCustomOpacity(0.32),
//     transitionDuration: const Duration(milliseconds: 300),
//     pageBuilder: (_, __, ___) {
//       return BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
//         child: Center(
//           child: SlideInDown(
//             duration: const Duration(milliseconds: 400),
//             child: SizedBox(
//               width: MediaQuery.of(context).size.width,
//               child: AlertDialog(
//                 contentPadding: EdgeInsets.zero,
//                 insetPadding: EdgeInsets.symmetric(horizontal: 17.w),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(24.r),
//                 ),
//                 content: SizedBox(
//                   width: MediaQuery.of(context).size.width,
//                     child: content),
//               ),
//             ),
//           ),
//         ),
//       );
//     },
//   );
// }

