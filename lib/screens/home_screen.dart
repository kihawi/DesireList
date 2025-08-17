import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/bloc/desire_bloc.dart';
import 'package:flutter_projects/theme/bloc/theme_bloc.dart';
import 'package:flutter_projects/widgets/card_widget.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<DesireBloc>().add(LoadDesireListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DesireBloc, DesireState>(
        builder: (context, state) {
          if (state is DesireListLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is DesireListLoadedState) {
            final list = state.desireList;

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  //expandedHeight: 120,
                  // flexibleSpace: FlexibleSpaceBar(
                  //   background: Column(
                  //     mainAxisAlignment: MainAxisAlignment.end,
                  //     children: [
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //         children: [
                  //           Container(width: 50, height: 50, color: Colors.red),
                  //           Container(
                  //             width: 50,
                  //             height: 50,
                  //             color: Colors.green,
                  //           ),
                  //           Container(
                  //             width: 50,
                  //             height: 50,
                  //             color: Colors.blue,
                  //           ),
                  //         ],
                  //       ),
                  //       SizedBox(height: 10),
                  //     ],
                  //   ),
                  // ),
                  centerTitle: false,
                  floating: true,
                  snap: true,
                  title: const Text(
                    'Мои хотелки',
                    style: TextStyle(
                      fontSize: 32,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  actions: [
                    IconButton(
                      iconSize: 32,
                      onPressed: () {
                        context.read<ThemeBloc>().add(ChangeTheme());
                      },
                      icon: const Icon(Icons.dark_mode_outlined),
                    ),
                  ],
                ),

                if (list.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Text(
                        'Список пуст',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  )
                else
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => CardOfDesire(desire: list[index]),
                      childCount: list.length,
                    ),
                  ),
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
