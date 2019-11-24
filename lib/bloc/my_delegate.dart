import 'package:bloc/bloc.dart';

class MyDelegate extends BlocDelegate {

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }

}
