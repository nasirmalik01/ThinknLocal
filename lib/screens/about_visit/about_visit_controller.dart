import 'package:get/get.dart';

class AboutVisitController extends GetxController{
  RxBool isVisitFirstTime = true.obs;

  changeFirstTimeVisit(){
    isVisitFirstTime.value = !isVisitFirstTime.value;
  }
}