import 'dart:async';
import 'package:bloc/bloc.dart';

class ImageScaleCubit extends Cubit<double> {
  late Timer _timer;

  ImageScaleCubit() : super(1.0);

  void startContinuousAnimation() {
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (state == 1.0) {
        emit(1.5);
      } else {
        emit(1.0);
      }
    });
  }

  @override
  Future<void> close() {
    _timer.cancel();
    return super.close();
  }
}
