import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class news extends StatefulWidget{
  @override
  State<news> createState() => _newsState();
}

class _newsState extends State<news> {
  var jasonList = [];
  final List<String> options = ['Business', 'Wall Street Journal', 'Apple News', 'Tesla'];
  String dropdownValue = 'Business';
  @override
  void initState() {
    super.initState();
    getData();
  }
  void getData() async {
    var response;
    try {
      if(dropdownValue == "Business") {
         response = await Dio().get('https://newsapi.org/v2/top-headlines',
            queryParameters: {
              'country': 'us',
              'category': 'business',
              'apikey': 'fce0e55e69504881ac35129f43218788'
            });
      }
      if(dropdownValue == "Wall Street Journal")
        {
           response = await Dio().get('https://newsapi.org/v2/everything',
              queryParameters: {
                'domains': 'wsj.com',
                'apikey': 'fce0e55e69504881ac35129f43218788'
              });
        }
      if(dropdownValue == "Apple News")
      {
         response = await Dio().get('https://newsapi.org/v2/top-headlines',
            queryParameters: {
              'q': 'apple',
              'from': '2023-10-30',
              'to':'2023-10-30',
              'sortBy': 'popularity',
              'apikey':'fce0e55e69504881ac35129f43218788'
            });
      }
      if(dropdownValue == "Tesla")
      {
         response = await Dio().get('https://newsapi.org/v2/everything',
            queryParameters: {
              'q': 'tesla',
              'from': '2023-10-01',
              'sortBy': 'publishedAt',
              'apikey':'fce0e55e69504881ac35129f43218788'
            });
      }
      if (response.statusCode == 200) {
        setState(() {
          jasonList = response.data["articles"] as List;
        });
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
return Scaffold(
  appBar: AppBar(
    backgroundColor: Colors.white,
    title: Text("All News",style: TextStyle(
      color: Colors.black,
      fontSize: 20
    ),),
    elevation: 1,
    actions: [
      DropdownButton<String>(
        value: dropdownValue,
        icon:Icon(Icons.menu),
        onChanged: (String? newValue) {
          setState(() {
            if (newValue != null) {
              dropdownValue = newValue;
              getData();
            }
          });
        },
        items: options.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Row(
              children: [
                Text(value,style: TextStyle(fontSize: 17,color: Colors.black),),
                SizedBox(width: 10,),
              ],
            ),
          );
        }).toList(),
      ),
      SizedBox(
        width: 25,
      ),
    ],
  ),
  body: Padding(
    padding: const EdgeInsets.all(10.0),
    child: jasonList.isNotEmpty ? ListView.separated(
        scrollDirection: Axis.vertical,
        separatorBuilder: (context,index){
          return SizedBox(height: 10,);
        },
       // physics: NeverScrollableScrollPhysics(),
        //shrinkWrap: true,
        itemCount: jasonList.length,
        itemBuilder: (context,index){
          return  Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // height: 230,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(jasonList[index]["urlToImage"]== null ? "https://st.depositphotos.com/1011646/1255/i/450/depositphotos_12553000-stock-photo-breaking-news-screen.jpg" :jasonList[index]["urlToImage"]),
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  jasonList[index]["title"] == null ? "Unkown" : jasonList[index]["title"],
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
                     jasonList[index]["source"]['name'] ==null ? "Unkown" : jasonList[index]["source"]['name'],
                     style: TextStyle(fontSize: 15,color: Colors.red[600],fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,
                   ),
                 ],
               ),
              Row(
                children: [
                  Text("Author: ", style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                  Expanded(child: Text(jasonList[index]["author"]==null ? "Unkown" : jasonList[index]["author"] ,style: TextStyle(fontSize: 15,color: Colors.red[600],fontWeight: FontWeight.bold),overflow:TextOverflow.ellipsis ,))
                ],
              )
              ],
            ),
          );
        }): Center(
      child: CircularProgressIndicator(color: Colors.black),),
  ),
);
  }
}