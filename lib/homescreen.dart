import 'dart:convert';
import 'package:practice/Models/postsmodel.dart';
import'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import'package:http/http.dart' as http;
class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}
List<Postsmodel> postList=[];

Future<List<Postsmodel>> getPostApi()async{
  final response=await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
     var data=jsonDecode(response.body.toString());
      if(response.statusCode==200){
       for(Map i in data){
         postList.add(Postsmodel.fromJson(i));
       }
       return postList;
      }else{
        return postList;
      }
}
class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('Api_Work'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
            future: getPostApi(),
            builder: (context,snapshot){
             if (!snapshot.hasData) {
               return Text('Loading');
             }   else{
               return ListView.builder(
                   itemCount:postList.length,
                   itemBuilder: (context,index){
                 return Text(postList[index].title.toString());
               });
             }
            },
                    ),
          )
        ],
      ),
    );
  }
}
