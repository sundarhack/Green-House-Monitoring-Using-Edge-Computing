import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: <Widget>[
        Row(children: [SizedBox(width: 80,),Image.asset('assets/baiju.png',height: 220,width: 220,)],),
        SizedBox(height: 30,),
        Container(width: 300,child: Row(children: [SizedBox(width: 60,),Text("Name",style: TextStyle(color: Colors.white, fontSize: 24),),SizedBox(width: 20,),Text("Dr Baiju B V",style: TextStyle(color: Colors.white, fontSize: 24),)],),decoration: BoxDecoration(color:Colors.orange,
    border: Border.all(
      color: Colors.red[500],
    ),
    borderRadius: BorderRadius.all(Radius.circular(20))
  ),),
  SizedBox(height: 30,),
        Container(width: 300,child: Row(children: [SizedBox(width: 20,),Text("Land Area",style: TextStyle(color: Colors.white, fontSize: 24),),SizedBox(width: 20,),Text("10 Acre",style: TextStyle(color: Colors.white, fontSize: 24),)],),decoration: BoxDecoration(color:Colors.orange,
    border: Border.all(
      color: Colors.red[500],
    ),
    borderRadius: BorderRadius.all(Radius.circular(20))
  ),),
  SizedBox(height: 30,),
        Container(width: 300,child: Row(children: [SizedBox(width: 80,),Text("Crop",style: TextStyle(color: Colors.white, fontSize: 24),),SizedBox(width: 20,),Text("Paddy",style: TextStyle(color: Colors.white, fontSize: 24),)],),decoration: BoxDecoration(color:Colors.orange,
    border: Border.all(
      color: Colors.red[500],
    ),
    borderRadius: BorderRadius.all(Radius.circular(20))
  ),),
  SizedBox(height: 30,),
        Container(width: 300,child: Row(children: [SizedBox(width: 80,),Text("Soil",style: TextStyle(color: Colors.white, fontSize: 24),),SizedBox(width: 20,),Text("Clay Soil",style: TextStyle(color: Colors.white, fontSize: 24),)],),decoration: BoxDecoration(color:Colors.orange,
    border: Border.all(
      color: Colors.red[500],
    ),
    borderRadius: BorderRadius.all(Radius.circular(20))
  ),),

      ]),
    );
  }
}
