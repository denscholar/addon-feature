import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uplanit_supplier/core/models/business_calendar/base_business_calendar.dart';
// import 'package:uplanit_calendar/uplanit_calendar.dart';
import 'package:uplanit_supplier/core/models/business_calendar/event.dart';
import 'package:uplanit_supplier/core/models/shared/availability.dart';
import 'package:uplanit_supplier/core/utils/helper_util.dart';
import 'package:uplanit_supplier/core/viewmodels/business_calendar.dart';
import 'package:uplanit_supplier/ui/shared/custom_colors.dart';
import 'package:uplanit_supplier/ui/shared/profile_app_bar.dart';
import 'package:uplanit_supplier/ui/views/business_calendar/test/calendar_view.dart';
import 'package:uplanit_supplier/ui/views/business_calendar/test/timeline_view.dart';
import 'package:uplanit_supplier/ui/widgets/custom_progress_widget.dart';
import 'package:uplanit_supplier/ui/widgets/custom_textarea.dart';

class BusinessCalendar extends StatelessWidget {
  BusinessCalendar({Key key}) : super(key: key);
  BusinessCalendarModel model;

  TextEditingController textController = TextEditingController(text: '');

  verifyWorkTimeAndSelectedDateTime(DateTime date) {
    print('verify work time');
    if (model.selectedDateTime != null) {
      print('workTime: ${model.workTime}');
      String dayOfTheWeek = DateFormat('EEEE').format(date).toLowerCase();
      print('day of the week: $dayOfTheWeek');
      switch (dayOfTheWeek) {
        case 'monday':
          return model.workTime.monday != null;
        case 'tuesday':
          return model.workTime.tuesday != null;
        case 'wednesday':
          return model.workTime.wednesday != null;
        case 'thursday':
          return model.workTime.thursday != null;
        case 'friday':
          return model.workTime.friday != null;
        case 'saturday':
          return model.workTime.saturday != null;
        case 'sunday':
          return model.workTime.sunday != null;
        default:
          return null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    model = Provider.of<BusinessCalendarModel>(context);
    textController.text = model.token;
    return Scaffold(
      appBar: profileAppBar(
        title: 'Business Calendar',
        context: context,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 8),
              Text(
                'Your calendar helps you set your availability and shows you events and bookings. You can make yourself available on a day and mark certain hours out as busy. Your business calendar also shows you your daily bookings.',
                style: GoogleFonts.workSans(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 10),
              UplanitCalendarView(
                primaryColor: CustomColor.primaryColor,
                onDateSelected: (date, events) {
                  model.setSelectedDateTime(date);
                  //TODO: VERIFY THE WORK TIMES
                  var result = verifyWorkTimeAndSelectedDateTime(date);
                  print('result: $result');
                  if (!result) {
                    model.setClosed(true);
                  } else {
                    model.setClosed(false);
                  }
                },
                availabilities:
                    model.availabilities, //the available days for provider
                onDateChanged: (date) {
                  model.setSelectedDateTime(date);
                },
                onSwitchChanged: (value) {
                  print('switch changed: $value');
                  if (value) {}
                },
                updateMemberAvailable: (DateTime dt) async {
                  print('update dt: ${DateFormat('yyyy-M-d').format(dt)}');
                },
                updateMemberUnavailable: (DateTime dt) async {
                  print('update dt; $dt');
                },
              ),
              SizedBox(height: 4),
              model.selectedDateTime != null
                  ? Center(
                      child: Text(
                        '${DateFormat.yMMMMd().format(model.selectedDateTime)}',
                        style: GoogleFonts.workSans(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : Container(),
              SizedBox(height: 8),
              // TextField(
              //   controller: textController,
              // ),
              Center(
                child: InkWell(
                  onTap: () async {
                    if (model.selectedDateTime == null && model.closed) return;

                    model.setMarkingAsAvailable(true);
                    if (!model.markedAsAvailable) {
                      Availability availability = await model
                          .markDayAsAvailable(model.selectedDateTime);
                      if (availability != null) {
                        model.setSelectable(true);
                        model.setMarkedAsAvailable(true);
                        model.addAvailability(availability);
                      }
                    } else {
                      print('unseting');
                      await model.unsetDayAsAvailable(model.selectedDateTime);
                      model.setSelectable(false);
                      model.setMarkedAsAvailable(false);
                      // model.removeAvailability();
                    }
                    model.setMarkingAsAvailable(false);
                  },
                  child: model.closed
                      ? Container()
                      : Container(
                          width: 200,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: !model.markedAsAvailable
                                ? Color(0xFF23D160)
                                : Color(0xFF363636),
                          ),
                          child:
                              model.markingAsAvailable || model.removingAsBusy
                                  ? Center(child: CustomProgressWidget())
                                  : Center(
                                      child: Text(
                                        !model.markedAsAvailable
                                            ? 'Mark as available'
                                            : 'Mark as unavailable',
                                        style: GoogleFonts.workSans(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                        ),
                ),
              ),
              SizedBox(height: 8),
              TimelineView(
                closed: model.closed,
                events: model.events,
                onMarkAsBusy: (start, end) async {
                  model.setMarkingAsBusy(true);

                  Event event = await model.markAsBusy(start, end);
                  if (event != null) {
                    DateTime start_dt = HelperUtil.parseEvent(
                      event.start.year,
                      event.start.month,
                      event.start.day,
                      event.start.hour,
                      event.start.minute,
                    );
                    Map<String, String> map = {
                      "id": event.id,
                      'start': start_dt.toString()
                    };
                    model.addEvent(map);
                  }
                  model.setMarkingAsBusy(false);
                  print('timelines: $start / $end ');
                },
                onRemoveBusyTime: (start, end, id) async {
                  print(
                      'onRemoveBusyTime => start: $start, end: $end, id: $id');
                  model.setRemovingAsBusy(true);
                  getEventIdFromStartEnd(start, end);
                  Event event = await model.removeBusyTime(id);
                  if (event != null) {
                    model.removeEvent(id);
                  }
                  model.setRemovingAsBusy(false);
                },
                markingAsBusy: model.markingAsBusy,
                selectable: model.selectable,
                selectedDateTime: model.selectedDateTime,
              )
            ],
          ),
        ),
      ),
    );
  }

  getEventIdFromStartEnd(DateTime start, DateTime end) {
    // model.baseEvent.forEach((event) {

    // });
  }
}
