import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:posts/core/utils/app_colors.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   SpinKitCircle(
  color: AppColors.primaryColor,
  size: 50.0,
);

    //  const Center(child: Text('Please Wait..'));
  }
}
