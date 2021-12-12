import 'package:dhoro_mobile/ui/overview/overview.dart';
import 'package:dhoro_mobile/ui/request/requests.dart';
import 'package:dhoro_mobile/ui/settings/settings.dart';
import 'package:dhoro_mobile/ui/transactions/transactions.dart';
import 'package:dhoro_mobile/utils/color.dart';
import 'package:dhoro_mobile/utils/strings.dart';
import 'package:dhoro_mobile/widgets/app_toolbar.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DashboardPage extends StatefulHookWidget {
  int selectedIndex = 0;
  DashboardPage({required this.selectedIndex});
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  //int _selectedIndex = 2;

  void _onItemTapped(int index) {
    print("index: $index");
    setState(() {
      widget.selectedIndex = index;
    });
  }

  List<Widget> _pages = <Widget>[
    OverviewPage(),
    TransactionsPage(),
    RequestsPage(),
    SettingsPage(),
  ];

  List<String> _titles = <String>[
    AppString.overView,
    AppString.transactions,
    AppString.requests,
    AppString.settings,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallet.colorBackground,
      body: SafeArea(
        child: IndexedStack(
          index: (widget.selectedIndex),
          children: _pages,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.selectedIndex,
        onTap: _onItemTapped,
        iconSize: 40,
        selectedItemColor: Pallet.colorBlue,
        unselectedItemColor: Pallet.colorGrey,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppImages.icOverViewInActive,
              width: 24.0,
              height: 24.0,
            ),
            activeIcon: SvgPicture.asset(
              AppImages.icOverView,
              width: 24.0,
              height: 24.0,
              color: Pallet.colorBlue,
            ),
            label: AppString.overView,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppImages.icTransactionsInActive,
              width: 24.0,
              height: 24.0,
            ),
            activeIcon: SvgPicture.asset(
              AppImages.icTransactions,
              width: 24.0,
              height: 24.0,
              color: Pallet.colorBlue,
            ),
            label: AppString.transactions,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppImages.icRequestInActive,
              width: 24.0,
              height: 24.0,
            ),
            activeIcon: SvgPicture.asset(
              AppImages.icRequest,
              width: 24.0,
              height: 24.0,
            ),
            label: AppString.requests,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppImages.icSettingsInActive,
              width: 24.0,
              height: 24.0,
            ),
            activeIcon: SvgPicture.asset(
              AppImages.icSettings,
              width: 24.0,
              height: 24.0,
            ),
            label: AppString.settings,
          ),
        ],
      ),
    );
  }
}