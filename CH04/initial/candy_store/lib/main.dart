import 'package:candy_store/viewmodel/cart_viewmodel.dart';
import 'package:candy_store/viewmodel/cart_view_model_provider.dart';
import 'package:candy_store/view/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/cart_cubit.dart';

// At this point, all of the code is in the `lib` folder and we will structure it in Part 3
void main() {
  runApp(
    BlocProvider<CartCubit>(
      create: (BuildContext context) => CartCubit(),
      child: MaterialApp(
        title: 'Candy shop',
        theme: ThemeData(
          primarySwatch: Colors.lime,
        ),
        home: const MainPage(),
      ),
    ),
  );
}
