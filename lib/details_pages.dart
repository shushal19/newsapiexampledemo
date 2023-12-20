import 'package:flutter/material.dart';
import 'package:newsapiexample/models/newaclass.dart';


class DetailsCard extends StatelessWidget {
  final Articles article;

  const DetailsCard({super.key, required this.article});

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
        foregroundColor: Colors.black,
       
        
      ),
      body: Card(
        margin: const EdgeInsets.all(8.0),
        elevation: 0.0, // Add elevation for a shadow effect
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), // Rounded corners
        ),
        child: ClipRRect(
          borderRadius:
              BorderRadius.circular(8.0), // Clip content to rounded corners
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              article.urlToImage != null
                  ? Image.network(
                      article.urlToImage!,
                      height: 200, // Set image height
                      fit: BoxFit.cover, // Cover the available space
                    )
                  : const SizedBox(
                      height: 200,
                      child: Center(
                          child: Text('No Image'))), // Placeholder for no image
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.title ?? '',
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      article.description ?? '',
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
