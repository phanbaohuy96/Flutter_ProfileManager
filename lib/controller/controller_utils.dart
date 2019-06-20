import 'package:profile_manager/controller/localization.dart';

class ControllerUtils{
  Localization localization = Localization();
  
  static ControllerUtils instance = ControllerUtils._internal();

  factory ControllerUtils(){    
    return instance;
  }

  ControllerUtils._internal();

  String getDateString(DateTime date)
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

  String getCostVND(String costStr)
  {
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
    return result;
  }

  //localization 
}