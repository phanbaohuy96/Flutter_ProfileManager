import 'package:profile_manager/controller/controller_utils.dart';
import 'package:profile_manager/models/loan_and_borrow.dart';

class LoanAndBorrowController{

  List<LoanAndBorrow> _loanings;
  List<LoanAndBorrow> _borrowings;

  static LoanAndBorrowController instance = LoanAndBorrowController._internal();

  factory LoanAndBorrowController(){    
    return instance;
  }

  LoanAndBorrowController._internal();

  List<LoanAndBorrow> getLoanings()
  {
    if(_loanings == null)
    {
      _loanings = [];
      _borrowings = [];
      for(int i = 0; i < loanAndBorrows.length; i++)
        if(!loanAndBorrows[i].isBorrow)
          _loanings.add(loanAndBorrows[i]);
        else
          _borrowings.add(loanAndBorrows[i]);
    }
    return _loanings;       
  }

  List<LoanAndBorrow> getBorrowings()
  {
    if(_borrowings == null)
    {
      _loanings = [];
      _borrowings = [];
      for(int i = 0; i < loanAndBorrows.length; i++)
        if(loanAndBorrows[i].isBorrow)
          _borrowings.add(loanAndBorrows[i]);
        else
          _loanings.add(loanAndBorrows[i]);
    }
    return _borrowings;       
  }

  String getCostLABVND(LoanAndBorrow lab)
  {
    String result = ControllerUtils.instance.getCostVND(lab.cost);
    return lab.isBorrow? "+" + result : "-" + result;
  }
}