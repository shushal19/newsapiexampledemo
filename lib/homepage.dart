import 'dart:developer';

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
  NewsClass? news,newsall;
  

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
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _buildContainer("Business", "https://t3.ftcdn.net/jpg/00/97/37/90/500_F_97379028_HD7Gp1cdemIJkYMmVeMqnCIkWUFNXYMf.jpg"),
                          _buildContainer("Education", "https://th.bing.com/th/id/R.73a10c8f26c5305c8e5b0dcb011ea635?rik=2G7aTi9DvqYjZA&pid=ImgRaw&r=0"),
                          _buildContainer("Technology", "https://th.bing.com/th/id/R.c59cb4d6dda0d97d72600fc66821bbcd?rik=p%2bqtqo2eNb0jtA&riu=http%3a%2f%2fthestatetimes.com%2fwp-content%2fuploads%2f2018%2f02%2finfotech.jpg&ehk=FF2w7obphoNFJAmHb0IyqQuqdiAVkB1haRtebXosqj8%3d&risl=&pid=ImgRaw&r=0"),
                          _buildContainer("Health", "https://justiceaction.org.au/wp-content/uploads/2020/09/iStock-639896942.jpg"),
                          _buildContainer("Science", "https://th.bing.com/th/id/R.f5b157c8033d028c69ff1a25f7d15133?rik=PaThKXiqrYYd5g&riu=http%3a%2f%2fthelibertarianrepublic.com%2fwp-content%2fuploads%2f2016%2f02%2fscience.jpg&ehk=fUOTF2D6E%2fQu6taI9nd58LHfbyA3naqv4va96Cv2mLg%3d&risl=&pid=ImgRaw&r=0"),
                        ],
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


  Widget _buildContainer(String title, String imageUrl) {
    
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