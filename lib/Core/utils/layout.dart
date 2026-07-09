import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../../Features/home/presentation/views/home_screen.dart';
import '../../Features/info_app/presentation/views/info_app_screen.dart';

import '../../Features/search/presentation/views/barcode_scan_screen.dart';
import '../../Features/search/presentation/views/search_screen.dart';
import '../constants/color_constants.dart';
import '../helpers/dialogs/exit_dialog.dart';

class Layout extends StatefulWidget {
  const Layout({Key? key}) : super(key: key);
  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int _pageIndex = 0;

  final GlobalKey<SearchScreenState> _searchKey =
      GlobalKey<SearchScreenState>();

  void _onTabChange(int idx) {
    _searchKey.currentState?.clearSearchField();

    setState(() {
      _pageIndex = idx;
    });
  }

  Future<bool> _onWillPop() async {
    if (_pageIndex != 0) {
      _searchKey.currentState?.clearSearchField();
      setState(() => _pageIndex = 0);
      return false;
    }
    final shouldExit = await showExitDialog(context);
    if (shouldExit) SystemNavigator.pop();
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: IndexedStack(
          index: _pageIndex,
          children: [
            const HomeScreen(),
            SearchScreen(key: _searchKey),
            if (_pageIndex == 2)
              const ScannerView()
            else
              const SizedBox.shrink(),
            const AboutAppScreen(),
          ],
        ),
        bottomNavigationBar: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: GNav(
              gap: 0,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              tabBackgroundColor: kPrimaryColor,
              activeColor: Colors.white,
              color: Colors.grey.shade600,
              textStyle: TextStyle(fontSize: 17, color: Colors.white),
              tabBorderRadius: 30,
              duration: const Duration(milliseconds: 400),
              selectedIndex: _pageIndex,
              onTabChange: _onTabChange,
              tabs: [
                GButton(
                    icon: Icons.home,
                    iconColor: cs.onSurface,
                    text: 'الرئيسية'),
                GButton(
                    icon: Icons.search, iconColor: cs.onSurface, text: 'بحث'),
                GButton(
                    icon: Icons.qr_code, iconColor: cs.onSurface, text: 'مسح'),
                GButton(
                    icon: Icons.info_outline,
                    iconColor: cs.onSurface,
                    text: 'عن التطبيق'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
