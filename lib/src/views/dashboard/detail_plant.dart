import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_growth/src/components/textstyle.dart';
import 'package:plant_growth/src/helpers/focus.dart';

class PageDetail extends StatefulWidget {
  final String? title;
  final String? urlImage;
  const PageDetail({super.key, this.title, this.urlImage});

  @override
  State<PageDetail> createState() => _PageDetailState();
}

class _PageDetailState extends State<PageDetail> {
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
                title: Text(widget.title ?? 'Bunga'),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 3,
                          color: Colors.transparent,
                          child: Stack(
                            children: [
                              Center(
                                  child: Image.asset(
                                widget.urlImage!,
                                width: 280,
                              ))
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: Text(
                        """Bonsai (盆栽) adalah tanaman atau pohon yang dikerdilkan di dalam pot dangkal dengan tujuan membuat miniatur dari bentuk asli pohon besar yang sudah tua di alam bebas. Penanaman (sai, 栽) dilakukan di pot dangkal yang disebut bon (盆). Istilah bonsai juga dipakai untuk seni tradisional Jepang dalam pemeliharaan tanaman atau pohon dalam pot dangkal, dan apresiasi keindahan bentuk dahan, daun, batang, dan akar pohon, serta pot dangkal yang menjadi wadah, atau keseluruhan bentuk tanaman atau pohon. Bonsai adalah pelafalan bahasa Jepang untuk penzai (盆栽).
                    
                    Seni ini mencakup berbagai teknik pemotongan dan pemangkasan tanaman, pengawatan (pembentukan cabang dan dahan pohon dengan melilitkan kawat atau membengkokkannya dengan ikatan kawat), serta membuat akar menyebar di atas batu. Pembuatan bonsai memakan waktu yang lama dan melibatkan berbagai macam pekerjaan, antara lain pemberian pupuk, pemangkasan, pembentukan tanaman, penyiraman, dan penggantian pot dan tanah. Tanaman atau pohon dikerdilkan dengan cara memotong akar dan rantingnya. Pohon dibentuk dengan bantuan kawat pada ranting dan tunasnya. Kawat harus sudah diambil sebelum sempat menggores kulit ranting pohon tersebut. Tanaman adalah makhluk hidup, dan tidak ada bonsai yang dapat dikatakan selesai atau sudah jadi. Perubahan yang terjadi terus menerus pada tanaman sesuai musim atau keadaan alam merupakan salah satu daya tarik bonsai. 
                    """,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                        onPressed: () {
                          popUpAddData();
                        },
                        icon: Icon(Icons.add, color: Colors.white),
                        label: Text(
                          "Tambah Data",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
