


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:teachme/featuers/teach_me/presentation/pages/success_booked.dart';
import 'package:teachme/featuers/teach_me/presentation/widgets/custom_button.dart';

class BookingPage extends StatefulWidget{
  BookingPage({Key? key}): super(key: key);

  @override
  State<BookingPage> createState()=> _BookingPageState();

}

class _BookingPageState extends State<BookingPage>{
  CalendarFormat _format = CalendarFormat.month;
  DateTime _focusDay = DateTime.now();
  DateTime _currentDay = DateTime.now();
  int? _currentIndex;
  bool _isWeekend = false;
  bool _dateSelected = false;
  bool _timeSelected = false;

  @override
  Widget build(BuildContext context) {
    // Config.init(context);
   return Scaffold(
     appBar: AppBar(
       title: Text('Appointment'),

     ),
     body: CustomScrollView(
       slivers: <Widget>[
         SliverToBoxAdapter(
           child: Column(
             children: <Widget>[
               _tableCalender(),
               const Padding(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
               child: Center(
                 child: Text('Select Time',
                   style: TextStyle(
                     fontWeight: FontWeight.bold,
                     fontSize: 20
                   ),
                  ),
               ),
               )
             ],
           ),
         ),
         _isWeekend
             ? SliverToBoxAdapter(
           child: Container(
             padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 30),
             alignment: Alignment.center,
             child: const Text(
               'Weekend is not available, please select another date',
               style: TextStyle(
                 fontSize: 18,
                 fontWeight: FontWeight.bold,
                 color: Colors.grey,
               ),
             ),
           ),
         ) :SliverGrid(
             delegate: SliverChildBuilderDelegate((context,index){
               return InkWell(
                 splashColor: Colors.transparent,
                 onTap: (){
                   setState(() {
                     _currentIndex = index;
                     _timeSelected = true;
                   });
                 },
                 child: Container(
                   margin: const EdgeInsets.all(5),
                   decoration: BoxDecoration(
                     border: Border.all(
                       color: _currentIndex == index
                           ? Colors.white
                           :Colors.black,
                     ),
                     borderRadius: BorderRadius.circular(15),
                     color: _currentIndex == index
                       ? Colors.blue
                         : null,
                   ),
                   alignment: Alignment.center,
                   child: Text('${index + 8}:00 ${index + 9 > 12 ? "PM": "AM"}',
                   style: TextStyle(
                     fontWeight: FontWeight.bold,
                     color: _currentIndex == index ? Colors.white : null,
                   ),),
                 ),
               );
             },
               childCount: 12
             ),
             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, childAspectRatio: 1.5),
         ),
         SliverToBoxAdapter(
           child: Container(
             padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
             child:  Button(
               width: double.infinity,
               title: 'Make Appointment',
                 onPressed: (){
                 print(_dateSelected);
                 print(_dateSelected);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AppointmentBooked()));
               },
            disable: _timeSelected && _timeSelected ?  false : true,
             ),
           ),
         )
       ],
     ),
   );
  }

  Widget _tableCalender(){
    return TableCalendar(
        focusedDay: _focusDay,
        firstDay: DateTime.now(),
        lastDay: DateTime(2023, 12, 31),
        calendarFormat: _format,
        currentDay: _currentDay,
        rowHeight: 48,
      calendarStyle: const CalendarStyle(
        todayDecoration:
          BoxDecoration(color: Colors.blue, shape: BoxShape.circle)
      ),
      availableCalendarFormats: const{
          CalendarFormat.month: 'Month',
      },
      onFormatChanged: (format){
          setState(() {
            _format = format;
          });
      },
      onDaySelected: ((selectedDay,focusedDay){
        setState(() {
          _currentDay = selectedDay;
          _focusDay = focusedDay;
          _dateSelected = true;
          //check if weekend is selected
          if(selectedDay.weekday == 6 || selectedDay.weekday == 7){
            _isWeekend = true;
            _timeSelected = false;
            _currentIndex = null;
          }else {
            _isWeekend = false;
          }
        });
      }),
    );
  }

}

