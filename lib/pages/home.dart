import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:topcinema/widgets/toolbar.dart';

import '../constants.dart';
import '../widgets/dina_tabview.dart';
import '../widgets/tabbar_button.dart';
import 'tabs/now_playing.dart';
import 'tabs/incoming.dart';
import 'tabs/tickets.dart';
import 'tabs/profile.dart';

class TABS {
  static const nowPlaying = 0;
  static const incoming = 1;
  static const tickets = 2;
  static const menu = 3;
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _tabController = DinaTabController();

  var _tabIndex = TABS.nowPlaying;
  var _toolbarTitle = "EN CARTELERA";

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _tabBar() {
    return Row(
      children: <Widget>[
        TabBarButton(
          path: 'assets/icons/play.svg',
          active: _tabIndex == TABS.nowPlaying,
          onPressed: () {
            _setTab(TABS.nowPlaying);
          },
        ),
        TabBarButton(
          path: 'assets/icons/favorites.svg',
          active: _tabIndex == TABS.incoming,
          onPressed: () {
            _setTab(TABS.incoming);
          },
        ),
        TabBarButton(
          path: 'assets/icons/tickets.svg',
          active: _tabIndex == TABS.tickets,
          onPressed: () {
            _setTab(TABS.tickets);
          },
        ),
        TabBarButton(
          path: 'assets/icons/menu.svg',
          active: _tabIndex == TABS.menu,
          onPressed: () {
            _setTab(TABS.menu);
          },
        )
      ],
    );
  }

  _setTab(int index) {
    _tabController.index = index;

    var title = "";
    switch (index) {
      case TABS.nowPlaying:
        title = "EN CARTELERA";
        break;
      case TABS.incoming:
        title = "PROXIMOS ESTRENOS";
        break;
      case TABS.tickets:
        title = "TUS TICKETS";
        break;
      case TABS.menu:
        title = "TU PERFIL";
        break;
    }

    setState(() {
      _tabIndex = index;
      _toolbarTitle = title;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.primaryColor,
      body: Stack(
        children: <Widget>[
          DinaTabView(children: [
            NowPlayingTab(),
            IncomingTab(),
            TicketsTab(),
            ProfileTab()
          ], tabController: _tabController),
          Toolbar(
            _toolbarTitle,
          )
        ],
      ),
      bottomNavigationBar: _tabBar(),
    );
  }
}
