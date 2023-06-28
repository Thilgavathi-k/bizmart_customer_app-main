import 'package:flutter/material.dart';
class ImageViewPage extends StatefulWidget {
  final String img;
  const ImageViewPage({Key key, this.img}) : super(key: key);

  @override
  State<ImageViewPage> createState() => _ImageViewPageState();
}

class _ImageViewPageState extends State<ImageViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Photo",style: TextStyle(color: Colors.blueAccent),),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: ()
          {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_rounded,color: Colors.black,),
        ),
      ),
      body: Container(
        height: 500,
        child:Center(child: Image.network(widget.img.toString())) ,
      ),

    );
  }
}
