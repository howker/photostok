import 'dart:async';

import 'package:photostok/app.dart';
import 'package:flutter/material.dart';
import 'package:photostok/res/res.dart';
import 'package:flutter/widgets.dart';
import 'package:photostok/screens/main_photo_screen.dart';
import 'package:connectivity/connectivity.dart';
import 'package:photostok/screens/search_screen.dart';
import 'package:photostok/widgets/widgets.dart';

class Home extends StatefulWidget {
  Home(this.onConnectivityChanged);
  final Stream<ConnectivityResult> onConnectivityChanged;

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  StreamSubscription subscription;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    subscription =
        widget.onConnectivityChanged.listen((ConnectivityResult result) {
      switch (result) {
        case ConnectivityResult.wifi:
          ConnectivityOverlay().removeOverlay(context);
          break;
        case ConnectivityResult.mobile:
          ConnectivityOverlay().removeOverlay(context);
          break;
        case ConnectivityResult.none:
          ConnectivityOverlay().showOverlay(
            context,
            Positioned(
              top: MediaQuery.of(context).viewInsets.top + 50,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                    decoration: BoxDecoration(
                      color: AppColors.mercury,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text('No internet connection'),
                  ),
                ),
              ),
            ),
          );
          break;
      }
    });
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(
      () {
        if (!_tabController.indexIsChanging) {
          setState(() {});
        }
      },
    );
  }

  @override
  void dispose() {
    subscription.cancel();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.dodgerBlue,
        unselectedItemColor: AppColors.manatee,
        showSelectedLabels: true,
        currentIndex: _tabController.index,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(
              AppIcons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.account_circle_outlined),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          setState(() {
            _tabController.index = index;
          });
        },
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          MainPhotoList(),
          SearchScreen(),
          Container(child: Center(child: Text('PROFILE SCREEN'))),
        ],
      ),
    );
  }
}
