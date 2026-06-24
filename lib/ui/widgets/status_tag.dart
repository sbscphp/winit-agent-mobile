import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/color_path.dart';
import '../../core/utilities/utilities.dart';

class StatusTag extends StatelessWidget {
  final String status;
  final bool useEndAlignment;
  final bool returnOnlyText;
  const StatusTag({super.key, required this.status,this.useEndAlignment = false, this.returnOnlyText = false});

  @override
  Widget build(BuildContext context) {
    if(returnOnlyText){
      return Text(
        _statusText(status: status),
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: _statusTextColor(status: status),
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.right,
      );
    }
    return Row(
      mainAxisAlignment: useEndAlignment ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: _statusContainerColor(status: status),
            borderRadius: BorderRadius.all(Radius.circular(16.r)),
          ),
          child: Center(
            child: Text(
              _statusText(status: status),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: _statusTextColor(status: status),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Color _statusContainerColor({required String status}) {
    switch (status.toLowerCase()) {
      case 'accepted':
      case 'completed':
      case 'verified':
      case 'successful':
      case 'redeemed':
        return ColorPath.scandalGreen;
      case 'pending':
      case 'in-progress':
      case 'invited':
      case 'pending_purchase':
        return ColorPath.barleyOrange; //dawnBrown
      case 'failed':
      case 'rejected':
      case 'ignored':
        return ColorPath.pippinPink;
      default:
        return Colors.white;
    }
  }

  //returns status color
  Color _statusTextColor({required String status}) {
    switch (status.toLowerCase()) {
      case 'accepted':
      case 'completed':
      case 'verified':
      case 'successful':
      case 'redeemed':
        return ColorPath.hazeGreen;
      case 'pending':
      case 'in-progress':
      case 'invited':
      case 'pending_purchase':
        return ColorPath.vesuBrown;
      case 'failed':
      case 'rejected':
      case 'ignored':
        return ColorPath.ribbonRed;
      default:
        return Colors.white;
    }
  }

  String _statusText({required String? status}) {
    if (status == null) return '';
    return status.isEmpty ? 'N/A' : Utilities.capitalizeWord(status);
  }
}
