import 'package:flutter/material.dart';
import 'package:oruphones/ui/components/searchBar.dart';
import 'package:oruphones/ui/views/main/silverAppBar_viewmodel.dart';
import 'package:stacked/stacked.dart';
import '../widgets/buttonlist.dart';


class SilverAppBar extends StatelessWidget {
  final VoidCallback onMenuTap;
  final ScrollController scrollController;

  const SilverAppBar({required this.onMenuTap, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SilverAppBarViewModel>.reactive(
      viewModelBuilder: () => SilverAppBarViewModel(scrollController),
      builder: (context, viewModel, child) {
        return SliverAppBar(
          automaticallyImplyLeading: false,
          pinned: true,
          floating: false,
          backgroundColor: Colors.white.withOpacity(0),
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          expandedHeight: 100,

          flexibleSpace: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 300),
                    top: MediaQuery.of(context).padding.top +
                        viewModel.titleOffsetNotifier.value,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Colors.white.withOpacity(0.9),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: onMenuTap,
                                child: Image.asset('assets/logo/menu.png',
                                    height: 40),
                              ),
                              AnimatedOpacity(
                                opacity: viewModel.titleOffsetNotifier.value == 0.0
                                    ? 1.0
                                    : 0.0,
                                duration: Duration(milliseconds: 300),
                                child: Image.asset('assets/logo/header logo.png',
                                    height:50,width: 60,),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                'India',
                                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                              ),
                              const Icon(Icons.location_on_outlined, size: 30),
                              SizedBox(width: 2),
                              viewModel.isLoggedIn
                                  ? Icon(Icons.notifications_active_outlined,
                                  size: 35, color: Colors.black)
                                  : ElevatedButton(
                                onPressed: viewModel.navigateToLogin,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFFF6C018),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.elliptical(10, 10))),
                                  padding:
                                  EdgeInsets.symmetric(horizontal: 30),
                                ),
                                child: Text("Login",
                                    style: TextStyle(color: Colors.black)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(90),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: 100,
              transform: Matrix4.translationValues(
                  0, viewModel.isScrolledNotifier.value ? -50 : 0, 0),
              padding: EdgeInsets.all(4.0),
              color: Colors.white.withOpacity(0.5),
              child: Column(
                children: [
                  SearchBarWidget(),
                  SizedBox(height: 5),
                  Buttonlist(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
