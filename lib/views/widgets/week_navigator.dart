import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeekNavigator extends StatefulWidget {
  final int initialYear;
  final int initialWeek;
  final Function(int year, int week) onWeekChanged;

  const WeekNavigator({
    Key? key,
    required this.initialYear,
    required this.initialWeek,
    required this.onWeekChanged,
  }) : super(key: key);

  @override
  _WeekNavigatorState createState() => _WeekNavigatorState();
}

class _WeekNavigatorState extends State<WeekNavigator> {
  late int _currentYear;
  late int _currentWeek;
  bool _hasNextWeek = false;

  @override
  void initState() {
    super.initState();
    _currentYear = widget.initialYear;
    _currentWeek = widget.initialWeek;
    _hasNextWeek = _calculateHasNextWeek();
  }

  bool _calculateHasNextWeek() {
    DateTime now = DateTime.now();
    int currentYear = now.year;
    int currentWeek = _getWeekNumber(now);

    if (_currentYear > currentYear) {
      return true;
    } else if (_currentYear == currentYear) {
      if (_currentWeek >= currentWeek) {
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }
  }

  static int _getWeekNumber(DateTime date) {
    int dayOfYear = int.parse(DateFormat("D").format(date));
    return ((dayOfYear - date.weekday + 10) / 7).floor();
  }

  void _goToPreviousWeek() {
    setState(() {
      if (_currentWeek == 1) {
        _currentYear--;
        _currentWeek = _getNumberOfWeeksInYear(_currentYear);
      } else {
        _currentWeek--;
      }
      widget.onWeekChanged(_currentYear, _currentWeek);
      _hasNextWeek = true;
    });
  }

  void _goToNextWeek() {
    setState(() {
      if (_currentWeek == _getNumberOfWeeksInYear(_currentYear)) {
        _currentYear++;
        _currentWeek = 1;
      } else {
        _currentWeek++;
      }
      widget.onWeekChanged(_currentYear, _currentWeek);
      _hasNextWeek = _calculateHasNextWeek();
    });
  }

  int _getNumberOfWeeksInYear(int year) {
    DateTime lastDayOfYear = DateTime(year, 12, 31);
    int dayOfYear = int.parse(DateFormat("D").format(lastDayOfYear));
    int weekDay = lastDayOfYear.weekday;
    // Adjust weekday to treat Sunday as the first day of the week (Sunday = 7, Monday = 1, ..., Saturday = 6)
    weekDay = weekDay == 7 ? 0 : weekDay;
    return ((dayOfYear - weekDay + 6) / 7).floor();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(FluentIcons.arrow_left_24_regular, color: Colors.teal),
          onPressed: _goToPreviousWeek,
        ),
        Text('$_currentYear年 第$_currentWeek周'),
        if (_hasNextWeek)
          IconButton(
            icon: const Icon(FluentIcons.arrow_right_24_regular, color: Colors.teal,),
            onPressed: _goToNextWeek,
          )
        else
          const IconButton(
            icon: Icon(null),
            onPressed: null,
          ),
      ],
    );
  }
}
