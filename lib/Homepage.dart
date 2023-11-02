import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class homePage extends StatefulWidget {
  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  final List<String> options = ['Business', ' Wall Street Journal', 'Tech Crunch', 'Tesla'];
  String dropdownValue = 'Business';
  var jasonList = [];
  @override
  void initState() {
    super.initState();
    getData();
  }
  void getData() async {
    try {
      var response = await Dio().get('https://newsapi.org/v2/top-headlines',queryParameters: {'country':'us','category':'business','apikey':'fce0e55e69504881ac35129f43218788'});
      if (response.statusCode == 200) {
      setState(() {
        jasonList = response.data["articles"] as List;
      });  // Handle the successful response here
      } else {
        // Handle other status codes here
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        leading: Icon(
          Icons.newspaper,
          color: Colors.red[600],
          size: 30,
        ),
        title: Text(
          "News App",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(13.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Container(
                    height: 48,
                    child: TextField(
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          labelText: "Search",
                          labelStyle:
                              TextStyle(color: Colors.grey[700], fontSize: 18)),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                if (jasonList.isNotEmpty) ListView.separated(
                    scrollDirection: Axis.vertical,
                    separatorBuilder: (context,index){
                      return SizedBox(height: 10,);
                    },
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: jasonList.length,
                    itemBuilder: (context,index){
                  return  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(jasonList[index]["urlToImage"]== null ? "https://as1.ftcdn.net/v2/jpg/00/44/52/96/1000_F_44529670_qw4OH0dlBAsZaLyOMuvrV1Ng8s31kGGR.jpg" :jasonList[index]["urlToImage"]),
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          jasonList[index]["title"] ,
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
                              style: TextStyle(fontSize: 15,color: Colors.red[600],fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Author: ", style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold)),
                            Expanded(child: Text(jasonList[index]["author"]==null ? "Unkown" : jasonList[index]["author"] ,style: TextStyle(fontSize: 15,color: Colors.red[600],fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,))
                          ],
                        )
                      ],
                    ),
                  );
                }) else Center(
                  child: CircularProgressIndicator(color: Colors.black),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
