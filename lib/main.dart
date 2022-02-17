import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tinder_clone/bloc/card_provider/card_provider.dart';
import 'package:tinder_clone/bloc/home/home_bloc.dart';
import 'package:tinder_clone/views/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

final GlobalKey<ScaffoldMessengerState> snackBarKey =
    GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => HomeBloc()
            ..add(
              const HomeLoadInitialList(),
            ),
        ),
      ],
      child: ChangeNotifierProvider(
        create: (context) => CardProvider(),
        child: MaterialApp(
          title: 'Flutter Demo',
          scaffoldMessengerKey: snackBarKey,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
