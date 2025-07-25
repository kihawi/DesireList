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
    context.read<DesireBloc>().add(LoadDesireList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              //backgroundColor: Colors.white,
              centerTitle: false,
              //expandedHeight: 200,
              floating: true, // чтобы появлялся при скролле вверх
              // snap: true,
              title: Text(
                'Мои хотелки',
                style: TextStyle(
                  fontSize: 32,
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
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
          ];
        },
        body: BlocBuilder<DesireBloc, DesireState>(
          builder: (context, state) {
            if (state is DesireListLoaded) {
              return Center(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: state.desireList.length,
                  itemBuilder: (context, index) {
                    return CardOfDesire(desire: state.desireList[index]);
                  },
                ),
              );
            }
            if (state is DesireListLoading) {}

            return Center(child: const CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
