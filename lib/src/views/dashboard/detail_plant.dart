import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_growth/src/components/loadings.dart';
import 'package:plant_growth/src/components/textstyle.dart';
import 'package:plant_growth/src/controllers/tumbuhan_controller.dart';
import 'package:plant_growth/src/helpers/focus.dart';

import 'adding_perkembangan.dart';

class PageDetail extends StatefulWidget {
  final String? title;
  final String? id;
  final String? urlImage;
  final String? deskripsi;
  const PageDetail({super.key, this.title, this.urlImage, this.id, this.deskripsi});

  @override
  State<PageDetail> createState() => _PageDetailState();
}

class _PageDetailState extends State<PageDetail> {
  TumbuhanController tumbuhanController = Get.find();
  TextEditingController? diameter;
  TextEditingController? hari;
  TextEditingController? tinggi;

  void popUpAddData() {
    Get.defaultDialog(
        content: Column(
          children: [
            Text(
              "Tambah data secara manual untuk menginputkan ukuran pohon per hari",
              style: kDefaultTextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            CupertinoTextField(
              controller: diameter,
              placeholderStyle: const TextStyle(color: Colors.black38),
              placeholder: "Dimeter Pohon",
              suffix: const Padding(
                padding: EdgeInsets.only(right: 8),
                child: Icon(CupertinoIcons.person, color: Colors.black26),
              ),
            ),
            const SizedBox(height: 5),
            CupertinoTextField(
              keyboardType: const TextInputType.numberWithOptions(),
              controller: hari,
              placeholderStyle: const TextStyle(color: Colors.black38),
              placeholder: "Tinggi Pohon",
              suffix: const Padding(
                padding: EdgeInsets.only(right: 8),
                child: Icon(CupertinoIcons.person_crop_square,
                    color: Colors.black26),
              ),
            ),
            const SizedBox(height: 5),
            CupertinoTextField(
              controller: tinggi,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: false,
              ),
              placeholderStyle: const TextStyle(color: Colors.black38),
              placeholder: "Hari ke",
              suffix: const Padding(
                padding: EdgeInsets.only(right: 8),
                child: Icon(CupertinoIcons.news, color: Colors.black26),
              ),
            ),
            const SizedBox(height: 5),
          ],
        ),
        backgroundColor: Colors.grey.shade900,
        titleStyle:
            kDefaultTextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        title: "Tambah Manual",
        barrierDismissible: true,
        buttonColor: Colors.green,
        textConfirm: "Tambah",
        contentPadding: const EdgeInsets.all(10),
        onConfirm: () async {});
  }

  @override
  void initState() {
    tumbuhanController.getDataTumbuhan(
      id_tumbuhan: widget.id
    );
    super.initState();
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
            onTap: () => focusManager(),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.white.withOpacity(0.1),
                automaticallyImplyLeading: true,
                centerTitle: true,
                elevation: 0,
                actions: [
                  IconButton.filled(
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.green.shade300)
                      ),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AddingPerkembangan(
                          id: widget.id,
                        )));
                      }, 
                      icon: Row(
                      children: [
                        Icon(Icons.add, color: Colors.white,),
                        Text("Tambah", style: TextStyle(color: Colors.white),)],
                    )),
                  
                  Obx(
                    () => tumbuhanController.isLoading.value == true ? Container() : IconButton(onPressed: () async {
                      await tumbuhanController.getDataTumbuhan(
                        id_tumbuhan: widget.id
                      );
                    }, icon: Icon(CupertinoIcons.refresh)),
                  )
                ],
                title: Text(widget.title!),
              ),
              body: Obx(
                () => ListView.separated(
                  itemBuilder: (context, index) => ListTile(
                    leading: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(index == 0 ? widget.urlImage! : tumbuhanController.detailTumbuhan.value!.perkembangan[index].imgUrl!, fit: BoxFit.cover, width: 100,),
                      ),
                    title: Text(tumbuhanController.detailTumbuhan.value!.perkembangan[index].deskripsi ?? 'Tidak ada deskripsi', style: kDefaultTextStyle(fontSize: 14, color: Colors.black87), overflow: TextOverflow.ellipsis, maxLines: 2),
                    subtitle: Text("Tanggal : ${tumbuhanController.detailTumbuhan.value!.perkembangan[index].dateTime}"),
                    trailing: IconButton(
                      onPressed: () async {
                        if(index == 0){
                          Get.snackbar("Gagal", "Tidak dapat menghapus data perkembangan pertama", backgroundColor: Colors.red, colorText: Colors.white);
                        }else{
                          if(await tumbuhanController.hapusDetailTumbuhan(
                            idTumbuhan: tumbuhanController.detailTumbuhan.value?.perkembangan[index].id
                          ) == true){
                            setState(() {
                              tumbuhanController.getDataTumbuhan(
                                id_tumbuhan: widget.id
                              );
                            });
                          }
                        }
                    }, icon: Icon(CupertinoIcons.trash)),
                  ),
                  itemCount: tumbuhanController.detailTumbuhan.value?.perkembangan.length ?? 0, 
                  separatorBuilder: (context, index) => const SizedBox(height: 10),
                  ),
              )
            ),
          ),
        ),
        Obx(() => tumbuhanController.isLoading.value == true
            ? floatingLoading()
            : const SizedBox()),
      ],
    );
  }
}
