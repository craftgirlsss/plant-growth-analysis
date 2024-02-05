import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plant_growth/src/components/textstyle.dart';
import 'package:plant_growth/src/helpers/focus.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              'assets/images/bg.png',
              fit: BoxFit.cover,
            )),
        GestureDetector(
          onTap: focusManager,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  floating: true,
                  pinned: true,
                  snap: false,
                  centerTitle: true,
                  automaticallyImplyLeading: false,
                  title: Text(
                    'Dashboard',
                    style: kDefaultTextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 16, top: 5),
                      child: CircleAvatar(
                        backgroundColor: Colors.red,
                        child: Text(
                          'A',
                          style: kDefaultTextStyle(fontSize: 16),
                        ),
                      ),
                    )
                  ],
                  bottom: AppBar(
                    backgroundColor: Colors.transparent,
                    automaticallyImplyLeading: false,
                    title: Container(
                      width: double.infinity,
                      height: 40,
                      color: Colors.transparent,
                      child: Center(
                          child: TextFormField(
                              controller: searchController,
                              keyboardType: TextInputType.text,
                              autofocus: false,
                              style: kDefaultTextStyle(
                                  color: Colors.black87, fontSize: 15),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                filled: true,
                                prefixIcon: const Icon(CupertinoIcons.search,
                                    color: Colors.black54),
                                // filled: true,
                                fillColor: Colors.white,
                                hintText: 'Cari',
                                hintStyle: kDefaultTextStyle(
                                    color: Colors.black87, fontSize: 15),
                                contentPadding: const EdgeInsets.fromLTRB(
                                    20.0, 10.0, 20.0, 10.0),
                                // border: OutlineInputBorder(
                                //   borderSide: BorderSide.none,
                                //   borderRadius: BorderRadius.circular(32.0),
                              ))),
                    ),
                  ),
                ),
                // Other Sliver Widgets
                SliverList(
                  delegate: SliverChildListDelegate([
                    const SizedBox(
                      height: 400,
                      child: Center(
                        child: Text(
                          'This is an awesome shopping platform',
                        ),
                      ),
                    ),
                    Container(
                      height: 1000,
                      color: Colors.pink,
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ],
    );

    // Scaffold(
    //   backgroundColor: Colors.black,
    //   appBar: AppBar(
    //     automaticallyImplyLeading: false,
    //     elevation: 0,
    //     backgroundColor: Colors.black,
    //     title: Text(
    //       "Dashboard",
    //       style: kDefaultTextStyle(color: Colors.white, fontSize: 18),
    //     ),
    //     centerTitle: true,
    //     actions: [
    //       Padding(
    //         padding: const EdgeInsets.only(right: 16, top: 5),
    //         child: CircleAvatar(
    //           backgroundColor: Colors.red,
    //           child: Text(
    //             'A',
    //             style: kDefaultTextStyle(fontSize: 16),
    //           ),
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }
}
