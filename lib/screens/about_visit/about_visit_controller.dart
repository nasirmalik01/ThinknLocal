import 'package:get/get.dart';

class AboutVisitController extends GetxController{
  RxBool isVisitFirstTime = true.obs;
  RxString selectedBusiness = ''.obs;
  RxString selectedCourse = ''.obs;

  changeFirstTimeVisit(){
    isVisitFirstTime.value = !isVisitFirstTime.value;
  }
}