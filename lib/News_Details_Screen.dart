import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class News_Details extends StatelessWidget {
  final Map<String, dynamic> product;
  String Category;
  int num;

  News_Details(
      {required this.product, required this.Category, required this.num});

  late String Fullcontent = product['content'];

  void _launchURL() async {
    String url = product['url'];
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        child: Icon(
          Icons.favorite_border_outlined,
          color: Colors.white,
          size: 30,
        ),
        onPressed: () {},
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: <Widget>[
                  SizedBox(
                    height: 350,
                    width: MediaQuery.of(context).size.width,
                    child: ClipRRect(
                      child: Image.network(
                        product["urlToImage"] == null
                            ? "https://st.depositphotos.com/1011646/1255/i/450/depositphotos_12553000-stock-photo-breaking-news-screen.jpg"
                            : product["urlToImage"],
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(15)),
                        child: IconButton(
                          color: Colors.white,
                          icon: Icon(Icons.keyboard_backspace),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.purple,
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              this.Category,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        if (this.num < 10)
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.thumb_up,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    "Top 10",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          )
                        else
                          Container(),
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10, right: 20, left: 20, bottom: 10),
                child: Text(
                  product["title"],
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 20, bottom: 10),
                child: Row(
                  children: [
                    Text(
                      "Published At: ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                    ),
                    Text(
                      product["publishedAt"],
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                color: Colors.black, // Set the color of the divider
                thickness: 1.0, // Set the thickness of the divider
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10, right: 20, left: 20, bottom: 10),
                child: Text(
                  product['description'],
                  style: GoogleFonts.openSans(fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 230.0, left: 15),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Container(
                    height: 40,
                    child: Row(children: [
                      Text("Read More"),
                      SizedBox(
                        width: 13,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: VerticalDivider(
                          color: Colors.white,
                          thickness: 1.0,
                          width: 10,
                        ),
                      ),
                      Icon(Icons.keyboard_arrow_right, color: Colors.white),
                    ]),
                  ),
                  onPressed: () {
                    _launchURL();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
