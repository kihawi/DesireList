import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/router/router.gr.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

@RoutePage()
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey navBarKey = GlobalKey();
  double navBarHeight = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final box = navBarKey.currentContext?.findRenderObject() as RenderBox?;
      if (box != null) {
        setState(() {
          navBarHeight =
              box.size.height + MediaQuery.of(context).padding.bottom;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [HomeRoute(), AddDesireRoute(), StatsRoute()],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);

        return Scaffold(
          extendBody: true,
          resizeToAvoidBottomInset: false, //чтобы клава не поднимала ап бар
          body: child,
          bottomNavigationBar: SafeArea(child: _buildBottomAppbar(tabsRouter)),
        );
      },
    );
  }

  Padding _buildBottomAppbar(TabsRouter tabsRouter) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(60, 0, 60, 0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(36),
          color: Theme.of(context).bottomAppBarTheme.color,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.8), // цвет тени
              offset: const Offset(0, 4), // смещение (x, y)
              blurRadius: 10, // размытие
              spreadRadius: 0, // радиус распространения
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: GNav(
            activeColor: Theme.of(context).colorScheme.primary,

            tabBackgroundColor: const Color.fromARGB(50, 255, 255, 255),

            //backgroundColor: const Color.fromARGB(255, 0, 0, 0),
            curve: Curves.slowMiddle,
            gap: 8,

            iconSize: 24,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            duration: const Duration(milliseconds: 300),

            color: const Color.fromARGB(255, 255, 255, 255),
            tabs: const [
              GButton(icon: CupertinoIcons.home, text: 'Home'),
              GButton(icon: CupertinoIcons.heart, text: 'Likes'),
              GButton(icon: CupertinoIcons.search, text: 'Search'),
            ],
            selectedIndex: tabsRouter.activeIndex,
            onTabChange: (index) {
              tabsRouter.setActiveIndex(index);
            },
          ),
        ),
      ),
    );
  }
}
