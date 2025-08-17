import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/router/router.gr.dart';

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
      routes: const [HomeRoute(), StatsRoute()],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);

        return Scaffold(
          extendBody: true,
          resizeToAvoidBottomInset: false, //чтобы клава не поднимала ап бар
          body: child,
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: SafeArea(child: _buildBottomAppbar(tabsRouter)),
          ),
        );
      },
    );
  }

  Padding _buildBottomAppbar(TabsRouter tabsRouter) {
    return Padding(
      key: navBarKey,
      padding: EdgeInsetsGeometry.directional(end: 55, start: 55),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Theme.of(context).bottomAppBarTheme.color,
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 25,
            right: 25,
            top: 10,
            bottom: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              IconButton(
                iconSize: 30,
                highlightColor: Theme.of(context).primaryColor,
                icon: Icon(Icons.home_filled, color: Colors.white),
                onPressed: () => tabsRouter.setActiveIndex(0),
              ),
              IconButton(
                iconSize: 30,
                highlightColor: Theme.of(context).primaryColor,
                icon: Icon(Icons.add, color: Colors.white),
                onPressed: () => context.pushRoute(AddDesireRoute()),
              ),
              IconButton(
                iconSize: 30,
                highlightColor: Theme.of(context).primaryColor,
                icon: Icon(Icons.query_stats, color: Colors.white),
                onPressed: () => tabsRouter.setActiveIndex(2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
