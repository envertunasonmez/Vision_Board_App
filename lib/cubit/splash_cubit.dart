import 'package:bloc/bloc.dart';

abstract class SplashState {}

class SplashLoading extends SplashState {}

class SplashCompleted extends SplashState {}

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashLoading());

  void loadSplash() async {
    await Future.delayed(Duration(seconds: 5));
    emit(SplashCompleted());
  }
}
