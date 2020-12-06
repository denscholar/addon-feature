import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:uplanit_supplier/ui/widgets/custom_progress_widget.dart';

class Timeline {
  String id;
  int start;
  int end;
  bool isSelected;

  Timeline({this.start, this.end, this.isSelected, this.id});

  @override
  String toString() {
    return '{start: $start, end: $end, isSelected: $isSelected}';
  }
}

final List<Timeline> timelineList = [
  Timeline(start: 0, end: 1, isSelected: false, id: ''),
  Timeline(start: 1, end: 2, isSelected: false, id: ''),
  Timeline(start: 2, end: 3, isSelected: false, id: ''),
  Timeline(start: 3, end: 4, isSelected: false, id: ''),
  Timeline(start: 4, end: 5, isSelected: false, id: ''),
  Timeline(start: 5, end: 6, isSelected: false, id: ''),
  Timeline(start: 6, end: 7, isSelected: false, id: ''),
  Timeline(start: 7, end: 8, isSelected: false, id: ''),
  Timeline(start: 8, end: 9, isSelected: false, id: ''),
  Timeline(start: 9, end: 10, isSelected: false, id: ''),
  Timeline(start: 10, end: 11, isSelected: false, id: ''),
  Timeline(start: 11, end: 12, isSelected: true, id: ''),
  Timeline(start: 12, end: 13, isSelected: false, id: ''),
  Timeline(start: 13, end: 14, isSelected: false, id: ''),
  Timeline(start: 14, end: 15, isSelected: false, id: ''),
  Timeline(start: 15, end: 16, isSelected: false, id: ''),
  Timeline(start: 16, end: 17, isSelected: false, id: ''),
  Timeline(start: 17, end: 18, isSelected: false, id: ''),
  Timeline(start: 18, end: 19, isSelected: false, id: ''),
  Timeline(start: 19, end: 20, isSelected: false, id: ''),
  Timeline(start: 20, end: 21, isSelected: false, id: ''),
  Timeline(start: 21, end: 22, isSelected: false, id: ''),
  Timeline(start: 22, end: 23, isSelected: false, id: ''),
  Timeline(start: 23, end: 24, isSelected: false, id: ''),
];

class TimelineView extends StatefulWidget {
  final Function(DateTime start, DateTime end) onMarkAsBusy;
  final Function(DateTime start, DateTime end, String id) onRemoveBusyTime;
  final List<Map<String, String>> events;
  final bool closed;
  final bool selectable;
  final bool markingAsBusy;
  final DateTime selectedDateTime;
  TimelineView({
    Key key,
    this.onMarkAsBusy,
    this.onRemoveBusyTime,
    this.events,
    this.closed = false,
    this.selectable = false,
    this.markingAsBusy = false,
    this.selectedDateTime,
  }) : super(key: key);

  @override
  _TimelineViewState createState() => _TimelineViewState();
}

class _TimelineViewState extends State<TimelineView> {
  bool selected = false;

  DateTime convertToActualDateTime(int hour) {
    DateTime dt;
    if (widget.selectedDateTime == null) {
      dt = DateTime.now();
    } else {
      dt = widget.selectedDateTime;
    }

    DateTime dt2 = dt.add(new Duration(hours: hour));
    return dt2;
  }

  @override
  void initState() {
    super.initState();
  }

  void _markEvents() {
    int eventSize = widget.events.length;
    for (int i = 0; i < timelineList.length; i++) {
      for (int j = 0; j < eventSize; j++) {
        DateTime dt =
            DateFormat('yyyy-M-d h:mm').parse(widget.events[j]['start']);
        if (timelineList[i].start == dt.hour) {
          timelineList[i].isSelected = true;
          timelineList[i].id = widget.events[j]['id'];
        }
      }
    }
  }

  _buildClosedState() {
    return Card(
      elevation: 8,
      shadowColor: Colors.grey.withOpacity(.4),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Text('Closed'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _markEvents();
    return widget.closed
        ? _buildClosedState()
        : Container(
            height: 400,
            decoration: BoxDecoration(
              border: Border.all(
                color: widget.selectable
                    ? Colors.grey
                    : Colors.grey.withOpacity(.2),
                width: 1,
              ),
              color: !widget.selectable
                  ? Colors.grey.withOpacity(.5)
                  : Colors.transparent,
            ),
            child: Container(
              padding: const EdgeInsets.all(8),
              child: ListView(
                children: timelineList.map(
                  (timeline) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Column(
                            children: [
                              Text(
                                '${DateFormat('ha').format(convertToActualDateTime(timeline.start)).toLowerCase()}',
                                style: TextStyle(fontSize: 12),
                              ),
                              SizedBox(height: 4),
                              InkWell(
                                onTap: !widget.selectable
                                    ? null
                                    : () => widget.onMarkAsBusy(
                                          convertToActualDateTime(
                                              timeline.start),
                                          convertToActualDateTime(timeline.end),
                                        ),
                                child: Container(
                                  width: 40,
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: widget.selectable
                                        ? Colors.grey.withOpacity(.4)
                                        : Colors.grey.withOpacity(.2),
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.black54,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: widget.markingAsBusy
                                      ? Center(child: CustomProgressWidget())
                                      : Icon(
                                          Icons.business_center_outlined,
                                          size: 16,
                                          color: Colors.black54,
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 280,
                                height: 60,
                                padding: const EdgeInsets.all(4),
                                margin: const EdgeInsets.only(bottom: 4),
                                decoration: BoxDecoration(
                                  color: timeline.isSelected
                                      ? Color(0xFF7F84A0)
                                      : Colors.transparent,
                                  border: timeline.isSelected
                                      ? Border(
                                          left: BorderSide(
                                            width: 8,
                                            color: Color(0xFF161F51),
                                          ),
                                        )
                                      : Border.all(
                                          width: 0,
                                          color: Colors.transparent,
                                        ),
                                ),
                                child: timeline.isSelected
                                    ? Stack(
                                        children: [
                                          Positioned(
                                            top: 8,
                                            left: 8,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'busy',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  '${DateFormat('ha').format(convertToActualDateTime(timeline.start)).toLowerCase()} - ${DateFormat('ha').format(convertToActualDateTime(timeline.end)).toLowerCase()}',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            top: 8,
                                            right: 8,
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  print('timeline to remove: $timeline');
                                                  timeline.isSelected = false;
                                                });
                                                widget.onRemoveBusyTime(
                                                    convertToActualDateTime(
                                                        timeline.start),
                                                    convertToActualDateTime(
                                                        timeline.end),
                                                    timeline.id);
                                              },
                                              child: Container(
                                                child: Icon(
                                                  Icons.cancel,
                                                  size: 24,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Container(),
                              ),
                              timeline.isSelected ? Container() : DottedLine(),
                              SizedBox(height: 10),
                              Divider(
                                color: Colors.black,
                                thickness: 1,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ).toList(),
              ),
            ),
          );
  }
}
