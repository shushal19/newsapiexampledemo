import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:newsapiexample/details_pages.dart';
import 'package:newsapiexample/http_service.dart';
import 'package:newsapiexample/models/newaclass.dart';
import 'package:newsapiexample/news_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

 late HttpService http;
  NewsClass? news;
  bool isLoading=false;

 Future getNews() async{
isLoading=true;
Response response =await http.getRequest("v2/everything?q=tesla&from=2023-12-04&sortBy=publishedAt&apiKey=c91805b7f84e423bbb5f06a0f1320ff1");
isLoading=false;

try {
  if(response.statusCode==200){
    setState(() {
    news=NewsClass.fromJson(response.data);
    });

  }
  
} 
catch (e) {
  log("error");
  
}


 }
 @override
  void initState() {
http=HttpService();
    getNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Flutter",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
            Text("News",style: TextStyle(color: Color.fromARGB(255, 71, 168, 233),fontWeight: FontWeight.bold),),
          ],

        ),
        backgroundColor: Colors.white,
        
       
        
      ),

      body: isLoading?
       const Center(child: CircularProgressIndicator())
:
ListView.builder(itemBuilder: ((context,index){
List<Articles>? listOfNews=news!.articles;

return GestureDetector(
  onTap: (){
   Navigator.push(context,MaterialPageRoute(builder: (context)=>
    DetailsCard(article: listOfNews[index])));
  },
  child: NewsCard(article: listOfNews![index]));


}))
      
    );
  }
}