import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:newsapiexample/details_pages.dart';
import 'package:newsapiexample/models/newaclass.dart';

import 'package:newsapiexample/news_card.dart';
import 'category_list.dart';
import 'http_service.dart';

class CategoryPage extends StatefulWidget {
     final int index;


  const CategoryPage( {super.key, required this.index});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
   late HttpService http;

  NewsClass? newsCategory;

  bool isLoading = false;

  Future<void> categorydata() async{

    setState(() {
      isLoading=true;
    });



    try {
     
      
      Response response1 = await http.getRequest(
          "v2/top-headlines?category=${categoryList[widget.index]['title']}&apiKey=c91805b7f84e423bbb5f06a0f1320ff1");

      if (response1.statusCode == 200) {
        setState(() {
          newsCategory = NewsClass.fromJson(response1.data);
           
          isLoading = false;
        });
      }
    } catch (e) {
      log("error");
      setState(() {
        isLoading = false;
      });
    }
  

    
  }

  
  @override
  void initState() {
    super.initState();
    http = HttpService();
    categorydata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Flutter",
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            Text(
              "News",
              style: TextStyle(
                color: Color.fromARGB(255, 71, 168, 233),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: isLoading
  ? const Center(child: CircularProgressIndicator())
  : newsCategory != null && newsCategory!.articles != null && newsCategory!.articles!.isNotEmpty
    ? ListView.builder(
        itemCount: newsCategory!.articles!.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsCard(article: newsCategory!.articles![index]),
                ),
              );
            },
            child: NewsCard(article: newsCategory!.articles![index]),
          );
        },
      )
    : const Center(
        child: Text('No news available'),
      ),

    );
  }
}