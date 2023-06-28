import 'package:flutter/material.dart';
import 'package:habit_speed_code/pages/habitsPage.dart';
import 'package:habit_speed_code/pages/profilePage.dart';
import 'package:habit_speed_code/pages/progressPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'pages/homePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:habit_speed_code/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var FirebaseAuth;
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
     home: StreamBuilder(
        stream: FirebaseAuth(),
        builder: (BuildContext context,AsyncSnapshot snapshot){
          if(snapshot.hasError)
          {
            return Text(snapshot.error.toString());
          }

          var Snapshot;
          if(Snapshot.connectionState==ConnectionState.active)
          {
            if(snapshot.data==null)
            {
              return LoginPage();
            }
            else
            {
              return HomePage(title: FirebaseAuth.currentUser!.displayName!);
            }
          }

          return CircularProgressIndicator();
        },
      ),
    );
  }
}

class NavigationScreen extends StatefulWidget {
  NavigationScreen({required this.currentIndex});
  int currentIndex;
  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

const List<Widget> screens = [
  HomePage(),
  ProgressPage(),
  Habitspage(),
  ProfilePage()
];

class _NavigationScreenState extends State<NavigationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Title'),
        actions: <Widget> [
          IconButton(icon: new Icon(Icons.home),
          onPressed: () async{
            await GoogleSignIn().signOut();
            // FirebaseAuth.instance.signOut();
            InputDecoration( 
              labelText: "Username",
              icon: Icon(Icons.power_settings_new)
            );
          },
          )
        ]
      ),
      body: IndexedStack(
        index: widget.currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.deepPurpleAccent,
        currentIndex: widget.currentIndex,
        onTap: (index) {
          setState(() {
            widget.currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: "Progress"),
          BottomNavigationBarItem(icon: Icon(Icons.timeline), label: "Habits"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile")
        ],
      ),
    );
  }
}
