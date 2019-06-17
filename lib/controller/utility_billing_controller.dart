import 'package:profile_manager/models/billing_card.dart';

import 'controller_utils.dart';

class UtililyBillingController{
  static UtililyBillingController instance = UtililyBillingController._internal();

  factory UtililyBillingController(){    
    return instance;
  }

  UtililyBillingController._internal();

  String getCostTransactionVND(Transaction transaction)
  {
    String result = ControllerUtils.instance.getCostVND(transaction.cost);
    return transaction.isSpend? "-" + result : "+" + result;
  }
}