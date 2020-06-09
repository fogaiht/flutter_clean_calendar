import 'package:date_utils/date_utils.dart';
import 'package:flutter/material.dart';
import "package:intl/intl.dart";

class CalendarTile extends StatelessWidget {
  final VoidCallback onDateSelected;
  final DateTime date;
  final String dayOfWeek;
  final bool isDayOfWeek;
  final bool isSelected;
  final bool inMonth;
  final List events;
  final TextStyle dayOfWeekStyle;
  final TextStyle dateStyles;
  final Widget child;
  final Color selectedColor;
  final Color todayColor;
  final Color dayColor;
  final Color todayBackgroundColor;
  final Color outMonthDayColor;
  final Color eventColor;
  final Color eventDoneColor;

  CalendarTile({
    this.onDateSelected,
    this.date,
    this.child,
    this.dateStyles,
    this.dayOfWeek,
    this.dayOfWeekStyle,
    this.isDayOfWeek = false,
    this.isSelected = false,
    this.inMonth = true,
    this.events,
    this.selectedColor,
    this.todayColor,
    this.eventColor,
    this.eventDoneColor,
    this.todayBackgroundColor,
    this.outMonthDayColor,
    this.dayColor,
  });

  Widget renderDateOrDayOfWeek(BuildContext context) {
    if (isDayOfWeek) {
      return InkWell(
        child: Container(
          alignment: Alignment.center,
          child: Text(
            dayOfWeek,
            style: dayOfWeekStyle,
          ),
        ),
      );
    } else {
      int eventCount = 0;
      return InkWell(
        onTap: onDateSelected,
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Container(
            decoration: isSelected
                ? BoxDecoration(
                    shape: BoxShape.circle,
                    color: selectedColor != null
                        ? Utils.isSameDay(date, DateTime.now())
                            ? todayBackgroundColor == null
                                ? Colors.transparent
                                : todayBackgroundColor
                            : selectedColor
                        : Theme.of(context).primaryColor,
                  )
                : BoxDecoration(),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  DateFormat("d").format(date),
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    color: isSelected
                        ? Colors.white
                        : Utils.isSameDay(date, DateTime.now())
                            ? todayColor
                            : inMonth ? dayColor : outMonthDayColor,
                  ),
                ),
                events != null && events.length > 0
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: events.map((event) {
                          eventCount++;
                          if (eventCount > 3) return Container();
                          return Container(
                            margin: EdgeInsets.only(
                                left: 2.0, right: 2.0, top: 1.0),
                            width: 5.0,
                            height: 5.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    isSelected ? Colors.white : eventDoneColor),
                          );
                        }).toList())
                    : Container(),
              ],
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (child != null) {
      return InkWell(
        child: child,
        onTap: onDateSelected,
      );
    }
    return Container(
      child: renderDateOrDayOfWeek(context),
    );
  }
}
