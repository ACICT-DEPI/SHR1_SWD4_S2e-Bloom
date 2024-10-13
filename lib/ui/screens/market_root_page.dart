
import 'package:bloom/ui/screens/marketScreens/cart_page.dart';
import 'package:bloom/ui/screens/marketScreens/favorite_page.dart';
import 'package:bloom/ui/screens/marketScreens/market_home_page.dart';
import 'package:flutter/material.dart';
import '../../models/plants.dart';

class MarketRootPage extends StatefulWidget {
  const MarketRootPage({super.key});

  @override
  State<MarketRootPage> createState() => _MarketRootPageState();
}

class _MarketRootPageState extends State<MarketRootPage> with TickerProviderStateMixin{
  List<Plant> favorites = [];
  List<Plant> myCart = [];

  // int _bottomNavIndex = 0;
  late TabController _tabController; 

  //List of the pages
  List<Widget> _widgetOptions(){
    return [
      const MarketHomePage(),
      FavoritePage(favoritedPlants: favorites,),
      CartPage(addedToCartPlants: myCart,),
     // const ProfilePage(),
    ];
  }

  //List of the pages icons
  List<IconData> iconList = [
    Icons.home,
    Icons.favorite,
    Icons.shopping_cart,
  ];

  //List of the pages titles
  List<String> titleList = [
    'Home',
    'Favorite',
    'Cart',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        return; // Ignore tab index changes during animation
      }
      // Handle actions based on the selected tab
      if (_tabController.index == 0) {
        setState(() {
          final List<Plant> favoritedPlants = Plant.getFavoritedPlants();
            final List<Plant> addedToCartPlants = Plant.addedToCartPlants();

            favorites = favoritedPlants;
            myCart = addedToCartPlants.toSet().toList();
        });
      } else if (_tabController.index == 1) {
        setState(() {
          final List<Plant> favoritedPlants = Plant.getFavoritedPlants();
            final List<Plant> addedToCartPlants = Plant.addedToCartPlants();

            favorites = favoritedPlants;
            myCart = addedToCartPlants.toSet().toList();
        });
      } else if (_tabController.index == 2) {
        setState(() {
          final List<Plant> favoritedPlants = Plant.getFavoritedPlants();
            final List<Plant> addedToCartPlants = Plant.addedToCartPlants();

            favorites = favoritedPlants;
            myCart = addedToCartPlants.toSet().toList();
        });
      }
    });
  }
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize : const Size.fromHeight(kToolbarHeight),
        child: TabBar(
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
              text:  'Home',
              icon: Icon(Icons.home),
            ),
            Tab(
              text: 'Favorite',
              icon: Icon(Icons.favorite),
            ),
            Tab(
              text: 'Cart',
              icon: Icon(Icons.shopping_cart,),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _widgetOptions(),
      ),

      // appBar: AppBar(
      //   title: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       Text(titleList[_bottomNavIndex], style: TextStyle(
      //         color: Constants.blackColor,
      //         fontWeight: FontWeight.w500,
      //         fontSize: 24,
      //       ),),
      //       Icon(Icons.notifications, color: Constants.blackColor, size: 30.0,)
      //     ],
      //   ),
      //   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      //   elevation: 0.0,
      // ),
      // body: IndexedStack(
      //   index: _bottomNavIndex,
      //   children: _widgetOptions(),
      // ),
      // // floatingActionButton: FloatingActionButton(
      // //   onPressed: (){
      // //     Navigator.push(context, PageTransition(child: const ScanPage(), type: PageTransitionType.bottomToTop));
      // //   },
      // //   child: Image.asset('assets/images/code-scan-two.png', height: 30.0,),
      // //   backgroundColor: Constants.primaryColor,
      // // ),
      // // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // bottomNavigationBar: AnimatedBottomNavigationBar(
      //   splashColor: Constants.primaryColor,
      //   activeColor: Constants.primaryColor,
      //   inactiveColor: Colors.black.withOpacity(.5),
      //   icons: iconList,
      //   activeIndex: _bottomNavIndex,
      //   //gapLocation: GapLocation.center,
      //   notchSmoothness: NotchSmoothness.softEdge,
      //   onTap: (index){
      //     setState(() {
      //       _bottomNavIndex = index;
      //       final List<Plant> favoritedPlants = Plant.getFavoritedPlants();
      //       final List<Plant> addedToCartPlants = Plant.addedToCartPlants();

      //       favorites = favoritedPlants;
      //       myCart = addedToCartPlants.toSet().toList();
      //     });
      //   }
      // ),
    );
  }
}
