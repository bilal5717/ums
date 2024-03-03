import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late Map<DateTime, List> _events;
  late List _selectedEvents;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  void initState() {
    super.initState();
    _selectedEvents = [];

    _events = {
      // Your events map...
    };
  }

  List _getEventsForDay(DateTime day) {
    // Implementation example
    return _events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back, size: 30),
        ),
        backgroundColor: Color(0xff002c51),
        centerTitle: true,
        title: Text(
          'ACADEMIC CALENDAR',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(height: 30),
            TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay; // update `_focusedDay` here as well
                  _selectedEvents = _getEventsForDay(selectedDay);
                });
              },
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
              eventLoader: _getEventsForDay,
              // Add more properties according to your requirements
            ),
            const SizedBox(height: 10.0),
            Expanded(child: _buildEventList()),
          ],
        ),
      ),
    );
  }

  Widget _buildEventList() {
    return ListView.builder(
      itemCount: _selectedEvents.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(width: 0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: ListTile(
            title: Text(_selectedEvents[index].toString()),
            onTap: () => print('${_selectedEvents[index]} tapped!'),
          ),
        );
      },
    );
  }
}
