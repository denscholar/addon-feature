import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tabbar/tabbar.dart';
import 'package:uplanit_supplier/core/viewmodels/service_model.dart';
import 'package:uplanit_supplier/ui/shared/custom_colors.dart';
import 'package:uplanit_supplier/ui/shared/profile_app_bar.dart';
import 'package:uplanit_supplier/ui/views/service/all/add_new_service.dart';
import 'package:uplanit_supplier/ui/views/service/all/tabs/all_service_tab.dart';
import 'package:uplanit_supplier/ui/widgets/custom_progress_widget.dart';

import './all/add_new_service.dart';
import 'all/tabs/addon_service_tab.dart';


class ServicePage extends StatelessWidget {
  ServicePage({Key key}) : super(key: key);
  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Consumer<ServiceModel>(
      builder: (context, model, child) => Scaffold(
        appBar: profileAppBar(
          context: context,
          title: 'Services',
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: model.loading
                    ? null
                    : () async {
                        // _handleUploadPortfolio(model);
                        // model.setLoading(false);

                        Navigator.pushNamed(
                          context,
                          AddNewService.ROUTE,
                        );
                      },
                color: !model.loading
                    ? Color(0XFFC20370)
                    : Color(0XFFC20370).withOpacity(.4),
                child: model.loading
                    ? CustomProgressWidget()
                    : Center(
                        child: Text(
                          'Add New',
                          style: GoogleFonts.workSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
              ),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(40.0),
            child: TabbarHeader(
              controller: _controller,
              backgroundColor: Color(0xFFBFC1CF),
              indicatorColor: Color(0xFF161F51),
              tabs: [
                Tab(
                  child: Text(
                    'All Services',
                    style: GoogleFonts.workSans(
                      fontSize: 12.0,
                      color: Color(0xFF161F51),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Add-ons',
                    style: GoogleFonts.workSans(
                      fontSize: 12.0,
                      color: Color(0xFF161F51),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: TabbarContent(
          controller: _controller,
          children: [
            AllServiceTab(),
            AddonTab(),
          ],
        ),
      ),
    );
  }
}
