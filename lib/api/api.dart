import 'package:dio/dio.dart';

class Api {
  final myDio = createMyDio();

  Api._internal();

  static final _singleton = Api._internal();

  factory Api() => _singleton;

  static Dio createMyDio() {
    var dio = Dio(BaseOptions(
      baseUrl: "https://fcm.googleapis.com",
      headers: {
        "Authorization":
            "key=AAAAHWTVweM:APA91bGrFxaLqI9JSh6IJf4f05NK-Qf5NMWHg0x-S2QsjBpzvLD_2DREPGjtaDE66WWs_fUbd-yKj-uCDNyIcYZLz5s9NuD-ER0brd22QAjSfqys0Q9Lh41E0tdyLEOjV8TiloSjUUoZ",
        "Accept": "application/json",
      },
      contentType: "application/json",
      receiveTimeout: const Duration(seconds: 30), // 15 seconds
      connectTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
    ));
    dio.interceptors.add(ApiInterceptors());

    return dio;
  }
}

class ApiInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('requesting');
    // do something befor e request is sent
    print(
        "${options.method} | ${options.baseUrl}  | ${options.headers} | ${options.path} | ${options.uri} | ${options.data}");
    super.onRequest(options, handler); //add this line
  }

  @override
  void onError(DioError dioError, ErrorInterceptorHandler handler) {
    handler.next(dioError);
    print('done');
    // do something to error
    super.onError(dioError, handler); //add this line
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(response.statusCode);
    print('response');
    // do something before response
    super.onResponse(response, handler); //add this line
  }
}
