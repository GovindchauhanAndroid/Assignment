import 'dart:developer';

import 'package:as_demo/app_constant/AppConstant.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../models/user_model.dart';

part 'user_api_service.g.dart';

@RestApi(baseUrl: AppConstants.baseUrl)
abstract class UserApiService {
  factory UserApiService({String? baseUrl}) {
    Dio dio = Dio();
    dio.options.headers["Content-Type"] = "application/json";
    dio.interceptors.add(LogInterceptor(
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        logPrint: (b) {
          log(b.toString());
        }));

    return _UserApiService(dio, baseUrl: baseUrl);
  }

  @GET("/users/list")
  Future<List<User>> getUsers();
}
