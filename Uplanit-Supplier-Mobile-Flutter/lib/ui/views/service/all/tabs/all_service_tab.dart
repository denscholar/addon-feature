import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uplanit_supplier/core/viewmodels/service_model.dart';
import 'package:uplanit_supplier/ui/shared/custom_colors.dart';
import 'package:uplanit_supplier/ui/views/service/all/add_new_service.dart';

class AllServiceTab extends StatelessWidget {
  AllServiceTab({Key key}) : super(key: key);
  ServiceModel model;

  @override
  Widget build(BuildContext context) {
    model = Provider.of<ServiceModel>(context);

    return model.services.length == 0
      ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'No services listed yet',
                  style: GoogleFonts.workSans(
                    fontSize: 16.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Let people know the services they can book you for',
                  style: GoogleFonts.workSans(
                    fontSize: 12.0,
                    color: Color(0xFFBFC1CF),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10),
                RaisedButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, AddNewService.ROUTE),
                  color: CustomColor.uplanitBlue,
                  child: Text(
                    'Create new service',
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

              itemCount: model.services.length,
              itemBuilder: (context, index) =>
                  _buildItem(context, index, model),
              physics: BouncingScrollPhysics(),
            ),
          );
  }


  Widget _buildItem(BuildContext context, int index, ServiceModel model) {
    List<dynamic> services = model.services;
    MockService service = services[index];
    print('service: ${service.image}');
    return Card(
      elevation: 8.0,
      shadowColor: Colors.grey.withOpacity(.4),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 160,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('${service.image}'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.mode_edit,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${service.name}',
                    style: GoogleFonts.workSans(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: CustomColor.uplanitBlue,
                    ),
                  ),
                  Text(
                    '2 Team Members',
                    style: GoogleFonts.workSans(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF757575),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Service Status:',
                            style: GoogleFonts.workSans(
                              fontSize: 10,
                              color: Color(0xFF757575),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            'Available',
                            style: GoogleFonts.workSans(
                              fontSize: 10,
                              color: CustomColor.primaryColor,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '\$${service.price}',
                            style: GoogleFonts.workSans(
                              fontSize: 16.0,
                              color: CustomColor.uplanitBlue,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '0 payment plan',
                            style: GoogleFonts.workSans(
                              fontSize: 10,
                              color: Color(0xFF757575),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

  }
}
