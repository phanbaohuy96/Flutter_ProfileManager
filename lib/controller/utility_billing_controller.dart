import 'package:profile_manager/models/billing_card.dart';

import 'controller_utils.dart';

class UtililyBillingController {
  //ignore: type_annotate_public_apis
  static var instance = UtililyBillingController._internal();

  factory UtililyBillingController() {
    return instance;
  }

  UtililyBillingController._internal();

  String getCostTransactionVND(Transaction transaction) {
    final String result = ControllerUtils.instance.getCostVND(transaction.cost);
    return transaction.isSpend ? '- $result' : '+ $result';
  }
}
