import 'package:firebase_auth/firebase_auth.dart';
import 'package:app/auth.dart';
import 'package:flutter/material.dart';
import 'package:app/tabs/first_tab.dart';
import 'package:app/tabs/second_tab.dart';
import 'package:app/tabs/third_tab.dart';

class HomePage extends StatelessWidget{
  HomePage({Key? key}) : super(key: key);

  final User? user = Auth().currentUser;

  Future<void> signOut() async{
    await Auth().signOut();
  }

  Widget _title(){
    return const Text('Firebase Auth');
  }

  Widget _userUid(){
    return Text (user?.email ?? 'user email');
  }

  Widget _signOutButton() {
    return ElevatedButton(
      onPressed: signOut,
      child: const Text('sign out')
    );
  }

 @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          shadowColor: Colors.red,
          title: Center(
            child: Text(
              'M I N I 🎮A M E S',
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: Column(
          children: [

            Expanded(
              child: TabBarView(
                children: [
                  // 1st tab
                  FirstTab(
                    
                  ),

                  // 2nd tab
                  SecondTab(),

                  // 3rd tab
                  ThirdTab(),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color.fromARGB(255, 194, 10, 10), Color.fromARGB(255, 36, 2, 2)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: TabBar(
                unselectedLabelColor: Colors.white, // Color for unselected tabs
                labelColor: Color.fromARGB(255, 204, 9, 9), // Color for selected tab
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  color: Colors.white, // Background color for the selected tab
                ),
                tabs: [
                  Tab(
                    icon: Icon(
                      Icons.home,
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.message_rounded,
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.settings,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}