import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:provider/provider.dart';
import 'package:plank/blocs/themeChanger.dart';
import 'package:plank/screens/about.dart';
import 'package:plank/screens/contact.dart';
import 'package:plank/screens/favorites.dart';
import 'package:plank/screens/loginPage.dart';
import 'package:plank/screens/myAccount.dart';
import 'package:plank/screens/settings.dart';
import 'package:plank/ui/cart_product_details.dart';
import 'package:plank/ui/recent_products.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool darkmode = false;

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseUser currentUser;
  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
  }

  void _loadCurrentUser() {
    firebaseAuth.currentUser().then((FirebaseUser user) {
      setState(() {
        // call setState to rebuild the view
        this.currentUser = user;
      });
    });
  }

  String userName() {
    if (currentUser != null) {
      if (currentUser.displayName == null) {
        return currentUser.email.replaceAll('@gmail.com', '');
      }
      return currentUser.displayName;
    } else {
      return "";
    }
  }

  String email() {
    if (currentUser != null) {
      return currentUser.email;
    } else {
      return "No Email Address";
    }
  }

  String photoUrl() {
    if (currentUser != null) {
      return currentUser.email[0].toUpperCase();
    } else {
      return "A";
    }
  }

  @override
  Widget build(BuildContext context) {
    // Which is used to listen to the nearest change and provides the current state and rebuilds the widget.
    ThemeChanger theme = Provider.of<ThemeChanger>(context);

    return Scaffold(
      // Drawer Start
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF58D68D),
              ),
              accountName: Text("${userName()}"),
              accountEmail: Text("${email()}"),
              currentAccountPicture: GestureDetector(
                child: CircleAvatar(
                  backgroundColor: Colors.redAccent[100],
                  child: Text("${photoUrl()}",
                      style: TextStyle(
                        fontSize: 35.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ),
            ),
            ListTile(
              leading: darkmode
                  ? Image.asset(
                      'images/moon.png',
                      height: 30.0,
                      width: 26.0,
                    )
                  : Image.asset(
                      'images/sunny.png',
                      height: 30.0,
                      width: 26.0,
                    ),
              title: Text("DarkMode"),
              trailing: Switch(
                value: darkmode,
                onChanged: (val) {
                  setState(() {
                    darkmode = val;
                  });
                  if (darkmode) {
                    theme.setTheme(ThemeData.dark());
                  } else {
                    theme.setTheme(ThemeData.light());
                  }
                },
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => MyAccount()));
              },
              child: _showList(
                "My Account",
                (Icons.account_box),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Favorites(),
                  ),
                );
              },
              child: _showList(
                "Favorites",
                (Icons.favorite),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Settings()));
              },
              child: _showList(
                "Settings",
                (Icons.settings),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => About()));
              },
              child: _showList(
                "About",
                (Icons.adjust),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Contact()));
              },
              child: _showList(
                "Contact",
                (Icons.contact_phone),
              ),
            ),
            InkWell(
              onTap: () {
                FirebaseAuth.instance.signOut().then((value) {
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Login()));
                });
              },
              child: _showList(
                "LogOut",
                (Icons.exit_to_app),
              ),
            ),
          ],
        ),
      ),
      // Drawer ends
      appBar: AppBar(
        titleSpacing: 2.0,
        elevation: 0,
        backgroundColor: Color(0xFF58D68D),
        title: Text("Plank"),
        // Showing Cart Icon
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_shopping_cart),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CartProductDetails()));
            },
          ),
        ],
        // Showing Search Bar
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(Icons.search),
        //     onPressed: () {
        //       showSearch(context: context, delegate: ProductSearch());
        //     },
        //   ),
        // ],
      ),
      body: Column(
        children: <Widget>[
          _imgCarousel(),
          // _categories(),
          // CategoryImages(),
          Container(
            alignment: Alignment.center,
            child: Text(
              "Products",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21.0,color: Color(0xFF2E5894)),
            ),
            padding: EdgeInsets.all(10.0),
          ),
          //grid view
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 0.0),
              child: RecentProducts(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _imgCarousel() {
    return Container(
      height: 200.0,
      child: Carousel(
        overlayShadow: true,
        overlayShadowColors: Colors.black45,
        dotSize: 5.0,
        autoplay: true,
        animationCurve: Curves.bounceInOut,
        dotBgColor: Colors.transparent,
        boxFit: BoxFit.cover,
        images: [
          AssetImage('images/c8.jpg'),
          AssetImage('images/c9.jpg'),
          AssetImage('images/c10.jpg'),
          AssetImage('images/c11.jpg'),
          AssetImage('images/c12.jpg'),
          AssetImage('images/c13.jpg'),
          AssetImage('images/c14.jpg'),
        ],
      ),
    );
  }

  Widget _showList(String s, IconData i) {
    return ListTile(
      leading: Icon(
        i,
        color: Colors.yellow[700],
      ),
      title: Text(s),
    );
  }
}

//* SearchBar

// class ProductSearch extends SearchDelegate<String> {
//   // final List searchProd = ["arr", "allow", "Blazer", "ramu", "haz"];
//   final List searchProd = [
//     'Blazer',
//     'Red-Blazer',
//     'Dress',
//     'Jeans',
//     'Green-T-Shirt',
//     'T-Shirt',
//     'Skirt1',
//     'Skirt2',
//     'Shoe1',
//     'Shoe2',
//     'Heel1',
//     'Heel2',
//   ];
//   final List recentSearchProd = [
//     'Blazer',
//     'Jeans',
//     'Skirt1',
//   ];
//   @override
//   List<Widget> buildActions(BuildContext context) {
//     // Actions for appbar
//     return [
//       IconButton(
//         icon: Icon(Icons.clear),
//         onPressed: () {
//           query = "";
//         },
//       )
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     // Leading icon
//     return IconButton(
//       onPressed: () {
//         close(context, null);
//       },
//       icon: AnimatedIcon(
//         icon: AnimatedIcons.menu_arrow,
//         progress: transitionAnimation,
//       ),
//     );
//   }

//   @override
//   Widget buildResults(
//     BuildContext context,
//   ) {
//     // show results for given keyword

//     return Center(
//         child: CircularProgressIndicator(backgroundColor: Colors.redAccent));
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     // shows suggestions for keyword
//     final suggestionList = query.isEmpty
//         ? recentSearchProd
//         : searchProd.where((s) => s.toLowerCase().startsWith(query)).toList();
//     // contains,startswith,endswith and so on
//     return ListView.builder(
//       itemCount: suggestionList.length,
//       itemBuilder: (_, int i) {
//         return ListTile(
//           onTap: () {
//             showResults(context);
//           },
//           leading: Icon(Icons.shopping_basket),
//           title: RichText(
//             text: TextSpan(
//               text: suggestionList[i].substring(0, query.length),
//               style:
//                   TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//               children: [
//                 TextSpan(
//                     text: suggestionList[i].substring(query.length),
//                     style: TextStyle(color: Colors.grey)),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
