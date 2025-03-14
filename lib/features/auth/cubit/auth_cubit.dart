import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_api/features/auth/cubit/auth_state.dart';
import 'package:get_api/features/auth/data/auth_data.dart';
import 'package:image_picker/image_picker.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);
  AuthData authData = AuthData();
  final ImagePicker picker = ImagePicker();
  File? image;
  String? myImage;
  saveImage({required BuildContext context}) async {
    var imagePiker = await picker.pickImage(source: ImageSource.camera);
    image = File(imagePiker!.path);
    Uint8List? bytes = image?.readAsBytesSync();
    myImage = base64Encode(bytes!);
    emit(ImageState());
  }

  registerCubit(
      {required context,
      required name,
      required email,
      required phone,
      required nationalId,
      required gender,
      required password}) async {
    emit(AuthLoading());
    var user = await authData.register(
        name: name,
        email: email,
        phone: phone,
        nationalId: nationalId,
        gender: gender,
        password: password,
        context: context);
    emit(AuthSuccess(userData: user));
  }

  loginCubit({
    required email,
    required password,
  }) async {
    emit(AuthLoading());
    var userAccount = await authData.logIn(email: email, password: password);
    emit(AuthSuccess(userData: userAccount));
  }
}
