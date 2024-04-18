import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cubit_project/app/app.dart';

import '../view_model/cubit/loot_box_cubit/loot_box_cubit.dart';

class AppProvider extends StatelessWidget {
  const AppProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LootBoxCubit>(
          create: (context) => LootBoxCubit(),
        ),
      ],
      child: const AppWidget(),
    );
  }
}
