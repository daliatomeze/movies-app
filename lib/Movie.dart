
import 'package:flutter/material.dart';
class MovieItem extends StatelessWidget{

  final String image;
  final String title;
  final String year;
  final String Type;

  MovieItem({required this.image,required this.title,required this.year,required this.Type});
  factory MovieItem.fromJson( Map<String ,dynamic> json) {
    return MovieItem(
     image: json["Poster"],
      title:json["Title"],
      year:json["Year"],
      Type:json["Type"],
    );}

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      height: 120,
      child: Card(
        child: Row(
          children: [
            Image.network(image),
            Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(20, 5, 5, 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: TextStyle(fontWeight: FontWeight.bold),),
                      Text(this.year.toString()),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Text(this.Type),
                      ),
                      Icon(Icons.add)

                    ],
                  ),
                )
            )
          ],
        ),
      ),
    );


  }

}