import 'package:thinknlocal_app/common/methods.dart';
import 'package:thinknlocal_app/constants/strings.dart';
import 'package:thinknlocal_app/model/business_detail.dart';
import 'package:thinknlocal_app/model/business_stats.dart';
import 'package:thinknlocal_app/model/businesses.dart';
import 'package:thinknlocal_app/network/remote_repositories/business_repository.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  /// this is required to inject the Remote dependencies
  setUpAll(() {
    dependencyInjectionSetUp();
  });

  group(
    'Businesses',
    () {
      ///Success Cases
      test('Fetch Business', () async {
        List<Businesses>? businessList = await BusinessRemoteRepository.fetchBusinesses({
          'latitude': 31.415198188563153,
          'longitude': 73.09159506885499,
        });

        expect(true, (businessList?.isNotEmpty ?? false));
        for(var business in businessList!){
          expect(business.latitude, greaterThanOrEqualTo(33));
          expect(business.latitude, lessThanOrEqualTo(35));
        }
      });
      test('Fetch Business Stats', () async {
        BusinessStats? businessStats =
            await BusinessRemoteRepository.fetchBusinessStats(1, {
          'latitude': 31.415198188563153,
          'longitude': 73.09159506885499,
        });
        expect(true, businessStats?.history?.isNotEmpty ?? false);
        expect(true, businessStats?.recentContributions?.isNotEmpty ?? false);
        expect(12, businessStats?.history?.length);
      });

      test('Fetch Business Details', () async {
        BusinessDetail? businessDetails = await BusinessRemoteRepository.fetchBusinessDetails(1, {
          'latitude': 31.415198188563153,
          'longitude': 73.09159506885499,
        });
        expect(true, businessDetails != null);
        expect(1, businessDetails!.id);
      });

      ///Failure cases
      test('follow Business', () async {
        bool isFollowDone = await BusinessRemoteRepository.followBusiness(1);
        expect(true, isFollowDone);
      },);

      test('UnFollow Business', () async {
        bool isFollowDone = await BusinessRemoteRepository.unFollowBusiness(1);
        expect(true, isFollowDone);
      },);

      test('Food & Drink Business Category', () async {
        List<Businesses>? businessCategoryList =  await (BusinessRemoteRepository.fetchBusinesses({
          Strings.categoryId: 22,
          Strings.latitude: Strings.dummyLatitude,
          Strings.longitude: Strings.dummyLongitude,
        }));
        expect(true, businessCategoryList?.isNotEmpty);
        for(var businessCategory in businessCategoryList!){
          expect(businessCategory.category!.id, 22);
          expect(businessCategory.category!.parentId, 21);
          expect(businessCategory.category!.parentName, 'Food & Drink');
        }
      });

      test('Things to do Business Category', () async {
        List<Businesses>? businessCategoryList =  await (BusinessRemoteRepository.fetchBusinesses({
          Strings.categoryId: 29,
          Strings.latitude: Strings.dummyLatitude,
          Strings.longitude: Strings.dummyLongitude,
        }));
        expect(true, businessCategoryList?.isNotEmpty);
        for(var businessCategory in businessCategoryList!){
          expect(businessCategory.category!.id, 29);
          expect(businessCategory.category!.parentId, 27);
          expect(businessCategory.category!.parentName, 'Things To Do');
        }
      });

      test('Retail Business Category', () async {
        List<Businesses>? businessCategoryList =  await (BusinessRemoteRepository.fetchBusinesses({
          Strings.categoryId: 3,
          Strings.latitude: Strings.dummyLatitude,
          Strings.longitude: Strings.dummyLongitude,
        }));
        expect(true, businessCategoryList?.isNotEmpty);
        for(var businessCategory in businessCategoryList!){
          expect(businessCategory.category!.id, 3);
          expect(businessCategory.category!.parentId, 1);
          expect(businessCategory.category!.parentName, 'Retail');
        }
      });

      test('Services Business Category', () async {
        List<Businesses>? businessCategoryList =  await (BusinessRemoteRepository.fetchBusinesses({
          Strings.categoryId: 33,
          Strings.latitude: Strings.dummyLatitude,
          Strings.longitude: Strings.dummyLongitude,
        }));
        expect(true, businessCategoryList?.isNotEmpty);
        for(var businessCategory in businessCategoryList!){
          expect(businessCategory.category!.id, 33);
          expect(businessCategory.category!.parentId, 32);
          expect(businessCategory.category!.parentName, 'Personal Services');
        }
      });
    },
  );
}
