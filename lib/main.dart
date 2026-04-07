import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app.dart';
import 'features/generator/presentation/cubit/generator_cubit.dart';
import 'features/calculator/presentation/cubit/calculator_cubit.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GeneratorCubit()),
        BlocProvider(create: (_) => CalculatorCubit()),
      ],
      child: const ResponsiveForgeApp(),
    ),
  );
}
