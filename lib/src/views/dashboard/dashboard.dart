import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_growth/src/components/greetings.dart';
import 'package:plant_growth/src/components/loadings.dart';
import 'package:plant_growth/src/components/textstyle.dart';
import 'package:plant_growth/src/controllers/accounts_controller.dart';
import 'package:plant_growth/src/controllers/tumbuhan_controller.dart';
import 'package:plant_growth/src/helpers/focus.dart';
import 'package:plant_growth/src/views/setting/myprofile.dart';
import 'detail_plant.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  TextEditingController searchController = TextEditingController();
  AccountsController accountsController = Get.find();
  TumbuhanController tumbuhanController = Get.put(TumbuhanController());
  String? ucapan;

  @override
  void initState() {
    setState(() {
      ucapan = greeting();
    });
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.green.shade50,
                Colors.green.shade100,
                Colors.green.shade200,
                Colors.green.shade300,
              ],
            ),
          ),
          child: GestureDetector(
            onTap: focusManager,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Stack(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      'assets/images/bg.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        backgroundColor: Colors.transparent,
                        floating: true,
                        elevation: 0,
                        pinned: true,
                        snap: false,
                        centerTitle: true,
                        automaticallyImplyLeading: false,
                        leadingWidth: 300,
                        leading: Padding(
                          padding: const EdgeInsets.only(left: 20, top: 10),
                          child: Obx(
                            () => Text("Selamat $ucapan ${accountsController.accountModels.value?.result.name ?? ''}",
                            textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      color: Colors
                                          .black54, // Choose the color of the shadow
                                      blurRadius:
                                          40, // Adjust the blur radius for the shadow effect
                                      // Set the horizontal and vertical offset for the shadow
                                    ),
                                  ],
                                )),
                          ),
                        ),
                        actions: [
                          Obx(
                              () => tumbuhanController.isLoading.value == true ? const Icon(CupertinoIcons.refresh, color: Colors.white) : IconButton(onPressed: () {
                                tumbuhanController.getListTumbuhan();
                              }, icon: Icon(CupertinoIcons.refresh, color: Colors.white)),
                            ),
                          Padding(
                            padding: const EdgeInsets.only(right: 16, top: 5),
                            child: GestureDetector(
                              onTap: () => Get.to(() => const MyProfileDetail()),
                              child: CircleAvatar(
                                backgroundColor: Colors.purple.shade400,
                                child: Obx(
                                  () => Text(
                                    accountsController.accountModels.value?.result.name != null ? accountsController.accountModels.value!.result.name!.toUpperCase().substring(0, 1) : 'U',
                                    style: kDefaultTextStyle(fontSize: 16),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      // Other Sliver Widgets
                      Obx(
                        () => tumbuhanController.tumbuhanModels.value?.tumbuhan.length == 0 ?
                        SliverList(delegate: SliverChildBuilderDelegate((contxt, index) => Container(
                          height: MediaQuery.of(context).size.height / 1.4,
                          child: Center(
                            child: Text("Tidak ada data", style: kDefaultTextStyle(fontSize: 16, color: Colors.black54),)
                          ),
                        ), 
                          childCount: 1)) :
                         SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              print(tumbuhanController.tumbuhanModels.value?.tumbuhan.length);
                              return GestureDetector(
                                    onTap: () {
                                      print(tumbuhanController.tumbuhanModels.value?.tumbuhan[index].imgUrl);
                                      Get.to(
                                        () => PageDetail(
                                          deskripsi: tumbuhanController.tumbuhanModels.value?.tumbuhan[index].deskripsi,
                                          id: tumbuhanController.tumbuhanModels.value?.tumbuhan[index].id,
                                          urlImage: tumbuhanController.tumbuhanModels.value?.tumbuhan[index].imgUrl,
                                          title: tumbuhanController.tumbuhanModels.value?.tumbuhan[index].nama,
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20, top: 20),
                                      child: Container(
                                        height: 110,
                                        decoration: BoxDecoration(
                                            color: index % 2 == 0
                                                ? Colors.green.shade100
                                                : Colors.greenAccent,
                                            gradient: LinearGradient(colors: [
                                              Colors.white.withOpacity(0.4),
                                              Colors.white.withOpacity(0.4),
                                              Colors.white.withOpacity(0.6),
                                              Colors.white.withOpacity(0.6)
                                            ]),
                                            boxShadow: [
                                              BoxShadow(
                                                  blurRadius: 30,
                                                  color: Colors.black26)
                                            ],
                                            borderRadius: BorderRadius.circular(40)),
                                        alignment: Alignment.center,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            tumbuhanController.tumbuhanModels.value?.tumbuhan[index].imgUrl != null ? Container(
                                              width: 100,
                                              margin: const EdgeInsets.only(left: 10),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(10),
                                                child: Image.network(tumbuhanController.tumbuhanModels.value!.tumbuhan[index].imgUrl!))) : Image.asset(
                                              'assets/images/sample.png',
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: Container(
                                                alignment: Alignment.center,
                                                padding: const EdgeInsets.only(
                                                    top: 0, bottom: 0, right: 20),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Flexible(
                                                      child: Obx(
                                                        () => Text(
                                                          tumbuhanController.tumbuhanModels.value?.tumbuhan[index].nama ?? 'Unknown',
                                                          style: kDefaultTextStyle(
                                                              fontSize: 20,
                                                              color: Colors.black87,
                                                              fontWeight:
                                                                  FontWeight.bold),
                                                        ),
                                                      ),
                                                    ),
                                                    Flexible(
                                                      child: Obx(
                                                        () => Text(
                                                          tumbuhanController.tumbuhanModels.value?.tumbuhan[index].deskripsi ?? 'Tidak ada deskripso',
                                                          maxLines: 3,
                                                          overflow: TextOverflow.clip,
                                                          style: kDefaultTextStyle(
                                                            fontSize: 13,
                                                            color: Colors.black87,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Obx(
                                              () => tumbuhanController.isLoading.value == true ? Container() : 
                                              IconButton(
                                                  onPressed: ()async{
                                                if(await tumbuhanController.hapusTumbuhan(idTumbuhan: tumbuhanController.tumbuhanModels.value?.tumbuhan[index].id) == true){
                                                  await tumbuhanController.getListTumbuhan();
                                                }
                                              }, icon: Icon(CupertinoIcons.trash)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                              );
                            },
                            // 40 list items
                            childCount: tumbuhanController.tumbuhanModels.value?.tumbuhan.length,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Obx(() => accountsController.isLoading.value == true || tumbuhanController.isLoading.value == true
            ? floatingLoading()
            : const SizedBox()),
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
