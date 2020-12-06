import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uplanit_supplier/core/viewmodels/service_model.dart';
import 'package:uplanit_supplier/ui/shared/custom_colors.dart';
import 'package:uplanit_supplier/ui/views/service/addon/add_new_addon.dart';
// import 'package:uplanit_supplier/ui/views/service/adon/add_new_addon.dart';

class AddonTab extends StatelessWidget {
  AddonTab({Key key}) : super(key: key);
  ServiceModel model;
  @override
  Widget build(BuildContext context) {
    model = Provider.of<ServiceModel>(context);
    return model.serviceList.length == 0
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'No service add-ons yet',
                  style: GoogleFonts.workSans(
                    fontSize: 16.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'The addon system lets you create a core service and several add-ons that can be added during booking',
                    style: GoogleFonts.workSans(
                      fontSize: 12.0,
                      color: Color(0xFFBFC1CF),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddNewAddon()),
                    );
                  },
                  // Navigator.pushNamed(context, AddNewAddon.ROUTE),
                  color: CustomColor.uplanitBlue,
                  child: Text(
                    'List new add-ons',
                    style: GoogleFonts.workSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          )
        : Container(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 12,
            ),
            child: ListView.builder(
              itemCount: model.serviceList.length,
              itemBuilder: (context, index) =>
                  _buildItem(context, index, model.serviceList),
              physics: BouncingScrollPhysics(),
            ),
          );
  }

  Widget _buildItem(BuildContext context, int index, List<dynamic> services) {
    return Card(child: Container());
  }
}
