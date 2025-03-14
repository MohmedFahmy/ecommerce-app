import 'package:dio/dio.dart';
import 'package:get_api/features/auth/cubit/auth_cubit.dart';

class AuthData {
  Dio dio = Dio();
  register({
    required context,
    required name,
    required email,
    required phone,
    required nationalId,
    required gender,
    required password,
  }) async {
    try {
      var repo =
          await dio.post('https://elwekala.onrender.com/user/register', data: {
        "name": name,
        "email": email,
        "phone": phone,
        "nationalId": nationalId,
        "gender": gender,
        "password": password,
        "profileImage": AuthCubit.get(context).myImage
      });
      print(repo);
      return repo;
    } on DioException catch (error) {
      if (error.response != null) {
        print(error.response!.data);
        return error.response!.data;
      }
    }
  }

  logIn({
    required email,
    required password,
  }) async {
    try {
      var repo =
          await dio.post('https://elwekala.onrender.com/user/login', data: {
        "email": email,
        // "phone": phone,
        // "nationalId": nationalId,
        // "gender": gender,
        "password": password,
        // "profileImage": AuthCubit.get(context).myImage
      });
      print(repo);
      return repo;
    } on DioException catch (error) {
      if (error.response != null) {
        print(error.response!.data);
        return error.response!.data;
      }
    }
  }
}
