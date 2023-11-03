import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class News_Details extends StatelessWidget {
  final Map<String, dynamic> product;
String Category;
int num;
  News_Details({required this.product,required this.Category,required this.num});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: <Widget>[
                SizedBox(
                  height: 300,
                  child: ClipRRect(
                    child: Image.network(product["urlToImage"] == null
                        ? "https://st.depositphotos.com/1011646/1255/i/450/depositphotos_12553000-stock-photo-breaking-news-screen.jpg"
                        : product["urlToImage"],
                    fit: BoxFit.fitHeight,),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
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
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            this.Category,
                            style: TextStyle(
                              color: Colors.white
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 7,),
                     if (this.num <10) Container(
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(Icons.thumb_up,
                              color: Colors.white,
                              size: 15,),
                              SizedBox(width: 2,),
                              Text(
                               "Top 10",
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),
                            ],
                          ),
                        ),
                      ) else Container() ,
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10,right: 20,left: 20,bottom: 10),
              child: Text(product["title"],style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900
              ),),
            )
          ],
        ),
      ),
    );
  }
}
