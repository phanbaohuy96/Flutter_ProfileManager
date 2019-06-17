class LoanAndBorrow{
  String transactionPerson;
  String cost;
  String description;
  bool isBorrow;
  bool isReturned;
  DateTime date;

  LoanAndBorrow(this.transactionPerson, this.cost, this.description, this.isBorrow, this.date, {this.isReturned = false});  

  hasDescription() => description != "";
}


final List<LoanAndBorrow> loanAndBorrows = [
  LoanAndBorrow("Hòa", "1000000", "Mai mốt xuống đừng phân biệt đối xử. Chắc t phải về quê nên khoảng 2 tuần nữa. Chắc t phải về quê nên khoảng 2 tuần nữa. Chắc t phải về quê nên khoảng 2 tuần nữa. Chắc t phải về quê nên khoảng 2 tuần nữa. Chắc t phải về quê nên khoảng 2 tuần nữa", false, DateTime(2019, 05, 30), isReturned: true),
  LoanAndBorrow("Hải", "1000000", "Quê t thôi, chứ t khác nha", false, DateTime(2019, 05, 29)),
  LoanAndBorrow("Vinh", "1500000", "Chắc t phải về quê nên khoảng 2 tuần nữa", false, DateTime(2019, 05, 27)),
  LoanAndBorrow("Nghia", "100000", "t hỏi m nào lên thôi mà kk", false, DateTime(2019, 05, 23)),
  LoanAndBorrow("Vinh", "1000000", "Cả chiều loay hoay phá tập tar đéo đc", false, DateTime(2019, 05, 12)),
  LoanAndBorrow("Nghĩa", "300000", "Xúc tích ngắn gọn dễ hiểu", true, DateTime(2019, 05, 12)),
  LoanAndBorrow("Hải", "100000", "cục súc vậy nó mới sợ", false, DateTime(2019, 04, 30)),
  LoanAndBorrow("Hoa", "234642", "Xúc tích ngắn gọn dễ hiểu", true, DateTime(2019, 04, 12)),
  LoanAndBorrow("Huỳnh", "2748574", "Xúc tích ngắn gọn dễ hiểu", true, DateTime(2019, 04, 11)),
  LoanAndBorrow("Khoa", "5787", "Xúc tích ngắn gọn dễ hiểu", true, DateTime(2019, 04, 01)),
  LoanAndBorrow("Tú", "4565467", "Xúc tích ngắn gọn dễ hiểu", true, DateTime(2019, 03, 30)),
  LoanAndBorrow("Nguyệt", "3123000", "Xúc tích ngắn gọn dễ hiểu", true, DateTime(2019, 02, 30)),
];