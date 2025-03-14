import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_api/features/profile/cubit/profile_state.dart';
import 'package:get_api/features/profile/data/profile_data.dart';

class ProfileCubit extends Cubit<ProfileState> {
  static ProfileCubit get(context) => BlocProvider.of(context);

  ProfileCubit() : super(ProfileInitial());

  fetchProfileData({required String token}) async {
    emit(ProfileLoading());

    var userProfileData = await ProfileData().profileData(token: token);

    if (userProfileData != null &&
        userProfileData is Map &&
        !userProfileData.containsKey("error")) {
      print("✅ Received Profile Data: $userProfileData");
      emit(ProfileGettingData(profileData: userProfileData));
    }
  }
}
