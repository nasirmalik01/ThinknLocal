import 'package:flutter_app/common/methods.dart';
import 'package:flutter_app/constants/strings.dart';
import 'package:flutter_app/local/my_hive.dart';
import 'package:flutter_app/model/business_detail.dart';
import 'package:flutter_app/model/business_stats.dart';
import 'package:flutter_app/model/businesses.dart';
import 'package:flutter_app/network/remote_repositories/business_repository.dart';
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
        List<Businesses>? businessList =
            await BusinessRemoteRepository.fetchBusinesses({
          'latitude': 31.415198188563153,
          'longitude': 73.09159506885499,
        });

        expect(true, (businessList?.isNotEmpty ?? false));
      });
      test('Fetch Business Stats', () async {
        BusinessStats? businessStats =
            await BusinessRemoteRepository.fetchBusinessStats(1, {
          'latitude': 31.415198188563153,
          'longitude': 73.09159506885499,
        });
        expect(true, businessStats?.history?.isNotEmpty ?? false);
      });
      test('Fetch Business Details', () async {
        BusinessDetail? businessDetails =
            await BusinessRemoteRepository.fetchBusinessDetails(1, {
          'latitude': 31.415198188563153,
          'longitude': 73.09159506885499,
        });
        expect(true, businessDetails != null);
      });

      ///Failure cases
      test('follow Business', () async {
        bool isFollowDone = await BusinessRemoteRepository.followBusiness(1);
        expect(true, isFollowDone);
      },
          skip:
              'Follow Business : Failuer case is working but , Succes case is still in Queue');
      test('UnFollow Business', () async {
        bool isFollowDone = await BusinessRemoteRepository.unFollowBusiness(1);
        expect(true, isFollowDone);
      },
          skip: 'UnFollow Business : Failuer case is working but , Succes case is still in Queue');

      test('Food & Drink Business Category', () async {
        List<Businesses>? businessCategoryList =  await (BusinessRemoteRepository.fetchBusinesses({
          Strings.categoryId: 22,
          Strings.latitude: Strings.dummyLatitude,
          Strings.longitude: Strings.dummyLongitude,
        }));
        expect(true, businessCategoryList?.isNotEmpty);
      });

      test('Things to do Business Category', () async {
        List<Businesses>? businessCategoryList =  await (BusinessRemoteRepository.fetchBusinesses({
          Strings.categoryId: 29,
          Strings.latitude: Strings.dummyLatitude,
          Strings.longitude: Strings.dummyLongitude,
        }));
        expect(true, businessCategoryList?.isNotEmpty);
      });

      test('Retail Business Category', () async {
        List<Businesses>? businessCategoryList =  await (BusinessRemoteRepository.fetchBusinesses({
          Strings.categoryId: 3,
          Strings.latitude: Strings.dummyLatitude,
          Strings.longitude: Strings.dummyLongitude,
        }));
        expect(true, businessCategoryList?.isNotEmpty);
      });

      test('Services Business Category', () async {
        List<Businesses>? businessCategoryList =  await (BusinessRemoteRepository.fetchBusinesses({
          Strings.categoryId: 33,
          Strings.latitude: Strings.dummyLatitude,
          Strings.longitude: Strings.dummyLongitude,
        }));
        expect(true, businessCategoryList?.isNotEmpty);
      });
    },
  );
}
