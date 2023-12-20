import 'dart:developer';
import 'category_list.dart';
import 'category_page.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:newsapiexample/details_pages.dart';
import 'package:newsapiexample/http_service.dart';

import 'package:newsapiexample/models/newaclass.dart';
import 'package:newsapiexample/news_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HttpService http;
  NewsClass? news;
  

  bool isLoading = false;

  Future<void> getNews() async {
    setState(() {
      isLoading = true;
    });

    try {
     
      
      Response response = await http.getRequest(
          "v2/everything?q=tesla&from=2023-12-04&sortBy=publishedAt&apiKey=c91805b7f84e423bbb5f06a0f1320ff1");

      if (response.statusCode == 200) {
        setState(() {
          news = NewsClass.fromJson(response.data);
           
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
    getNews();
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
          : news != null
              ? Column(
                  children: [
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                        itemCount: categoryList.length,
                         scrollDirection: Axis.horizontal,
                           itemBuilder: (context, index) {
                           return GestureDetector(
onTap: () {
  Navigator.push(context, MaterialPageRoute(builder: (context)=>
  CategoryPage( index: index,)));
},

                            child: _buildContainer(index),
                               );
                                 },
                        
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: ListView.builder(
                        itemCount: news!.articles!.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetailsCard(article: news!.articles![index]),
                                ),
                              );
                            },
                            child: NewsCard(article: news!.articles![index]),
                          );
                        },
                      ),
                    ),
                  ],
                )
              : const Center(
                  child: Text('No news available'),
                ),
    );
  }


  Widget _buildContainer(int index) {


    String title = categoryList[index]["title"]!;
    String imageUrl = categoryList[index]["imageURL"]!;


    
    return Container(
      margin: const EdgeInsets.all(8.0),
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            imageUrl,
            width: 70,
            height: 50,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 8.0),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );

     


  }
}