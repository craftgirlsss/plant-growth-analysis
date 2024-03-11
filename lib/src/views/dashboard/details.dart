import 'package:flutter/material.dart';
import 'package:plant_growth/src/components/textstyle.dart';

class DetailTanamanHarian extends StatefulWidget {
  final String? title;
  final String? description;
  final String? diameter;
  final String? tinggi;
  final String? urlImage;
  final String? dateTime;
  const DetailTanamanHarian({super.key, this.title, this.description, this.diameter, this.tinggi, this.urlImage, this.dateTime});

  @override
  State<DetailTanamanHarian> createState() => _DetailTanamanHarianState();
}

class _DetailTanamanHarianState extends State<DetailTanamanHarian> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? ''),
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          Image.network(widget.urlImage ?? ''),
          const SizedBox(height: 10),
          Text("Deskripsi", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
          const SizedBox(height: 5),
          Text(widget.description ?? 'Tidak ada deskripsi', textAlign: TextAlign.justify),
          const SizedBox(height: 10),
          Row(
            children: [
              Text("Tanggal pendataan : ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
              Text("${widget.dateTime ?? 'Tidak ada deskripsi'}"),
            ],
          ),
          Row(
            children: [
              Text("Tinggi tanaman : ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
              Text("${widget.tinggi ?? 'Tidak ada deskripsi'} meter"),
            ],
          ),
          Row(
            children: [
              Text("Diameter tanaman : ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
              Text("${widget.diameter ?? 'Tidak ada deskripsi'} cm"),
            ],
          ),
        ],
      ),
    );
  }
}