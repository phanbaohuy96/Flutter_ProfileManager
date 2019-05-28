import 'package:flutter/material.dart';

class BillingCard{
  final List<Transaction> transactions;
  final String cardImage;
  final String bankName;
  final String branchBank;
  final String cardNumber;
  final String createDate;
  final String owner;
  final String userName;
  final String password;

  BillingCard(this.transactions, this.cardImage, this.bankName, this.branchBank, this.cardNumber, this.createDate, this.owner, this.userName, this.password);

}

class MasterCard extends BillingCard{
  final String cvc;

  MasterCard(List<Transaction> transactions, String cardImage, String bankName, String branchBank, String cardNumber, String createDate, String owner, String userName, String password, this.cvc) : super(transactions, cardImage, bankName, branchBank, cardNumber, createDate, owner, userName, password);

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
  final IconData iconActionPlace;

  Transaction(this.date, this.action, this.actionPlace, this.iconActionPlace);

  
}

