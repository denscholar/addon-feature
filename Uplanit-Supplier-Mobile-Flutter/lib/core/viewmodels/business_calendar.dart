import 'package:uplanit_supplier/core/models/business_calendar/base_business_calendar.dart';
import 'package:uplanit_supplier/core/models/business_calendar/event.dart';
import 'package:uplanit_supplier/core/models/shared/availability.dart';
import 'package:uplanit_supplier/core/services/business_calendar_service.dart';
import 'package:uplanit_supplier/core/utils/helper_util.dart';
import 'package:uplanit_supplier/core/utils/locator.dart';
import 'package:uplanit_supplier/core/viewmodels/base_model.dart';

class BusinessCalendarModel extends BaseModel {
  BusinessCalendarService businessCalendarService =
      locator<BusinessCalendarService>();
  DateTime _selectedDateTime = DateTime.now();
  bool _closed = false;
  bool _markingAsBusy = false;
  bool _selectable = false;
  bool _markedAsAvailable = false;
  bool _markingAsAvailable = false;
  bool _removingAsBusy = false;
  List<Map<String, String>> _events = [];
  BaseBusinessCalendar _baseBusinessCalendar;
  Map<int, dynamic> _availabilities = {};
  WorkTime _workTime;

  DateTime get selectedDateTime => _selectedDateTime;
  bool get closed => _closed;
  bool get markedAsAvailable => _markedAsAvailable;
  bool get markingAsBusy => _markingAsBusy;
  bool get selectable => _selectable;
  bool get markingAsAvailable => _markingAsAvailable;
  bool get removingAsBusy => _removingAsBusy;
  List<Map<String, String>> get events => _events;
  Map<int, dynamic> get availabilities => _availabilities;
  WorkTime get workTime => _workTime;
  BaseBusinessCalendar get baseBusinessCalendar => _baseBusinessCalendar;

  String _token = '';
  String get token => _token;
  void setToken(String token) {
    _token = token;
    notifyListeners();
  }

  BusinessCalendarModel() {
    init();
  }

  void init() async {
    BaseBusinessCalendar response = await getCalendar();
    if (response != null) {
      _baseBusinessCalendar = response;
      _availabilities = HelperUtil.parseAvailabilityToMap(baseBusinessCalendar.availability);
      _workTime = response.workTime;
      _events = convertEventsToMap(response.events);
    }
    notifyListeners();
  }

  addAvailability(Availability availability) {
    _availabilities.addAll(HelperUtil.parseMap(availability));
    notifyListeners();
  }

  removeAvailability(Map dt) {
    _availabilities.remove(dt);
    notifyListeners();
  }

  List<Map<String, String>> convertEventsToMap(List<Event> events) {
    List<Map<String, String>> list = [];
    if (events != null && events.length > 0) {
      events.forEach((event) {
        DateTime dt = DateTime(
          event.start.year,
          event.start.month,
          event.start.day,
          event.start.hour,
          event.start.minute,
          event.start.second,
        );
        Map<String, String> eventMap = {'id': event.id, 'start': dt.toString()};
        list.add(eventMap);
      });
    }
    return list;
  }

  void setSelectedDateTime(DateTime date) {
    _selectedDateTime = date;
    notifyListeners();
  }

  void setMarkedAsAvailable(bool value) {
    _markedAsAvailable = value;
    notifyListeners();
  }

  void setMarkingAsAvailable(bool value) {
    _markingAsAvailable = value;
    notifyListeners();
  }

  void setRemovingAsBusy(bool value) {
    _removingAsBusy = value;
    notifyListeners();
  }

  void setClosed(bool value) {
    _closed = value;
    notifyListeners();
  }

  void setEvents(List<Map<String, String>> events) {
    _events = events;
    notifyListeners();
  }

  void addEvent(Map<String, String> start) {
    _events.add(start);
    notifyListeners();
  }

  void removeEvent(String id) {
    print('removing event @ $id');
    _events.removeWhere((element) => element['id'] == id);
    print('events $_events');
    notifyListeners();
  }

  void setMarkingAsBusy(bool value) {
    _markingAsBusy = value;
    notifyListeners();
  }

  void setSelectable(bool value) {
    _selectable = value;
    notifyListeners();
  }

  Future<BaseBusinessCalendar> getCalendar() async {
    String token = await auth.user.getIdToken();

    return await businessCalendarService.getCalendar(token: token);
  }

  Future<Availability> markDayAsAvailable(DateTime dt) async {
    String token = await auth.user.getIdToken();
    return await businessCalendarService.markDayAsAvailable(
      dt: dt,
      token: token,
    );
  }

  Future<bool> unsetDayAsAvailable(DateTime dt) async {
    String token = await auth.user.getIdToken();
    return await businessCalendarService.unsetDayAsAvailable(
      dt: dt,
      token: token,
    );
  }

  Future<Event> markAsBusy(DateTime start, DateTime end) async {
    String token = await auth.user.getIdToken();
    setToken('$token');
    print('token: $token');
    return await businessCalendarService.markAsBusy(
      start: start,
      end: end,
      token: token,
    );
  }

  Future<Event> removeBusyTime(String id) async {
    String token = await auth.user.getIdToken();
    return await businessCalendarService.removeBusyTime(
      id: id,
      token: token,
    );
  }
}
