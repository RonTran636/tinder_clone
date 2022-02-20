import 'package:dio/dio.dart';
import 'package:retry/retry.dart';
import 'package:tinder_clone/data/model/user/user.dart';

import 'api.dart';

class ApiHelper {
  static const int timeOut = 240;
  static const int maxRetries = 3;
  static const int retryDelayInSec = 2;
  static const appId = "620b5774ae275b5ab357109f";
  static ApiHelper? _instance;
  APIClient? _client;

  ApiHelper._internal();

  factory ApiHelper() {
    if (_instance == null) {
      _instance = ApiHelper._internal();
      final dio = Dio();
      _instance!._client = APIClient(dio);
    }
    return _instance!;
  }

  Future<T> apiRequest<T>(Future<T> fn, {String? methodLog}) async {
    final response = await retry(
        () => fn.then((value) {
              return value;
            }).timeout(const Duration(seconds: ApiHelper.timeOut)),
        maxAttempts: ApiHelper.maxRetries,
        delayFactor: const Duration(seconds: ApiHelper.retryDelayInSec),
        retryIf: (e) => e.canRetry(methodLog ?? fn.toString()));

    return response;
  }

  Future<List<User>> getListUser() async {
    final fn = _client!.getListUser(appId);
    final response = await apiRequest(fn);
    return response.data!;
  }

  Future<User> getCurrentUserDetail(String userId) async {
    final fn = _client!.getUserDetail(appId, userId);
    final response = await apiRequest(fn);
    return response;
  }
}

extension ExceptionRetry on Exception {
  bool canRetry(String method) {
    if (runtimeType != DioError) {
      return false;
    }

    print(
        "Retry Method: $method \nResponse: ${runtimeType} \nError: ${(this as DioError).toString()}");
    return (this as DioError).response == null;
  }
}
