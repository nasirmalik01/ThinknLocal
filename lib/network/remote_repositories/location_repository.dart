import 'package:thinknlocal_app/constants/strings.dart';
import 'package:thinknlocal_app/model/cities.dart';
import 'package:thinknlocal_app/network/remote_services.dart';
import 'package:get_it/get_it.dart';

class LocationRepository{
  static Future<List<Cities>?> fetchCities(Map<String, dynamic> query) async {
    List<Cities> citiesList = [];
    final response =
    await GetIt.I<RemoteServices>().getRequest(Strings.cities, query);
    if (response == null) {
      return null;
    }

    final List<dynamic> _cityList =
    response.map((item) => Cities.fromJson(item)).toList();
    for (var cityItem in _cityList) {
      citiesList.add(cityItem);
    }
    return citiesList;
  }
}