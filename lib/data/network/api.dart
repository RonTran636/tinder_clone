import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tinder_clone/data/model/base/base_response.dart';
import 'package:tinder_clone/data/model/user/user.dart';

part 'api.g.dart';

@RestApi(baseUrl: "https://dummyapi.io/data/v1/")
abstract class APIClient {
  factory APIClient(Dio dio, {String baseUrl}) = _APIClient;

  @GET("/user")
  Future<BaseResponse<List<User>>> getListUser(@Header("app-id") String appId);

  @GET("/user/{path}")
  Future<User> getUserDetail(
      @Header("app-id") String appId, @Path("path") String path);
}
