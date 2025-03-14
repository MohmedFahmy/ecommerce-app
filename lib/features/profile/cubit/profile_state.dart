sealed class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileGettingData extends ProfileState {
  final profileData;
  ProfileGettingData({required this.profileData});
}
