import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:vision_board_app/cubit/splash_cubit.dart';
import 'package:vision_board_app/products/constants/asset_constants.dart';
import 'package:vision_board_app/views/home/home_view.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashCubit()..loadSplash(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashCompleted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeView()),
            );
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Lottie.asset(
              AssetConstants.newYear,
              width: 500,
              height: 500,
            ),
          ),
        ),
      ),
    );
  }
}
