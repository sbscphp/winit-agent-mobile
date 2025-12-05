import 'package:winit_agent/core/data/models/user.dart';

import 'bank_account.dart';

class Transaction {
  final String? uuid;
  final String? agentId;
  final String? bankAccountId;
  //final String? type;
  final dynamic amount;
  final String? description;
  final String? reference;
  final String? status;
  final dynamic metadata;
  final DateTime? createdAt;
  //referral
  final User? user;
  final String? mainStatus;
  final String? reason;
  final DateTime? dateReferred;
  final dynamic rewardAmount;

  final String? transactionType;
  final DateTime? date;
  final DateTime? dateFormatted;
  final String? referenceId;
  final dynamic balanceBefore;
  final dynamic balanceAfter;
  final String? paidVia;
  final String? paymentGateway;
  final dynamic paymentChannel;
  final dynamic paymentReference;
  final BankAccount? walletInfo;
  //final String? bankAccountId;
  final BankAccount? bankAccount;
  final dynamic ticketCount;
  final dynamic unitBought;
  final String? gameId;
  final String? gameName;
  final dynamic ticketPrice;
  final dynamic ticketTotalAmount;
  final dynamic amountPurchased;
  final String? customerId;
  final String? customerFullName;
  final String? customerFirstname;
  final String? customerLastname;
  final String? customerEmail;
  final String? customerPhone;
  final String? orderId;
  final String? orderUniqueId;
  final String? purchaseId;
  final dynamic salesValue;
  final dynamic commissionAmount;
  final dynamic commissionPercentage;
  final dynamic grossCommission;
  final dynamic withholdingTax;
  final dynamic withholdingTaxPercentage;
  final dynamic commissionDisbursementId;
  final dynamic commissionDisbursementReference;
  final String? topupReference;
  final dynamic topupMethod;
  final String? topupStatus;
  final dynamic topupGateway;
  final dynamic fromAccount;
  final dynamic sourceAccountUuid;
  final String? withdrawalReference;
  final dynamic withdrawalMethod;
  final String? withdrawalStatus;
  final dynamic withdrawalGateway;
  final dynamic withdrawnInto;
  final dynamic destinationAccountUuid;
  final dynamic bonusAmount;
  final dynamic bonusReference;
  final dynamic bonusMethod;
  final dynamic bonusStatus;
  final dynamic bonusDisbursementId;
  final User? agent;
  final DateTime? updatedAt;

  Transaction({
    this.uuid,
    this.agentId,
    this.bankAccountId,
    //this.type,
    this.amount,
    this.description,
    this.reference,
    this.status,
    this.metadata,
    this.createdAt,

    //referral
    this.user,
    this.mainStatus,
    this.reason,
    this.dateReferred,
    this.rewardAmount,

    this.transactionType,
    this.date,
    this.dateFormatted,
    this.referenceId,
    this.balanceBefore,
    this.balanceAfter,
    this.paidVia,
    this.paymentGateway,
    this.paymentChannel,
    this.paymentReference,
    this.walletInfo,
    //this.bankAccountId,
    this.bankAccount,
    this.ticketCount,
    this.unitBought,
    this.gameId,
    this.gameName,
    this.ticketPrice,
    this.ticketTotalAmount,
    this.amountPurchased,
    this.customerId,
    this.customerFullName,
    this.customerFirstname,
    this.customerLastname,
    this.customerEmail,
    this.customerPhone,
    this.orderId,
    this.orderUniqueId,
    this.purchaseId,
    this.salesValue,
    this.commissionAmount,
    this.commissionPercentage,
    this.grossCommission,
    this.withholdingTax,
    this.withholdingTaxPercentage,
    this.commissionDisbursementId,
    this.commissionDisbursementReference,
    this.topupReference,
    this.topupMethod,
    this.topupStatus,
    this.topupGateway,
    this.fromAccount,
    this.sourceAccountUuid,
    this.withdrawalReference,
    this.withdrawalMethod,
    this.withdrawalStatus,
    this.withdrawalGateway,
    this.withdrawnInto,
    this.destinationAccountUuid,
    this.bonusAmount,
    this.bonusReference,
    this.bonusMethod,
    this.bonusStatus,
    this.bonusDisbursementId,
    this.agent,
    this.updatedAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    uuid: json["uuid"],
    agentId: json["agent_id"],
    bankAccountId: json["bank_account_id"],
    //type: json["type"],
    amount: json["amount"],
    description: json["description"],
    reference: json["reference"],
    status: json["status"],
    metadata: json["metadata"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),

    //referral
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    mainStatus: json["main_status"],
    reason: json["reason"],
    dateReferred: json["date_referred"] == null ? null : DateTime.parse(json["date_referred"]),
    rewardAmount: json["reward_amount"],


    transactionType: json["transaction_type"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    dateFormatted: json["date_formatted"] == null ? null : DateTime.parse(json["date_formatted"]),
    referenceId: json["reference_id"],
    balanceBefore: json["balance_before"]?.toDouble(),
    balanceAfter: json["balance_after"]?.toDouble(),
    paidVia: json["paid_via"],
    paymentGateway: json["payment_gateway"],
    paymentChannel: json["payment_channel"],
    paymentReference: json["payment_reference"],
    walletInfo: json["wallet_info"] == null ? null : BankAccount.fromJson(json["wallet_info"]),
    //bankAccountId: json["bank_account_id"],
    bankAccount: json["bank_account"] == null ? null : BankAccount.fromJson(json["bank_account"]),
    ticketCount: json["ticket_count"],
    unitBought: json["unit_bought"],
    gameId: json["game_id"],
    gameName: json["game_name"],
    ticketPrice: json["ticket_price"],
    ticketTotalAmount: json["ticket_total_amount"],
    amountPurchased: json["amount_purchased"],
    customerId: json["customer_id"],
    customerFullName: json["customer_full_name"],
    customerFirstname: json["customer_firstname"],
    customerLastname: json["customer_lastname"],
    customerEmail: json["customer_email"],
    customerPhone: json["customer_phone"],
    orderId: json["order_id"],
    orderUniqueId: json["order_unique_id"],
    purchaseId: json["purchase_id"],
    salesValue: json["sales_value"],
    commissionAmount: json["commission_amount"],
    commissionPercentage: json["commission_percentage"],
    grossCommission: json["gross_commission"],
    withholdingTax: json["withholding_tax"],
    withholdingTaxPercentage: json["withholding_tax_percentage"],
    commissionDisbursementId: json["commission_disbursement_id"],
    commissionDisbursementReference: json["commission_disbursement_reference"],
    topupReference: json["topup_reference"],
    topupMethod: json["topup_method"],
    topupStatus: json["topup_status"],
    topupGateway: json["topup_gateway"],
    fromAccount: json["from_account"],
    sourceAccountUuid: json["source_account_uuid"],
    withdrawalReference: json["withdrawal_reference"],
    withdrawalMethod: json["withdrawal_method"],
    withdrawalStatus: json["withdrawal_status"],
    withdrawalGateway: json["withdrawal_gateway"],
    withdrawnInto: json["withdrawn_into"],
    destinationAccountUuid: json["destination_account_uuid"],
    bonusAmount: json["bonus_amount"],
    bonusReference: json["bonus_reference"],
    bonusMethod: json["bonus_method"],
    bonusStatus: json["bonus_status"],
    bonusDisbursementId: json["bonus_disbursement_id"],
    agent: json["agent"] == null ? null : User.fromJson(json["agent"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "agent_id": agentId,
    "bank_account_id": bankAccountId,
    //"type": type,
    "amount": amount,
    "description": description,
    "reference": reference,
    "status": status,
    "metadata": metadata,
    "created_at": createdAt?.toIso8601String(),

    //referral
    "user": user?.toJson(),
    "main_status": mainStatus,
    "reason": reason,
    "date_referred": dateReferred?.toIso8601String(),
    "reward_amount": rewardAmount,

    "transaction_type": transactionType,
    "date": date?.toIso8601String(),
    "date_formatted": dateFormatted?.toIso8601String(),
    "reference_id": referenceId,
    "balance_before": balanceBefore,
    "balance_after": balanceAfter,
    "paid_via": paidVia,
    "payment_gateway": paymentGateway,
    "payment_channel": paymentChannel,
    "payment_reference": paymentReference,
    "wallet_info": walletInfo?.toJson(),
    "bank_account": bankAccount?.toJson(),
    "ticket_count": ticketCount,
    "unit_bought": unitBought,
    "game_id": gameId,
    "game_name": gameName,
    "ticket_price": ticketPrice,
    "ticket_total_amount": ticketTotalAmount,
    "amount_purchased": amountPurchased,
    "customer_id": customerId,
    "customer_full_name": customerFullName,
    "customer_firstname": customerFirstname,
    "customer_lastname": customerLastname,
    "customer_email": customerEmail,
    "customer_phone": customerPhone,
    "order_id": orderId,
    "order_unique_id": orderUniqueId,
    "purchase_id": purchaseId,
    "sales_value": salesValue,
    "commission_amount": commissionAmount,
    "commission_percentage": commissionPercentage,
    "gross_commission": grossCommission,
    "withholding_tax": withholdingTax,
    "withholding_tax_percentage": withholdingTaxPercentage,
    "commission_disbursement_id": commissionDisbursementId,
    "commission_disbursement_reference": commissionDisbursementReference,
    "topup_reference": topupReference,
    "topup_method": topupMethod,
    "topup_status": topupStatus,
    "topup_gateway": topupGateway,
    "from_account": fromAccount,
    "source_account_uuid": sourceAccountUuid,
    "withdrawal_reference": withdrawalReference,
    "withdrawal_method": withdrawalMethod,
    "withdrawal_status": withdrawalStatus,
    "withdrawal_gateway": withdrawalGateway,
    "withdrawn_into": withdrawnInto,
    "destination_account_uuid": destinationAccountUuid,
    "bonus_amount": bonusAmount,
    "bonus_reference": bonusReference,
    "bonus_method": bonusMethod,
    "bonus_status": bonusStatus,
    "bonus_disbursement_id": bonusDisbursementId,
    "agent": agent?.toJson(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
