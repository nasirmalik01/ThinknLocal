import 'dart:developer';
import 'dart:io';

import 'package:thinknlocal_app/common/methods.dart';
import 'package:thinknlocal_app/config/aws_response.dart';
import 'package:thinknlocal_app/config/aws_service.dart';
import 'package:thinknlocal_app/constants/api_endpoints.dart';
import 'package:thinknlocal_app/model/contributions_direct_upload.dart';
import 'package:thinknlocal_app/network/remote_services.dart';
import 'package:get/get.dart';

class ContributionController extends GetxController {
  RxBool isUploading = false.obs;
  RxBool isUploadFailed = false.obs;
  RxBool isUploadSuccess = false.obs;
  RxInt sentData = 0.obs;
  RxDouble progress = 0.0.obs;
  UploadDirectContributions? uploadDirectContribution;
  RxDouble fileUploadingProgress = 0.0.obs;

  Future<UploadDirectContributions?> uploadAndCreateContributions(Map<String, dynamic> uploadContributionsQuery, File file) async {
    try {
       UploadFileResponse? uResponse;
      await AWSService().uploadFile(
        file,
        onProgressChange: (progress) {
          log(progress.toString());
          isUploading.value = true;
          fileUploadingProgress.value = progress;
        },
        onUploadComplete: (UploadFileResponse r) {
          log(r.data.toString());
          uResponse = r;
          isUploadSuccess.value = true;
        },
        onUploadError: (UploadFileResponse er) {
          log(er.toString());
          uResponse = er;
          isUploadFailed.value = true;
          isUploadSuccess.value = false;
          return;
        },
      );
      if(uResponse?.uploadId == null){
        isUploadFailed.value = true;
        isUploadSuccess.value = false;
        return null;
      }
      uploadContributionsQuery['upload_id'] =uResponse?.uploadId;

      await createContribution(uploadContributionsQuery);
      isUploading.value = false;
      return uploadDirectContribution;
    } catch(e){
      isUploadFailed.value = true;
      isUploadSuccess.value = false;
      return null;
    }
  }

  static Future<dynamic> createContribution(Map<String, dynamic> query) async {
    final response = await getItLocator<RemoteServices>()
        .postRequest(ApiEndPoints.contributions, query);

    if (response == null) {
      return;
    }

    return response;
  }
}
