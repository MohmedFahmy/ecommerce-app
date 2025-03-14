import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:get_api/features/home/cubit/stats.dart';





import '../home data/data/data.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(InitialState());
   Data data = Data();

  void getDataAPIs() async {
  try {
      var list = await data.getData();
    emit(TestLoadingState());
    emit(TestPassedState(list:list));
  } catch (e) {
    emit(TestFailedState());
  }
}
}
