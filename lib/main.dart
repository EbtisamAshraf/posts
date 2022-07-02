import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts/app.dart';
import 'package:posts/bloc_observer.dart';
import 'package:posts/inject_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();
  BlocOverrides.runZoned(
    () {
      runApp(const PostsApp());
    },
    blocObserver: MyBlocObserver(),
  );
}
