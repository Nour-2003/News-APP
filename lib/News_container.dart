import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class News_widget extends StatelessWidget{

  final Map<String, dynamic> product;
  News_widget({required this.product});
  @override
  Widget build(BuildContext context) {
return Container(
  width: MediaQuery.of(context).size.width,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        // height: 230,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.network( product["urlToImage"]== null ? "https://st.depositphotos.com/1011646/1255/i/450/depositphotos_12553000-stock-photo-breaking-news-screen.jpg" : product["urlToImage"]),
        ),
      ),
      SizedBox(
        height: 3,
      ),
      Text(
        product["title"] == null ? "Unkown" : product["title"],
        style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 7),
      Row(
        children: [
          Text("Source: ", style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
          Text(
            product["source"]['name']==null ? "Unkown" : product["source"]['name'],
            style: TextStyle(fontSize: 15,color: Colors.red[600],fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      Row(
        children: [
          Text("Author: ", style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
          Expanded(child: Text(product["author"]==null ? "Unkown" : product["author"] ,style: TextStyle(fontSize: 15,color: Colors.red[600],fontWeight: FontWeight.bold),overflow:TextOverflow.ellipsis ,))
        ],
      )
    ],
  ),
);
  }

}