
import 'package:dio/dio.dart';
import '../../constants/strings/http_constants.dart';
import '../../constants/strings/shared_preference_constants.dart';
import '../shared_preferences_service.dart';

class DioClientNetwork {
  late Dio dio;
  String? authToken;
  initializeDioClientNetwork() async {
    dio = Dio();
    dio.options = setBaseOptions();
    dio.interceptors.add(LogInterceptor(
        request: true, responseBody: true, requestBody: true, error: true));
    dio.interceptors.add(
      InterceptorsWrapper(
          onRequest: requestInterceptor,
          // onResponse: responseInterceptor,
          onError: errorInterceptor),
    );

    if (authToken == null) {
      var _token = await SharedPreferencesService()
          .getStringFromSF(SharedPreferenceConstants.apiAuthToken);
      if (_token != null) {
        authToken = _token;
        dio.options.headers["Authorization"] = "Bearer " + authToken!;
      } 
    }
    print(dio.options.headers);
  }

  BaseOptions setBaseOptions() {
    return BaseOptions(
      connectTimeout: 60000,
      baseUrl: HTTPConstants.baseUrl,
    );
  }

  void requestInterceptor(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (authToken == null) {
      var _token = await SharedPreferencesService()
          .getStringFromSF(SharedPreferenceConstants.apiAuthToken);
      if (_token != null) {
        authToken = _token;
        dio.options.headers["Authorization"] = "Bearer " + authToken!;
        handler.next(options);
      } else {
        handler.next(options);
      }
    } else {
      dio.options.headers["Authorization"] = "Bearer " + authToken!;
      handler.next(options);
    }
  }

  // void responseInterceptor(
  //     Response options, ResponseInterceptorHandler handler) async {
  //   if (options.headers.value("token") != null) {
  //     //if the header is present, then compare it with the Shared Prefs key
  //     var verifyToken = await SharedPreferencesService()
  //         .getStringFromSF(SharedPreferenceConstants.apiAuthToken);
  //     // if the value is the same as the header, continue with the request
  //     if (options.headers.value("token") == verifyToken) {
  //       return options;
  //     }
  //   }
  // }

  dynamic errorInterceptor(
      DioError dioError, ErrorInterceptorHandler handler) async {
    if (dioError.message.contains("ERROR_001")) {
      // this will push a new route and remove all the routes that were present
      // navigatorKey.currentState.pushNamedAndRemoveUntil(
      //     "/login", (Route<dynamic> route) => false);
    }
    handler.next(dioError);
  }
}

// dio.interceptors.responseLock.lock();
// dio.lock();
// getApiToken().then((value) {
//   options.headers["token"] = authToken = _token;
//   dio.interceptors.responseLock.unlock();
//   dio.interceptors.requestLock.unlock();
//   // dio.interceptors.responseLock.unlock();
//   // dio.unlock();
// });
