import 'package:flutter_app/common/methods.dart';
import 'package:flutter_app/model/cause_detail.dart';
import 'package:flutter_app/model/causes.dart';
import 'package:flutter_app/model/causes_stats.dart';
import 'package:flutter_app/network/remote_repositories/cause_repository.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  /// this is required to inject the Remote dependencies
  setUpAll(() {
    dependencyInjectionSetUp();
  });

  group('Causes', () {
    ///success Cases
    test('Fetch Causes', () async {
      List<Causes>? causesList = await CausesRemoteRepository.fetchCauses({
        'latitude': 31.415198188563153,
        'longitude': 73.09159506885499,
      });
      expect(true, (causesList?.isNotEmpty ?? false));
    });

    test('Fetch Causes Stats', () async {
      CausesStats? causesStats = await CausesRemoteRepository.fetchCausesStats(1, {
        'latitude': 31.415198188563153,
        'longitude': 73.09159506885499,
      });
      expect(true, causesStats?.history?.isNotEmpty ?? false);
      expect(true, causesStats?.topContributors?.isNotEmpty ?? false);
      expect(12, causesStats?.history?.length);
    });

    test('Fetch Causes Details', () async {
      CauseDetail? causeDetail = await CausesRemoteRepository.fetchCauseDetails(1, {
        'latitude': 31.415198188563153,
        'longitude': 73.09159506885499,
      });
      expect(true, causeDetail != null);
      expect(1, causeDetail!.id);
    });

    ///Failure cases
    test('follow Causes', () async {
      bool isFollowDone = await CausesRemoteRepository.followCause(1);
      expect(false, isFollowDone);
    });

    test('UnFollow Causes', () async {
      bool isUnFollowDone = await CausesRemoteRepository.unFollowCause(1);
      expect(false, isUnFollowDone);
    });
  });
}
