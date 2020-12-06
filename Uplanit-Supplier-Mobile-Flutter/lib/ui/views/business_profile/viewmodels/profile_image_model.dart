import 'dart:io';

import 'package:uplanit_supplier/core/models/business_profile/cover_image.dart';
import 'package:uplanit_supplier/core/models/business_profile/post_cover_image.dart';
import 'package:uplanit_supplier/core/models/business_profile/post_logo.dart';
import 'package:uplanit_supplier/core/services/authentication_service.dart';
import 'package:uplanit_supplier/core/services/business_profile_service.dart';
import 'package:uplanit_supplier/core/services/utility_service.dart';
import 'package:uplanit_supplier/core/utils/api_endpoint_util.dart';
import 'package:uplanit_supplier/core/utils/locator.dart';
import 'package:uplanit_supplier/core/viewmodels/base_model.dart';

class ProfileImageModel extends BaseModel {
  AuthenticationService auth = locator<AuthenticationService>();
  BusinessProfileService _businessProfileService =
      locator<BusinessProfileService>();
  UtilityService _utilityService = locator<UtilityService>();

  CoverImage _logo;
  CoverImage _cover;
  bool _isLogoUploading = false;
  bool _isCoverUploading = false;

  bool get isLogoUploading => _isLogoUploading;
  bool get isCoverUploading => _isCoverUploading;

  CoverImage get logo => _logo;
  CoverImage get cover => _cover;

  setIsCoverUploading(bool isCoverUploading) {
    _isCoverUploading = isCoverUploading;
    notifyListeners();
  }

  setIsLogoUploading(bool isLogoUploading) {
    _isLogoUploading = isLogoUploading;
    notifyListeners();
  }

  setCoverImage(CoverImage cover) {
    _cover = cover;
    notifyListeners();
  }

  setLogoImage(CoverImage logo) async {
    _logo = logo;
    // await auth.user.updateProfile(photoURL: _logo.path1M);
    notifyListeners();
  }

  Future<String> getFileUploadURL({String filename, String type}) async {
    String dynamicURL =
        ApiEndpoint.GET_FILE_UPLOAD_URL + "?name=$filename&type=$type";
    String token = await auth.user.getIdToken();
    return await _utilityService.getFileUploadURL(
      token: token,
      dynamicURL: dynamicURL,
    );
  }

  Future<String> uploadFileToS3({
    String url,
    File file,
  }) async {
    return await _utilityService.uploadFileToS3(
      url: url,
      file: file,
    );
  }

  //update cover
  Future<CoverImage> updateCoverImage({String coverImage}) async {
    String token = await auth.user.getIdToken();
    return await _businessProfileService.updateCoverImage(
      postCoverImage: PostCoverImage(
        cover: coverImage,
      ),
      token: token,
    );
  }

  //update logo
  Future<CoverImage> updateLogoImage({String logoImage}) async {
    String token = await auth.user.getIdToken();
    return await _businessProfileService.updateLogo(
      postLogoImage: LogoImage(
        logo: logoImage,
      ),
      token: token,
    );
  }
}
