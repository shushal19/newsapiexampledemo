import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
Response response =await http.getRequest("v2/everything?q=tesla&from=2023-11-04&sortBy=publishedAt&apiKey=c91805b7f84e423bbb5f06a0f1320ff1");
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
        title: const Center(child:  Text("NewsApi Demo")),
      ),

      body: isLoading?
       const Center(child: CircularProgressIndicator())
:
ListView.builder(itemBuilder: ((context,index){
List<Articles>? listOfNews=news!.articles;

return NewsCard(article: listOfNews![index]);


}))
      
    );
  }
}