import 'package:dio/dio.dart';

class ProfileData {
  Dio dio = Dio();

  Future<dynamic> profileData({required String token}) async {
    try {
      var response = await dio.post(
          'https://elwekala.onrender.com/user/profile',
          data: {"token": token});

      print("✅ Profile Data: ${response.data}");
      return response.data;
    } on DioException catch (error) {
      if (error.response != null) {
        print("❌ Error: ${error.response!.data}");
        return error.response!.data;
      } else {
        print("❌ Connection Error: ${error.message}");
        return {"error": "فشل الاتصال بالخادم"};
      }
    }
  }
}
