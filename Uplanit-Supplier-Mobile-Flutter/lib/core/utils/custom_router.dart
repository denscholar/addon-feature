import 'package:flutter/material.dart';

import 'package:uplanit_supplier/core/models/shared/availability.dart';

import 'package:uplanit_supplier/ui/views/auth/login/login.dart';
import 'package:uplanit_supplier/ui/views/business_profile/business_profile.dart';
import 'package:uplanit_supplier/ui/views/home_view.dart';
import 'package:uplanit_supplier/ui/views/onboard/account_setup_one.dart';
import 'package:uplanit_supplier/ui/views/auth/signup/sign_up.dart';
import 'package:uplanit_supplier/ui/views/auth/signup/sign_up_pager_finish.dart';
import 'package:uplanit_supplier/ui/views/auth/signup/sign_up_pager_one.dart';
import 'package:uplanit_supplier/ui/views/auth/signup/sign_up_pager_two.dart';
import 'package:uplanit_supplier/ui/views/launcher/launcher.dart';
import 'package:uplanit_supplier/ui/views/onboard/account_setup_two.dart';
import 'package:uplanit_supplier/ui/views/onboard/all_done.dart';
import 'package:uplanit_supplier/ui/views/business_info/business_info.dart';
import 'package:uplanit_supplier/ui/views/payment_plan/add_new_payment_plan.dart';
import 'package:uplanit_supplier/ui/views/portfolio/portfolio.dart';
import 'package:uplanit_supplier/ui/views/service/all/add_new_service.dart';
import 'package:uplanit_supplier/ui/views/service/all/add_new_cost_and_delivery.dart';
import 'package:uplanit_supplier/ui/views/service/all/add_new_service_delivery.dart';
import 'package:uplanit_supplier/ui/views/service/all/add_new_service_image.dart';
import 'package:uplanit_supplier/ui/views/service/all/assign_supplier.dart';
import 'package:uplanit_supplier/ui/views/service/all/add_new_service_completed.dart';
import 'package:uplanit_supplier/ui/views/settings/about/about.dart';
import 'package:uplanit_supplier/ui/views/team/edit_team_member.dart';
import 'package:uplanit_supplier/ui/views/team/team.dart';
import 'package:uplanit_supplier/ui/views/team/team_detail.dart';

import '../../main.dart';

class CustomRouter {
  static Route<Widget> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AuthenticationWrapper.ROUTE:
        return MaterialPageRoute(builder: (_) => AuthenticationWrapper());
      case Launcher.ROUTE:
        return MaterialPageRoute(builder: (_) => Launcher());
      case Login.ROUTE:
        return MaterialPageRoute(builder: (_) => Login());
      case SignUp.ROUTE:
        return MaterialPageRoute(builder: (_) => SignUp());
      case SignUpPagerOne.ROUTE:
        return MaterialPageRoute(builder: (_) => SignUpPagerOne());
      case SignUpPagerTwo.ROUTE:
        return MaterialPageRoute(builder: (_) => SignUpPagerTwo());
      case SignUpPagerFinish.ROUTE:
        return MaterialPageRoute(builder: (_) => SignUpPagerFinish());
      case AccountSetupOne.ROUTE:
        return MaterialPageRoute(builder: (_) => AccountSetupOne());
      case AccountSetupTwo.ROUTE:
        return MaterialPageRoute(builder: (_) => AccountSetupTwo());
      case AllDone.ROUTE:
        return MaterialPageRoute(builder: (_) => AllDone());
      case HomeView.ROUTE:
        return MaterialPageRoute(builder: (_) => HomeView());
//Business profile
      case BusinessProfile.ROUTE:
        return MaterialPageRoute(builder: (_) => BusinessProfile());
      case PortfolioPage.ROUTE:
        return MaterialPageRoute(builder: (_) => PortfolioPage());
      case BusinessInfoPage.ROUTE:
        return MaterialPageRoute(builder: (_) => BusinessInfoPage());

      case TeamDetailPage.ROUTE:
        return MaterialPageRoute(builder: (_) => TeamDetailPage());
      case EditTeamDetailPage.ROUTE:
        EditTeamDetail arg = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => EditTeamDetailPage(
            id: arg.providerId,
            availabilities: arg.availability,
          ),
        );
      case AboutPage.ROUTE:
        return MaterialPageRoute(builder: (_) => AboutPage());
      //add new payment plan
      case AddNewPaymentPlan.ROUTE:
        return MaterialPageRoute(builder: (_) => AddNewPaymentPlan());
      //services
      case AddNewService.ROUTE:
        return MaterialPageRoute(builder: (_) => AddNewService());
      case AddNewCostAndDelivery.ROUTE:
        return MaterialPageRoute(builder: (_) => AddNewCostAndDelivery());
      case AddNewServiceDelivery.ROUTE:
        return MaterialPageRoute(builder: (_) => AddNewServiceDelivery());
      case AddNewServiceImage.ROUTE:
        return MaterialPageRoute(builder: (_) => AddNewServiceImage());
      case AssignSupplier.ROUTE:
        return MaterialPageRoute(builder: (_) => AssignSupplier());
      case AddNewServiceCompleted.ROUTE:
        return MaterialPageRoute(builder: (_) => AddNewServiceCompleted());
      default:
        return null;
    }
  }
}
