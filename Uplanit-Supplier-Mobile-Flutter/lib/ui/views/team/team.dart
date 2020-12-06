import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uplanit_supplier/core/models/team/get_team_member_response.dart';
import 'package:uplanit_supplier/core/utils/helper_util.dart';
import 'package:uplanit_supplier/core/viewmodels/team_model.dart';
import 'package:uplanit_supplier/ui/shared/custom_colors.dart';
import 'package:uplanit_supplier/ui/shared/profile_app_bar.dart';
import 'package:uplanit_supplier/ui/views/payment_plan/add_new_payment_plan.dart';
import 'package:uplanit_supplier/ui/views/team/edit_team_member.dart';
import 'package:uplanit_supplier/ui/views/team/team_detail.dart';
import 'package:uplanit_supplier/ui/widgets/custom_progress_widget.dart';

class TeamPage extends StatelessWidget {
  static const String ROUTE = '/team/team';
  TeamPage({Key key}) : super(key: key);
  TeamModel model;

  @override
  Widget build(BuildContext context) {
    model = Provider.of<TeamModel>(context);
    return Scaffold(
      appBar: profileAppBar(context: context, title: 'Team', actions: [
        Padding(
          padding: EdgeInsets.all(8),
          child: RaisedButton(
            onPressed: () => Navigator.pushNamed(
              context,
              AddNewPaymentPlan.ROUTE,
            ),
            color: CustomColor.primaryColor,
            child: Text(
              'Add New',
              style: GoogleFonts.workSans(
                color: Colors.white,
              ),
            ),
          ),
        )
      ]),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 24),
            Text(
              'Create and manage team members here',
              style: GoogleFonts.workSans(
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 24),
            model.teamMembers == null
                ? Center(
                    child: CustomProgressWidget(
                      color: CustomColor.primaryColor,
                    ),
                  )
                : model.teamMembers.length == 0
                    ? _buildEmptyTeamMember(context)
                    : Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 4,
                          ),
                          itemBuilder: (context, index) =>
                              _buildItem(context, index, model.teamMembers),
                          itemCount: model.teamMembers.length,
                        ),
                      ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(context, index, List<GetTeamMemberResponse> teamMembers) {
    GetTeamMemberResponse teamMember = teamMembers[index];
    return InkWell(
      onTap: () {
        print('teamMember: ${teamMember.provider.id}');
        Navigator.pushNamed(
          context,
          EditTeamDetailPage.ROUTE,
          arguments: EditTeamDetail(
            providerId: teamMember.provider.id,
            availability: teamMember.availability,
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(.2),
        ),
        child: Column(
          children: [
            SizedBox(
              width: 150,
              child: CircleAvatar(
                radius: 60,
                backgroundImage: teamMember.image != null
                    ? NetworkImage(teamMember.image.path1M)
                    : AssetImage('assets/images/team_img.png'),
              ),
            ),
            SizedBox(height: 4),
            Text(
              '${teamMember.provider.name}',
              style: GoogleFonts.workSans(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                'No service(s)',
                style: GoogleFonts.workSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              Text(
                'more',
                style: GoogleFonts.workSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: CustomColor.primaryColor,
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyTeamMember(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        TeamDetailPage.ROUTE,
      ),
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: Radius.circular(12),
        padding: EdgeInsets.all(6),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          child: Container(
            alignment: Alignment.center,
            height: 156,
            child: Stack(
              children: [
                Center(
                  child: Text(
                    'Add first team member',
                    style: GoogleFonts.workSans(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
