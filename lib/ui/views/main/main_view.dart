import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:oruphones/ui/components/drawer.dart';
import 'package:oruphones/ui/components/silverAppBar.dart';
import 'package:stacked/stacked.dart';
import '../../widgets/bottom_nav.dart';
import '../home/home_view.dart';
import 'main_viewmodel.dart';

class MainView extends StatefulWidget {
  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => MainViewModel(),
      onModelReady: (viewModel) => viewModel.fetchFcmToken(),
      builder: (context, viewModel, child) {
        return Container(
          color: Colors.white,
          child: SafeArea(
            child: Stack(
              children: [
                Scaffold(
                  key: scaffoldKey,
                  backgroundColor: Colors.white,
                  extendBodyBehindAppBar: true,
                  drawer: Container(
                      margin: EdgeInsets.only(bottom: 52), child: MainDrawer()),
                  body: NestedScrollView(
                    controller: viewModel.scrollController,
                    headerSliverBuilder: (context, innerBoxIsScrolled) => [
                      SilverAppBar(
                          onMenuTap: () => scaffoldKey.currentState?.openDrawer(),
                          scrollController: viewModel.scrollController,
                      ),
                      // SliverPersistentHeader(
                      //   pinned: true,
                      //   floating: true,
                      //   delegate: _SearchBarDelegate(),
                      // ),
                    ],
                    body: IndexedStack(
                      index: viewModel.selectedIndex,
                      children: [
                        HomeView(),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Column(
                    children: [
                      Transform.translate(
                          offset: Offset(0, 70),
                          child: viewModel.isBottomNavVisible
                              ? BottomNav()
                              : SizedBox()),
                      Transform.translate(
                        offset: Offset(0, -20),
                        child: viewModel.isBottomNavVisible
                            ? Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black,
                                  border: Border.all(
                                      color: Colors.yellow, width: 5),
                                ),
                                child: Icon(Icons.add,
                                    color: Colors.yellow, size: 28),
                              )
                            : SizedBox(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SearchBarDelegate extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 80;

  @override
  double get maxExtent => 80;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      padding: EdgeInsets.all(8.0),
      color: Colors.white.withOpacity(0.9),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search, size: 20),
          suffixIcon: Icon(Icons.mic_none, size: 20),
          hintText: 'Search...',
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        ),
        style: TextStyle(fontSize: 14),
      ),
    );
  }

  @override
  bool shouldRebuild(_SearchBarDelegate oldDelegate) => false;
}
