import 'package:thinknlocal_app/constants/strings.dart';
import 'package:thinknlocal_app/model/businesses.dart';
import 'package:thinknlocal_app/network/remote_repositories/business_repository.dart';
import 'package:thinknlocal_app/network/remote_services.dart';
import 'package:get/get.dart';

class BusinessCategoryController extends GetxController{
  RxBool isLoading = false.obs;
  List<Businesses>? businessCategoryList = [];
  RxBool isError = false.obs;
  RxString errorMessage = ''.obs;

  getBusinessCategory(int categoryId) async{
   isLoading.value = true;
   businessCategoryList =  await (BusinessRemoteRepository.fetchBusinesses({
     Strings.categoryId: categoryId
   }));
   if(RemoteServices.statusCode != 200 && RemoteServices.statusCode != 201 && RemoteServices.statusCode != 204){
     isError.value = true;
     isLoading.value = false;
     errorMessage.value = RemoteServices.error;
     return;
   }
   isLoading.value = false;
 }
}