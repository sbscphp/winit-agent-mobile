import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/utilities/extensions/color_extensions.dart';




// baseDialog({required BuildContext context,
//   required Widget content
// }){
//   return BounceInLeft(
//     duration: const Duration(milliseconds: 800),
//     child: AlertDialog(
//       contentPadding: EdgeInsets.zero,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12.r),
//       ),
//       content: content,
//     ),
//   );
// }


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