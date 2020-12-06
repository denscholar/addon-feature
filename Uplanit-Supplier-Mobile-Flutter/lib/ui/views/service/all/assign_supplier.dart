import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:uplanit_supplier/core/viewmodels/service_model.dart';
import 'package:uplanit_supplier/ui/shared/custom_colors.dart';
import 'package:uplanit_supplier/ui/shared/default_app_bar.dart';
import 'package:uplanit_supplier/ui/views/service/all/dialogs/add_team_member_dialog.dart';
import 'package:uplanit_supplier/ui/widgets/custom_service_button.dart';
import './add_new_service_completed.dart';

class AssignSupplier extends StatelessWidget {
  static const String ROUTE = '/service/all/assign_supplier';
  const AssignSupplier({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 4;
    final double itemWidth = size.width;
    return Consumer<ServiceModel>(
      builder: (context, model, child) => Scaffold(
        appBar: defaultAppBar(
          context: context,
          title: 'Assign Supplier',
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 24.0,
          ),
          child: Column(
            children: [
              Text(
                'If you\'re a one man business, we encourage adding yourself as a team member and link yourself to services.',
                style: GoogleFonts.workSans(
                  color: Color(0xFFBFC1CF),
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Expanded(
                child: GridView.builder(
                  itemCount: model.suppliers.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    crossAxisCount: 2,
                    childAspectRatio: (itemWidth / itemHeight),
                  ),
                  
                  itemBuilder: (context, index) =>
                      _gridItem(context, index, model),
                ),
              ),
              SizedBox(height: 20),
              Divider(),
              InkWell(
                onTap: () => showDialog(
                  context: context,
                  builder: (context) => AddTeamMemberDialog(),
                  barrierDismissible: false,
                ),
                child: Row(children: [
                  Icon(Icons.add),
                  SizedBox(width: 10),
                  Text('Add new team member')
                ]),
              ),
              Expanded(
                child: Container(),
              ),
              Center(
                child: SizedBox(
                  width: 150,
                  child: CustomServiceButton(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AddNewServiceCompleted.ROUTE,
                      );
                    },
                    color: CustomColor.uplanitBlue,
                    title: 'Complete',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _gridItem(BuildContext context, int index, ServiceModel model) {
    List<MockSupplier> list = model.suppliers;
    String name = list[index].name;
    return InkWell(
      onTap: () {
        model.setSelectedTeamMember(index);
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('assets/images/supplier2.png'),
            ),
            Text(
              '$name',
              maxLines: 2,
              style: GoogleFonts.workSans(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
