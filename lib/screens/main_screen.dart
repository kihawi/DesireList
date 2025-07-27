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
      padding: EdgeInsetsGeometry.directional(end: 55, start: 55),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Theme.of(context).bottomAppBarTheme.color,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            IconButton(
              icon: Icon(Icons.home_filled),
              onPressed: () => tabsRouter.setActiveIndex(0),
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => tabsRouter.setActiveIndex(1),
            ),
            IconButton(
              icon: Icon(Icons.query_stats),
              onPressed: () => tabsRouter.setActiveIndex(2),
            ),
          ],
        ),
      ),
    );
  }
}
