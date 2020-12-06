import 'package:flutter/material.dart';
import 'package:uplanit_supplier/core/enums/drawer_pages.dart';
import 'package:uplanit_supplier/core/viewmodels/base_model.dart';
import 'package:uplanit_supplier/ui/views/business_calendar/business_calendar.dart';
import 'package:uplanit_supplier/ui/views/business_info/business_info.dart';
import 'package:uplanit_supplier/ui/views/business_profile/business_profile.dart';
import 'package:uplanit_supplier/ui/views/payment_plan/payment_plan.dart';
import 'package:uplanit_supplier/ui/views/payment_provider/payment_provider.dart';
import 'package:uplanit_supplier/ui/views/portfolio/portfolio.dart';
import 'package:uplanit_supplier/ui/views/service/service.dart';
import 'package:uplanit_supplier/ui/views/settings/about/about.dart';
import 'package:uplanit_supplier/ui/views/team/team.dart';

class DrawerModel extends BaseModel {
  DrawerPages _selectedDrawerPage = DrawerPages.BUSINESS_PROFILE;
  String _pageTitle = '';
  List<Widget> _actions = [];

  String get pageTitle => _pageTitle;
  List<Widget> get actions => _actions;
  DrawerPages get selectedDrawerPages => _selectedDrawerPage;

  void setPageTitle(String pageTitle) {
    _pageTitle = pageTitle;
    notifyListeners();
  }

  void addActions(Widget action) {
    _actions.clear();
    _actions.add(action);

    notifyListeners();
  }

  void setDrawerPage(DrawerPages page) {
    _selectedDrawerPage = page;
    notifyListeners();
  }

  getScreens() {
    switch (selectedDrawerPages) {
      case DrawerPages.BUSINESS_PROFILE:
        return BusinessProfile();
      case DrawerPages.BUSINESS_PORTFOLIO:
        return PortfolioPage();
      case DrawerPages.SERVICE:
        return ServicePage();
      case DrawerPages.PAYMENT_PROVIDER:
        return PaymentProvider();
      case DrawerPages.PAYMENT_PLAN:
        return PaymentPlanPage();
      case DrawerPages.BUSINESS_INFO:
        return BusinessInfoPage();
      case DrawerPages.BUSINESS_CALENDAR:
        return BusinessCalendar();
      case DrawerPages.TEAM:
        return TeamPage();
      case DrawerPages.SETTINGS:
        return AboutPage();
      default:
        return null;
    }
  }
}
