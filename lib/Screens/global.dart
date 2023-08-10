import 'package:app_emblem/Screens/Home/home_screens.dart';
import 'package:app_emblem/Screens/Map/Map.dart';
import 'package:app_emblem/Screens/Offer/offer_screen.dart';
import 'package:app_emblem/constants.dart';
import 'package:flutter/material.dart';

enum TabPage{map,offres,accueil}

class GlobalPage extends StatefulWidget {


  @override
  _GlobalPageState createState() => _GlobalPageState();
}

class _GlobalPageState extends State<GlobalPage> {
  TabPage currentPage = TabPage.accueil;
  int _selectIndex=1;
  final List <Widget> pageList=[
    OfferScreen(
      key : PageStorageKey("OfferScreen")
    ),
    HomeScreen(
        key: PageStorageKey("HomeScreen"),
        title: "AppEmblem"),
    MapScreen(
      key: PageStorageKey("MapScreen")
    ),
  ];



  final  PageStorageBucket _bucket = PageStorageBucket();

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: pageList[_selectIndex],
        bucket: _bucket),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: kAppPrimaryColorDark,//Theme.of(context).iconTheme.color,
        unselectedItemColor: kAppPrimaryColorDark.withOpacity(.3),//Theme.of(context).iconTheme.color!.withOpacity(.3),
        selectedFontSize: 14,
        unselectedFontSize: 14,
        currentIndex: _selectIndex,
        onTap: (value){
          setState(() {
            _selectIndex=value;
          });

        },
        items: [
          BottomNavigationBarItem(
            label: 'Offres',
            icon: Icon(Icons.menu),
          ),
          BottomNavigationBarItem(
            label: 'Accueil',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Places',
            icon: Icon(Icons.location_on),
          ),
        ],
      ),
    );
  }
}

