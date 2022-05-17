
import 'package:flutter_app/model/contributions_direct_upload.dart';
import 'package:flutter_app/network/remote_repositories/contributions_repository.dart';
import 'package:get/get.dart';

class ContributionController extends GetxController{
  RxBool isUploading = false.obs;
  RxBool isUploadFailed = false.obs;
  RxBool isUploadSuccess = false.obs;
  RxInt sentData = 0.obs;
  RxDouble progress = 0.0.obs;
  UploadDirectContributions? uploadDirectContribution;


  Future<UploadDirectContributions?> uploadAndCreateContributions(Map<String, dynamic> uploadContributionsQuery) async {
    try {
        isUploading.value = true;
        uploadDirectContribution = await ContributionRepository.uploadContributions(uploadContributionsQuery, uploadFile: (sent, total){
          progress.value = (sent / total);
        });
        return uploadDirectContribution;
    }catch(e){
      isUploadFailed.value = true;
      isUploadSuccess.value = false;
    }
    return null;
  }

  createContribution(Map<String, dynamic> createContributionQuery) async {
    try {
      await ContributionRepository.createContribution(createContributionQuery);
      isUploading.value = false;
      isUploadSuccess.value = true;
    }catch(e){
      isUploadFailed.value = true;
      isUploadSuccess.value = false;
    }
  }
}
