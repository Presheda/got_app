import 'package:flutter/material.dart';
import 'package:gotapp/got.dart';

class EpisodesPage extends StatelessWidget {

 final List<Episodes> episodes;
 final MyImage myImage;


  EpisodesPage({this.episodes, this.myImage});

  Widget showSummary(BuildContext context, String summary){
    showDialog(context: context,
    builder: (context) => Center(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(summary),
          ),
        ),
      ),
    )
    );
  }

  Widget myBody(BuildContext context){
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
            childAspectRatio: 1.0
        ),
        itemCount: episodes.length,
        itemBuilder: (context, index) => InkWell(
          onTap: ()=> showSummary(context, episodes[index].summary),
          child: Card(
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Image.network(episodes[index].image.original,
                fit: BoxFit.cover,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        episodes[index].name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    )
                  ],
                ),
                Positioned(
                  left: 0.0,
                  top: 0.0,
                  child: Container(
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "${episodes[index].season} - ${episodes[index].number}",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Hero(
              tag: "g1",
              child: CircleAvatar(
                backgroundImage: NetworkImage(myImage.medium),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Text("All Episodes")
          ],
        ),
      ),

      body: myBody(context),
    );
  }
}
