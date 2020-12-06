import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:intl/intl.dart';

class UplanitCalendarView extends StatefulWidget {
  final Color primaryColor;
  final Function(DateTime date, List<Event> events) onDateSelected;
  final Function(DateTime) onDateChanged;
  final Function(bool) onSwitchChanged;
  final bool loadingAvailable;
  final Function(DateTime) updateMemberAvailable;
  final Function(DateTime) updateMemberUnavailable;
  final bool showMemberAvailableBox;
  final Map<int, dynamic> availabilities;
  // final List<DateTime> availabilities;

  const UplanitCalendarView({
    Key key,
    this.primaryColor,
    this.onDateSelected,
    this.onDateChanged,
    this.onSwitchChanged,
    this.loadingAvailable = false,
    this.updateMemberAvailable,
    this.updateMemberUnavailable,
    this.showMemberAvailableBox = false,
    this.availabilities,
  }) : super(key: key);

  @override
  _UplanitCalendarViewState createState() => _UplanitCalendarViewState();
}

class _UplanitCalendarViewState extends State<UplanitCalendarView> {
  DateTime _currentDate = DateTime.now();
  bool _switchState = false;
  double positionY = 0;
  double positionX = 0;
  GlobalKey _key = GlobalKey();

  void _markStateAsAvailable(DateTime date) {
    setState(() {
      _switchState = false;
    });

    if (widget.availabilities.containsKey(date.year)) {
      Map<int, Map<int, dynamic>> yearMap = widget.availabilities[date.year];
      if (yearMap.containsKey(date.month)) {
        Map<int, dynamic> monthMap = yearMap[date.month];
        print('month: ${monthMap.keys}');
        for (int day in monthMap.keys) {
          if (day == date.day) {
            setState(() {
              _switchState = true;
            });
          }
        }
      }
    }

  }

  onTapDetail(BuildContext context, TapDownDetails details) {
    print('${details.globalPosition}');
    final RenderBox box = context.findRenderObject();
    final Offset localOffset = box.globalToLocal(details.globalPosition);
    setState(() {
      positionX = localOffset.dx;
      positionY = localOffset.dy;
      print('x: $positionX, y: $positionY');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: [
        Container(
          key: _key,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTapDown: (TapDownDetails details) =>
                    onTapDetail(context, details),
                child: CalendarCarousel(
                  onCalendarChanged: (DateTime date) {
                    this.setState(() {
                      _currentDate = date;
                      widget.onDateChanged(date);
                    });
                  },
                  onDayPressed: (DateTime date, List<Event> events) {
                    _markStateAsAvailable(date);
                    this.setState(() {
                      _currentDate = date;

                      widget.onDateSelected(date, events);
                    });
                  },
                  weekendTextStyle: TextStyle(
                    color: Colors.black,
                  ),

                  showWeekDays: true,
                  headerTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                  leftButtonIcon: Icon(
                    Icons.arrow_back_ios,
                    size: 30,
                  ),
                  rightButtonIcon: Icon(
                    Icons.arrow_forward_ios,
                    size: 30,
                  ),
                  headerTitleTouchable: true,
                  weekdayTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                  selectedDayButtonColor: Colors.transparent,
                  selectedDayBorderColor: Colors.transparent,
                  todayButtonColor: Colors.transparent,
                  todayBorderColor: Colors.transparent,

                  /// for pass null when you do not want to render weekDays
                  //  headerText: Container(
                  //    child: Text('Custom Header'),
                  //  ),
                  customDayBuilder: (
                    /// you can provide your own build function to make custom day containers
                    bool isSelectable,
                    int index,
                    bool isSelectedDay,
                    bool isToday,
                    bool isPrevMonthDay,
                    TextStyle textStyle,
                    bool isNextMonthDay,
                    bool isThisMonthDay,
                    DateTime day,
                  ) {
                    // print('isSelectable: $isSelectable');
                    // print('index: $index');
                    // print('isSelectedDay: $isSelectedDay');
                    // print('isToday: $isToday');
                    // print('isPrevMonthDay: $isPrevMonthDay');
                    // print('textStyle: $textStyle');
                    // print('isNextMonthDay: $isNextMonthDay');
                    // print('isThisMonthDay: $isThisMonthDay');
                    // print('datetime: $day');

                    /// If you return null, [CalendarCarousel] will build container for current [day] with default function.
                    /// This way you can build custom containers for specific days only, leaving rest as default.
                    if (isToday) {
                      return Container(
                        decoration: BoxDecoration(
                          color: widget.primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '${day.day}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      );
                    }
               
                    if (widget.availabilities != null &&
                        widget.availabilities.isNotEmpty) {
                      if (widget.availabilities.containsKey(day.year)) {
                        Map<int, Map<int, dynamic>> yearMap =
                            widget.availabilities[day.year];
                        if (yearMap.containsKey(day.month)) {
                          Map<int, dynamic> monthMap = yearMap[day.month];
                          for (int dtDay in monthMap.keys) {
                            if (dtDay == day.day) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: widget.primaryColor.withOpacity(.4),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    '${day.day}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              );
                            }
                          }
                        }
                      }
                    }
                    
                    if (isSelectedDay) {
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: widget.primaryColor,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '${day.day}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return null;
                    }
                  },
                  weekFormat: false,
                  // markedDatesMap: _markedDateMap,
                  height: 360.0,
                  selectedDateTime: _currentDate,
                  daysHaveCircularBorder: false,
                  daysTextStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  markedDateShowIcon: true,
                  showIconBehindDayText: true,
                  markedDateIconBorderColor: Colors.black,

                  /// null for not rendering any border, true for circular border, false for rectangular border
                ),
              ),
            ],
          ),
        ),
        widget.showMemberAvailableBox ? _showPopup(_currentDate) : Container(),
      ],
    );
  }

  _showPopup(DateTime date,
      {double top, double left, double right, double bottom}) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 400),
      // top: 300,
      // left: 70,
      top: positionY,
      left: positionX,
      child: Container(
        width: 200,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.2),
              blurRadius: 25.0, // soften the shadow
              spreadRadius: 5.0, //extend the shadow
              offset: Offset(
                15.0, // Move to right 10  horizontally
                15.0, // Move to bottom 10 Vertically
              ),
            ),
          ],
        ),
        child: Column(
          children: [
            Text('${DateFormat.yMMMMd().format(date)}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Switch.adaptive(
                  value: _switchState,
                  onChanged: (value) {
                    setState(() {
                      _switchState = value;
                      widget.onSwitchChanged(value);
                      if (value) {
                        if (widget.updateMemberAvailable == null)
                          throw (new UnsupportedError(
                              'updateMemberAvailable() not implemented'));
                        else
                          widget.updateMemberAvailable(date);
                      } else {
                        if (widget.updateMemberUnavailable == null)
                          throw (new UnsupportedError(
                              'updateMemberUnavailable() not implemented'));
                        else
                          widget.updateMemberUnavailable(date);
                      }
                    });
                  },
                ),
                Text('${_switchState ? 'available' : 'unavailable'}'),
                SizedBox(width: 8),
                widget.loadingAvailable
                    ? SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                    : Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
