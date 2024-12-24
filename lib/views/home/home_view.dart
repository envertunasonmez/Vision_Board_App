import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vision_board_app/cubit/image_scale_cubit.dart';
import 'package:vision_board_app/products/constants/asset_constants.dart';
import 'package:vision_board_app/products/constants/color_constants.dart';
import 'package:vision_board_app/products/constants/string_constans.dart';
import 'package:vision_board_app/views/vision_board/vision_board_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = ImageScaleCubit();
        cubit.startContinuousAnimation();
        return cubit;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: Container(
            decoration: BoxDecoration(
              color: ColorConstants.redColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Center(
                child: Text(
                  StringConstans.createVisionBoard,
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      color: ColorConstants.whiteColor),
                ),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: BlocBuilder<ImageScaleCubit, double>(
                  builder: (context, scale) {
                    return AnimatedScale(
                      scale: scale,
                      duration: Duration(seconds: 1),
                      curve: Curves.easeInOut,
                      child: Image.asset(
                        AssetConstants.christmasTree,
                        width: 300,
                        height: 400,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 100),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VisionBoardView(),
                      ));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstants.redColor,
                  minimumSize: Size(300, 50),
                  elevation: 10,
                  shadowColor: ColorConstants.blackColor,
                ),
                child: Text(
                  StringConstans.letsStart,
                  style:
                      TextStyle(color: ColorConstants.whiteColor, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
