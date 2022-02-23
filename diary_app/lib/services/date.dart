class Date{
  DateTime now = DateTime.now();

  String getCurrentDate(){
    String year  = now.year.toString();
    String month = now.month >= 10 ? now.month.toString() : '0' + now.month.toString();
    String day = now.day >= 10 ? now.day.toString() : '0' + now.day.toString();
    String hour = now.hour >= 10 ? now.hour.toString() : '0' + now.hour.toString();
    String minute = now.minute >= 10 ? now.minute.toString() : '0' + now.minute.toString();
    String amOrPm = 'AM';
    if(int.parse(hour) > 12){
      amOrPm = 'PM';
    }
    String time = year + '-' + month + '-' + day + ', '+hour+':' + minute + ' ' + amOrPm;
    return time;
  }

  String currentParsedTime(){
    return parseTime(getCurrentDate());
  }

  String parseTime(String time){
    List<String> timeParameters = time.split(','); // ['2022-02-22', '12:00']
    // print('date.dart ');
    // print(timeParameters);
    List<String> dateParameters = timeParameters[0].split('-'); // ['2022-02-22']

    String parsedMonth = '';
    switch(int.parse(dateParameters[1])){
      case 1: parsedMonth = 'JAN';
      break;
      case 2: parsedMonth = 'FEB';
      break;
      case 3: parsedMonth = 'MAR';
      break;
      case 4: parsedMonth = 'APR';
      break;
      case 5: parsedMonth = 'MAY';
      break;
      case 6: parsedMonth = 'JUN';
      break;
      case 7: parsedMonth = 'JUL';
      break;
      case 8: parsedMonth = 'AUG';
      break;
      case 9: parsedMonth = 'SEPT';
      break;
      case 10: parsedMonth = 'OCT';
      break;
      case 11: parsedMonth = 'NOV';
      break;
      case 12: parsedMonth = 'DEC';
      break;

    }
    String parsedDate = dateParameters[2] + ' ' + parsedMonth + ', ' + dateParameters[0] + '\n' + timeParameters[1];
    return parsedDate;

  }

}