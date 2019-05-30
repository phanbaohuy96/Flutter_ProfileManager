import 'package:flutter/material.dart';

class BillingCard{
  final List<Transaction> transactions;
  final String cardImage;
  final String bankName;
  final String branchBank;
  final String accountNumber;
  final String cardNumber;
  final String createDate;
  final String owner;
  final String userName;
  final String password;

  BillingCard(this.transactions, this.cardImage, this.bankName, this.branchBank, this.accountNumber, this.cardNumber, this.createDate, this.owner, this.userName, this.password); 

}

class MasterCard extends BillingCard{
  final String cvc;

  MasterCard(List<Transaction> transactions, String cardImage, String bankName, String branchBank, String accountNumber, String cardNumber, String createDate, String owner, String userName, String password, this.cvc) : super(transactions, cardImage, bankName, branchBank, accountNumber, cardNumber, createDate, owner, userName, password);

  static suggestionAction()
  {
    return [Action("Coffee", 0), Action("Shopping", 0), Action("Party", 0)];
  }

  static suggestionActionPlace()
  {
    return [ActionPlace("The Coffee House", 0), ActionPlace("Teren", 0) , ActionPlace("Tiki", 0)];
  }


}

class Action{
  final String name;  
  final int point;

  Action(this.name, this.point,);
}

class ActionPlace{
  final String name;
  final int point;
  final IconData icon;

  ActionPlace(this.name, this.point, {this.icon : Icons.ac_unit});
}

class Transaction{
  final DateTime date;
  final Action action;
  final ActionPlace actionPlace;
  final String cost;
  final bool isSpend;
  final bool isImpact;

  Transaction(this.date, this.action, this.actionPlace, this.cost, {this.isSpend = true, this.isImpact = true});  

  getDateStringCurrentWeek()
  {
    var currentDate = DateTime.now();
    if(currentDate.day == date.day && currentDate.month == date.month && currentDate.year == date.year) return "Today";
    if(currentDate.difference(date).inDays <= currentDate.weekday - 1){
      switch(date.weekday)
      {
        case DateTime.monday: return "Monday";
        case DateTime.tuesday: return "Tuesday";
        case DateTime.wednesday: return "Wednesday";
        case DateTime.thursday: return "Thursday";
        case DateTime.friday: return "Friday";
        case DateTime.saturday: return "Saturday";
        case DateTime.sunday: return "Sunday";
      }
    }

    return "${date.day}/${date.month}/${date.year}";
  }

  getCostVND()
  {
    String costStr = cost;
    String result = " đ";
    int count = 0;
    for(int i = costStr.length - 1; i >= 0; i--)
    {
      if(count == 3)
      {
        result = costStr[i] + "," + result;
        count = 1;
      }
      else{
        result = costStr[i] + result;
        count ++;
      }
    }
    return isSpend? "-" + result : "+" + result;
  }
}

//mastercard parten
final List<Transaction> _masterCardTrans = [
  Transaction(DateTime(2019, 05, 30), Action("Ipad Pro 2019", 0), ActionPlace("Apple", 0), "22950000"),
  Transaction(DateTime(2019, 05, 29), Action("Macbook Pro 15", 0), ActionPlace("Apple", 0), "58605298"),
  Transaction(DateTime(2019, 05, 29), Action("Coffee", 0), ActionPlace("The Coffee House", 0), "50000"),
  Transaction(DateTime(2019, 05, 24), Action("Nhận tiền trả nợ", 0), ActionPlace("Hòa", 0), "500000", isSpend: false),
  Transaction(DateTime(2019, 05, 23), Action("Nhận tiền trả nợ", 0), ActionPlace("Nghĩa Ngất", 0), "300000", isSpend: false),
  Transaction(DateTime(2019, 05, 18), Action("Coffee", 0), ActionPlace("Tenren", 0), "58000"),
  Transaction(DateTime(2019, 05, 11), Action("Party", 0), ActionPlace("Lẩu gà lá giang", 0), "150000")
];

final MasterCard _pvMasterCard = MasterCard(
  _masterCardTrans, 
  "assets/images/credit_card.png", 
  "PVCombank", 
  "Chi nhánh Sài gòn",
  "", 
  "5387428880150000", 
  "11/18", 
  "Phan Bảo Huy", 
  "phanbaohuy", 
  "123456", 
  "123"
);

//debit parten

final List<Transaction> _debitCardTrans = [
  Transaction(DateTime(2019, 05, 27), Action("Rút tiền", 0), ActionPlace("ATM VCB", 0), "500000"),
  Transaction(DateTime(2019, 05, 26), Action("Rút tiền", 0), ActionPlace("ATM VCB", 0), "200000"),
  Transaction(DateTime(2019, 05, 21), Action("Nhận tiền trả nợ", 0), ActionPlace("Hòa", 0), "500000", isSpend: false),
  Transaction(DateTime(2019, 05, 13), Action("Nhận tiền trả nợ", 0), ActionPlace("Nghĩa Ngất", 0), "300000", isSpend: false),
  Transaction(DateTime(2019, 05, 10), Action("Chuyển khoản", 0), ActionPlace("Shinhan bank", 0), "2100000"),
  Transaction(DateTime(2019, 05, 7), Action("Chuyển khoản", 0), ActionPlace("PVCombank", 0), "1150000")
];

final BillingCard _vcbDebitCard = BillingCard(
  _debitCardTrans, 
  "assets/images/credit_card.png", 
  "VCB", 
  "Chi nhánh Tân Phú", 
  "",
  "5387428880150000", 
  "11/18", 
  "Phan Bảo Huy", 
  "phanbaohuy", 
  "123456"
);

final List<BillingCard> billingCards = [_pvMasterCard, _vcbDebitCard, _pvMasterCard, _vcbDebitCard];