import 'package:flutter/material.dart';
import 'package:latihan_kuis/model/makanan.dart';
import 'package:latihan_kuis/pages/about.dart';
import 'package:latihan_kuis/pages/detail_makanan.dart';

class MainPage extends StatefulWidget {
  final String username;

  const MainPage({
    super.key,
    required this.username,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  List<Makanan> items = [];

  void reloadData() {
    items = Makanan.getMakananList();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double tinggi100 = MediaQuery.of(context).size.height;
    double lebar100 = MediaQuery.of(context).size.width;
    reloadData();
    return Scaffold(
      appBar: AppBar(
        title: Text('FoodApp'),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        height: tinggi100,
        width: lebar100,
        decoration: BoxDecoration(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          // child: Text("okokokok"),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Selamat datang ${widget.username}",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87,
                      ), // Alt Shft F
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      "Silakan lihat-lihat menu kami di bawah ini!",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        color: Colors.black54,
                      ), // Alt Shft F
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () => (
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AboutPage(),
                          ),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      ),
                      child: Text('About Us',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          )),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: items.length,
                  separatorBuilder: (_, __) => SizedBox(
                    height: 10,
                  ),
                  itemBuilder: (context, int index) {
                    return CardMakanan(item: items[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.shopping_cart), label: 'Keranjang'),
      //     BottomNavigationBarItem(icon: Icon(Icons.receipt), label: 'Order'),
      //   ],
      //   currentIndex: _selectedIndex,
      //   onTap: _onItemTapped,
      // ),
    );
  }
}

class CardMakanan extends StatelessWidget {
  const CardMakanan({
    super.key,
    required this.item,
  });

  final Makanan item;

  @override
  Widget build(BuildContext context) {
    double tinggi100 = MediaQuery.of(context).size.height;
    double lebar100 = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailMakanan(makanan: item),
          ),
        )
      },
      child: SizedBox(
        height: 300,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            // kolom ke bawah gambar dan tulisan
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  child: Image.asset(
                    item.imgPath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 20, right: 20, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 220 ,
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        item.nama,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87,
                        ), // Alt Shft F
                        textAlign: TextAlign.start,
                      ),
                    ),
                    SizedBox(
                      width: 100 ,
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        "Rp${item.harga}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromARGB(255, 28, 125, 216),
                        ), // Alt Shft F
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
