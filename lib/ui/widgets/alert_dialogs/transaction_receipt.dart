import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/core/utilities/date_utilitites.dart';
import 'package:winit_agent/ui/widgets/close_icon.dart';
import 'package:winit_agent/ui/widgets/status_tag.dart';
import '../../../core/constants/app_asset.dart';
import '../../../core/data/models/transaction.dart';
import '../../../core/utilities/receipt_utils.dart';
import '../../../core/utilities/utilities.dart';
import '../custom_button.dart';
import '../naira_display.dart';

class TransactionReceipt extends StatefulWidget {
  final Transaction transaction;
  final bool isReferral;
  const TransactionReceipt({super.key, required this.transaction, this.isReferral = false});

  @override
  State<TransactionReceipt> createState() => _TransactionReceiptState();
}

class _TransactionReceiptState extends State<TransactionReceipt> {

  late GlobalKey _globalKey;

  @override
  void initState() {
    _globalKey = GlobalKey();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 24.h,
        horizontal: 16.w
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _receiptTile(),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: Theme.of(context).colorScheme.textPrimary
                      ),
                    ),
                    SizedBox(height: 4.h,),
                    Text(
                      'A snap shot of the transaction details',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.textTertiary
                      ),
                    ),

                  ],
                ),
              ),
             CloseIcon()

            ],
          ),
          SizedBox(height: 16.h,),
          RepaintBoundary(
              key: _globalKey,
              child: _transactionDetails(context)),
          SizedBox(height: 16.h,),
          CustomButton(
              buttonText: 'Download Receipt',
              suffixIcon: AppAsset.downloadReceipt,
              onPressed: () {
                ReceiptUtils.saveImageToGallery(key: _globalKey, context: context);
              }
          )

        ],
      ),
    );
  }

  commission(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Transaction Date',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.textTertiary
              ),
            ),
            SizedBox(width: 20.w,),
            Text(
              'Jan 25 2025',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.textPrimary
              )),
          ],
        ),
        SizedBox(height: 10.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Transaction Time',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.textTertiary
              ),
            ),
            SizedBox(width: 20.w,),
            Text(
                '11:00AM',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.textPrimary
                )),
          ],
        ),
        SizedBox(height: 10.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Transaction Reference ID',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.textTertiary
              ),
            ),
            SizedBox(width: 20.w,),
            Expanded(
              child: Text(
                  '678393',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.textPrimary
                  ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Commission Percentage',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.textTertiary
              ),
            ),
            SizedBox(width: 20.w,),
            Text(
                '2%',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.textPrimary
                )),
          ],
        ),
        SizedBox(height: 10.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Commission Amount',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.textTertiary
              ),
            ),
            SizedBox(width: 20.w,),
            Flexible(
              child: NairaDisplay(
                amount: 202222,
                fontSize: 14.sp,
                color:Theme.of(context).colorScheme.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'Commission earned Via (Game)',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.textTertiary
                ),
              ),
            ),
            SizedBox(width: 20.w,),
            Expanded(
              child: Text(
                  'Win 4BD Flat (ID:2003)',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.textPrimary
                  ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Commission Paid to',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.textTertiary
              ),
            ),
            SizedBox(width: 20.w,),
            Expanded(
              child: Text(
                'Wallet ${Utilities.maskCharacters(subject: '203546677', startIndex: 2, endIndex: 6)}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.textPrimary
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'Commission remittances Status',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.textTertiary
                ),
              ),
            ),
            SizedBox(width: 20.w,),
            Expanded(
              child: StatusTag(status: 'successful', returnOnlyText: true, useEndAlignment: true,),
            ),
          ],
        ),

      ],
    );
  }

  bonus(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Transaction Date',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.textTertiary
              ),
            ),
            SizedBox(width: 20.w,),
            Text(
                'Jan 25 2025',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.textPrimary
                )),
          ],
        ),
        SizedBox(height: 10.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Transaction Time',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.textTertiary
              ),
            ),
            SizedBox(width: 20.w,),
            Text(
                '11:00AM',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.textPrimary
                )),
          ],
        ),
        SizedBox(height: 10.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Transaction Reference ID',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.textTertiary
              ),
            ),
            SizedBox(width: 20.w,),
            Expanded(
              child: Text(
                '678393',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.textPrimary
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Commission Percentage',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.textTertiary
              ),
            ),
            SizedBox(width: 20.w,),
            Text(
                '2%',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.textPrimary
                )),
          ],
        ),
        SizedBox(height: 10.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Commission Amount',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.textTertiary
              ),
            ),
            SizedBox(width: 20.w,),
            Flexible(
              child: NairaDisplay(
                amount: 202222,
                fontSize: 14.sp,
                color:Theme.of(context).colorScheme.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'Commission earned Via (Game)',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.textTertiary
                ),
              ),
            ),
            SizedBox(width: 20.w,),
            Expanded(
              child: Text(
                'Win 4BD Flat (ID:2003)',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.textPrimary
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Commission Paid to',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.textTertiary
              ),
            ),
            SizedBox(width: 20.w,),
            Expanded(
              child: Text(
                'Wallet ${Utilities.maskCharacters(subject: '203546677', startIndex: 2, endIndex: 6)}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.textPrimary
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'Commission remittances Status',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.textTertiary
                ),
              ),
            ),
            SizedBox(width: 20.w,),
            Expanded(
              child: StatusTag(status: 'successful', returnOnlyText: true, useEndAlignment: true,),
            ),
          ],
        ),

      ],
    );
  }

  ticketPurchase(BuildContext context){
    final gameName = widget.transaction.gameName ?? 'N/A';
    final date = DateUtilities.abbrevMonthDayYear(widget.transaction.createdAt?.toString() ?? DateTime.now().toString());
    final time = DateUtilities.formatTimeAMPM(dateTime: widget.transaction.createdAt ?? DateTime.now());
    final reference = widget.transaction.referenceId ?? 'N/A';
    final ticketCount = double.tryParse(widget.transaction.ticketCount?.toString() ?? '0') ?? 0;
    final amount = double.tryParse(widget.transaction.amount?.toString() ?? '0') ?? 0;
    final paidVia = widget.transaction.paidVia ?? 'N/A';
    final isPaidViaWallet = paidVia.toLowerCase() == 'agent_wallet';
    final walletAccountNumber = widget.transaction.bankAccount?.accountNumber ?? '';
    final status = widget.transaction.status ?? '';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'Raffle Game Applicable',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.textTertiary
                ),
              ),
            ),
            SizedBox(width: 20.w,),
            Flexible(
              child: Text(
                  gameName,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.textPrimary
                  ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Transaction Date',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.textTertiary
              ),
            ),
            SizedBox(width: 20.w,),
            Text(
                date,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.textPrimary
                )),
          ],
        ),
        SizedBox(height: 10.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Transaction Time',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.textTertiary
              ),
            ),
            SizedBox(width: 20.w,),
            Text(
                time,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.textPrimary
                )),
          ],
        ),
        SizedBox(height: 10.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Transaction Reference ID',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.textTertiary
              ),
            ),
            SizedBox(width: 20.w,),
            Expanded(
              child: Text(
                reference,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.textPrimary
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Number of Tickets',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.textTertiary
              ),
            ),
            SizedBox(width: 20.w,),
            Text(
                Utilities.formatAmount(
                  amount: ticketCount,
                  addDecimal: false
                ),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.textPrimary
                )),
          ],
        ),
        SizedBox(height: 10.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total Amount Paid',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.textTertiary
              ),
            ),
            SizedBox(width: 20.w,),
            Flexible(
              child: NairaDisplay(
                amount: amount,
                fontSize: 14.sp,
                color:Theme.of(context).colorScheme.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Paid Via',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.textTertiary
              ),
            ),
            SizedBox(width: 20.w,),
            Expanded(
              child: Text(
                isPaidViaWallet ?
                'Wallet ${Utilities.maskCharacters(subject:walletAccountNumber, startIndex: 2, endIndex: 5)}'
                :paidVia,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.textPrimary
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'Transaction Status',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.textTertiary
                ),
              ),
            ),
            SizedBox(width: 20.w,),
            Expanded(
              child: StatusTag(status: status, returnOnlyText: true, useEndAlignment: true,),
            ),
          ],
        ),

      ],
    );
  }

  walletTopUp(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Transaction Date',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.textTertiary
              ),
            ),
            SizedBox(width: 20.w,),
            Text(
                'Jan 25 2025',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.textPrimary
                )),
          ],
        ),
        SizedBox(height: 10.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Transaction Time',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.textTertiary
              ),
            ),
            SizedBox(width: 20.w,),
            Text(
                '11:00AM',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.textPrimary
                )),
          ],
        ),
        SizedBox(height: 10.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Transaction Reference ID',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.textTertiary
              ),
            ),
            SizedBox(width: 20.w,),
            Expanded(
              child: Text(
                '678393',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.textPrimary
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Top into',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.textTertiary
              ),
            ),
            SizedBox(width: 20.w,),
            Expanded(
              child: Text(
                'Wallet ${Utilities.maskCharacters(subject: '203546677', startIndex: 2, endIndex: 6)}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.textPrimary
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Paid Via',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.textTertiary
              ),
            ),
            SizedBox(width: 20.w,),
            Expanded(
              child: Text(
                'Paystack',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.textPrimary
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Wallet Top Up Value',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.textTertiary
              ),
            ),
            SizedBox(width: 20.w,),
            Flexible(
              child: NairaDisplay(
                amount: 202222,
                fontSize: 14.sp,
                color:Theme.of(context).colorScheme.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'Transaction Status',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.textTertiary
                ),
              ),
            ),
            SizedBox(width: 20.w,),
            Expanded(
              child: StatusTag(status: 'successful', returnOnlyText: true, useEndAlignment: true,),
            ),
          ],
        ),

      ],
    );
  }

  fundWithdrawal(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Transaction Date',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.textTertiary
              ),
            ),
            SizedBox(width: 20.w,),
            Text(
                'Jan 25 2025',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.textPrimary
                )),
          ],
        ),
        SizedBox(height: 10.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Transaction Time',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.textTertiary
              ),
            ),
            SizedBox(width: 20.w,),
            Text(
                '11:00AM',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.textPrimary
                )),
          ],
        ),
        SizedBox(height: 10.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Transaction Reference ID',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.textTertiary
              ),
            ),
            SizedBox(width: 20.w,),
            Expanded(
              child: Text(
                '678393',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.textPrimary
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Withdraw into',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.textTertiary
              ),
            ),
            SizedBox(width: 20.w,),
            Expanded(
              child: Text(
                'Access Bank : 0069000592',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.textPrimary
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Withdraw Via',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.textTertiary
              ),
            ),
            SizedBox(width: 20.w,),
            Expanded(
              child: Text(
                'Paystack',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.textPrimary
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Withdrawal Value',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.textTertiary
              ),
            ),
            SizedBox(width: 20.w,),
            Flexible(
              child: NairaDisplay(
                amount: 202222,
                fontSize: 14.sp,
                color:Theme.of(context).colorScheme.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'Transaction Status',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.textTertiary
                ),
              ),
            ),
            SizedBox(width: 20.w,),
            Expanded(
              child: StatusTag(status: 'successful', returnOnlyText: true, useEndAlignment: true,),
            ),
          ],
        ),

      ],
    );
  }

  referral(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Transaction Date',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.textTertiary
              ),
            ),
            SizedBox(width: 20.w,),
            Text(
                'Jan 25 2025',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.textPrimary
                )),
          ],
        ),
        SizedBox(height: 10.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Transaction Time',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.textTertiary
              ),
            ),
            SizedBox(width: 20.w,),
            Text(
                '11:00AM',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.textPrimary
                )),
          ],
        ),
        SizedBox(height: 10.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Transaction Reference ID',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.textTertiary
              ),
            ),
            SizedBox(width: 20.w,),
            Expanded(
              child: Text(
                '678393',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.textPrimary
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'Transaction Type',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.textTertiary
                ),
              ),
            ),
            SizedBox(width: 20.w,),
            Flexible(
              child: Text(
                  'Referral Transaction',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.textPrimary
                  ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Paid Via',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.textTertiary
              ),
            ),
            SizedBox(width: 20.w,),
            Flexible(
              child: Text(
                'PayStack',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.textPrimary
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Transaction Value',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.textTertiary
              ),
            ),
            SizedBox(width: 20.w,),
            Flexible(
              child: NairaDisplay(
                amount: 202222,
                fontSize: 14.sp,
                color:Theme.of(context).colorScheme.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Paid to',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.textTertiary
              ),
            ),
            SizedBox(width: 20.w,),
            Expanded(
              child: Text(
                'Wallet ${Utilities.maskCharacters(subject: '203546677', startIndex: 2, endIndex: 6)}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.textPrimary
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'Transaction Status',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.textTertiary
                ),
              ),
            ),
            SizedBox(width: 20.w,),
            Expanded(
              child: StatusTag(status: 'successful', returnOnlyText: true, useEndAlignment: true,),
            ),
          ],
        ),

      ],
    );
  }

  String _receiptTile(){
    switch(widget.transaction.transactionType?.toLowerCase()){
      case 'topup':
        return 'Wallet Top Up';
      case 'purchase':
        return 'Ticket Purchase Transaction';
      case 'withdrawal':
        return 'Fund Withdrawal';
      case 'commission':
        return 'Commission Transaction';
      case 'bonus':
        return 'Performance Commission.';

      default:
        if(widget.isReferral){
          return 'Referral Transaction';
        }
        return 'Wallet Transaction';
    }
  }

  Widget _transactionDetails(BuildContext context){
    switch(widget.transaction.transactionType?.toLowerCase()){
      case 'topup':
        return walletTopUp(context);
      case 'purchase':
        return ticketPurchase(context);
      case 'withdrawal':
        return fundWithdrawal(context);
      case 'commission':
        return commission(context);
      case 'bonus':
        return bonus(context);
      default:
        if(widget.isReferral){
          return referral(context);
        }
        return ticketPurchase(context);
    }
  }
}
