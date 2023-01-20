import 'package:expenses/screens/addExpense.dart';
import 'package:expenses/screens/allTransactions.dart';
import 'package:expenses/screens/list.dart';
import 'package:expenses/screens/setting.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  PageController? pageController ;
  var currentIndex = 0;
  bool hideButton = false;

  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    onTap(int i){
      currentIndex = i;
      pageController!.animateToPage(i, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
      setState(() {

      });
    }
    return Scaffold(
      backgroundColor: const Color(0xff010001),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: PageView(
              // reverse: true,
              controller: pageController,
              physics: NeverScrollableScrollPhysics(),
              children: [
              ListScreen(),
              AllTransactions(),
            ],),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,

            child: Container(
              margin: const EdgeInsets.only(
                top: 28,
              ),
              decoration: const BoxDecoration(
                  color: Color(0xff181919),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  )),
              height: MediaQuery.of(context).size.height * 0.08,
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: () {
                          hideButton = false;
                          onTap(0);
                        },
                        icon: const Icon(
                          Icons.list,
                          size: 35,
                        ),
                      ),
                      const SizedBox(width: 15,),
                      IconButton(
                        onPressed: () {
                          hideButton = true;
                          onTap(1);
                        },
                        icon: const Icon(
                          Icons.bar_chart_sharp,
                          size: 35,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: width/2-30,
            right: width/2-30,
            bottom: MediaQuery.of(context).size.height*0.08-30,
            child: Visibility(

              visible: hideButton==true?false:true,
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AddExpense()));
                },
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Color(0xff03efc4),
                    //
                    shape: BoxShape.circle
                  ),
                  child: const Center(
                    child: Icon(Icons.add,size: 30,color: Colors.white,),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}





//floatingActionButton: FloatingActionButton(
//         backgroundColor: const Color(0xff03efc4).withOpacity(0.7),
//         onPressed: () {},
//         child: const Icon(
//           Icons.add,
//           color: Colors.white,
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,




//BottomNavigationBar(
//         backgroundColor: Color(0xff181919),
//         iconSize: 35,
//         showUnselectedLabels: false,
//         showSelectedLabels: false,
//         type: BottomNavigationBarType.fixed,
//         selectedItemColor: Colors.white,
//         unselectedItemColor: Colors.white,
//         currentIndex: currentIndex,
//         onTap: onTap,
//         items: const [
//         BottomNavigationBarItem(icon: Icon(Icons.list),label: 'List'),
//         BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings')
//       ],
//
//       )