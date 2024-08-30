import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/futures/presentation/bloc/appcontroller/appcontroller_bloc.dart';

import 'futures/presentation/bloc/apiloader/apiloader_bloc.dart';
import 'futures/presentation/pags/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppControllerBloc>(
          create: (context) => AppControllerBloc(),
        ),
        BlocProvider<ApiLoaderBloc>(
          create: (context) => ApiLoaderBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData.dark(),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:const  HomePage(),
      ),
    );
  }
}
