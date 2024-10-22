import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unb_sql/show_terminal_cubit.dart';
import 'package:unb_sql/theme_cubit.dart';
import 'package:unb_sql/widgets/header.dart';
import 'package:unb_sql/widgets/left_bar.dart';
import 'package:unb_sql/widgets/middle_content.dart';
import 'package:unb_sql/widgets/right_bar.dart';

List<Color> cores = [
  const Color(0xFF201c1c),
];

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ShowTerminalCubit()),
        BlocProvider(create: (context) => ThemeCubit()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeData>(
      builder: (context, theme) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        home: LayoutBuilder(builder: (context, constraints) {
          print("width = ${constraints.maxWidth}");
          if (constraints.maxWidth < 800) {
            return const Scaffold(
              body: Center(
                child: Text(
                  "Tamanho da tela nao é suportado, tente novamente com uma tela maior.",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          } else {
            return const Scaffold(
              body: Column(
                children: [
                  Header(),
                  Row(
                    children: [
                      LeftBar(),
                      Expanded(child: MiddleContent()),
                      RightBar(),
                    ],
                  ),
                ],
              ),
            );
          }
        }),
      ),
    );
  }
}
