import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:uplanit_supplier/core/viewmodels/service_model.dart';
import 'package:uplanit_supplier/ui/shared/custom_colors.dart';
import 'package:uplanit_supplier/ui/shared/default_app_bar.dart';

import 'package:uplanit_supplier/ui/widgets/custom_progress_widget.dart';
import 'package:uplanit_supplier/ui/widgets/custom_service_button.dart';
import './assign_supplier.dart';

class AddNewServiceImage extends StatelessWidget {
  static const String ROUTE = '/service/all/add_new_service_image';

  const AddNewServiceImage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ServiceModel>(
      builder: (context, model, child) => Scaffold(
        appBar: defaultAppBar(
          context: context,
          title: 'Service Image',
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () {},
                color: CustomColor.uplanitBlue,
                child: Text(
                  'Add Image',
                  style: GoogleFonts.workSans(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 24.0,
          ),
          child: Column(
            children: [
              RichText(
                text: TextSpan(
                  text:
                      'Show clients images of this service, you can add up to 10 images.',
                  style: GoogleFonts.workSans(
                    color: Color(0xFFBFC1CF),
                    fontSize: 14.0,
                  ),
                  children: [
                    TextSpan(
                      text: 'A minimum of 3 images is required.',
                      style: GoogleFonts.workSans(
                        color: Color(0xFFBFC1CF),
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: model.serviceImagesLoading
                    ? CustomProgressWidget()
                    : model.serviceImages.length == 0
                        ? Center(child: Text('No service image added yet'))
                        : GridView.builder(
                            itemCount: model.serviceImages.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                              crossAxisCount: 2,
                            ),
                            itemBuilder: (context, index) =>
                                _gridItem(context, index, model.serviceImages),
                          ),
              ),
              Center(
                child: SizedBox(
                  width: 150,
                  child: CustomServiceButton(
                    onTap: () {
                      model.uploadServiceImages();
                      Navigator.pushNamed(
                        context,
                        AssignSupplier.ROUTE,
                      );
                    },
                    title: 'Next',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _gridItem(context, index, List<MockServiceImage> images) {
    print('item: ${images[index]}: images: ${images.length}');
    String imageUrl = images[index].path;

    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CachedNetworkImage(
          placeholder: (context, url) => Container(
            width: MediaQuery.of(context).size.width,
            height: 156,
            decoration: BoxDecoration(
              color: Color(0xFFC4C4C4),
            ),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
          imageUrl: imageUrl,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: imageProvider,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
