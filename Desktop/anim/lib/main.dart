import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
     appBar: AppBar(
       title: Text(
         'Precautions',
         style: TextStyle(
           backgroundColor: Colors.orange,
           color: Colors.white,
           fontWeight: FontWeight.bold,
           fontSize: 15.0,
         ),),
     ),
     body: Stack(
       fit: StackFit.expand,
       children: [
         Padding(
           padding: const EdgeInsets.all(20.0),
           child: Column(
             children: <Widget>[
               Mycards(),
             ],
           ), 
         )
       ],
     ),
    );
  }
}



//building of the card
class Mycards extends StatefulWidget {
  @override
  _MycardsState createState() => _MycardsState();
}

class _MycardsState extends State<Mycards> with SingleTickerProviderStateMixin {

  var cards=[
    couponcard(index:0,img:'assets/img1.jpeg',title: "Clean your hands often. Use soap and water, or an alcohol-based hand rub.",color1: Colors.orange[100],color2:Colors.blue[100]),
    couponcard(index:1,img:'assets/img3.jpg',title: "Maintain a safe distance from anyone who is coughing or sneezing.",color1: Colors.orange[200],color2:Colors.blue[200]),
    couponcard(index:2,img:'assets/img4.jpg',title: "Don’t touch your eyes, nose or mouth.",color1: Colors.orange[300],color2:Colors.blue[300]),
    couponcard(index:3,img:'assets/img5.jpg',title: "Cover your nose and mouth with your bent elbow or a tissue when you cough or sneeze.",color1: Colors.orange[400],color2:Colors.blue[400]),
    couponcard(index:4,img:'assets/img6.jpg',title: "Stay home if you feel unwell.",color1: Colors.orange[500],color2:Colors.blue[500]),
    couponcard(index:5,img:'assets/img7.jpg',title: "If you have a fever, a cough, and difficulty breathing, seek medical attention. Call in advance.",color1: Colors.orange[600],color2:Colors.blue[600]),
    couponcard(index:6,img:'assets/img2.jpg',title: "Follow the directions of your local health authority.",color1: Colors.orange[700],color2:Colors.blue[700]),
  ];

int currentIndex;
AnimationController controller;
CurvedAnimation curvedanim;
Animation<Offset> anim;

@override
void initState() {
    // TODO: implement initState
    super.initState();
    currentIndex=0;
    controller=AnimationController(
      vsync:this,
      duration: Duration(milliseconds:150)
      );
      curvedanim=CurvedAnimation(parent: controller, curve: Curves.easeOut);
      anim=Tween(begin: Offset(0.0,0.05),end: Offset(0.0, 0.0)).animate(curvedanim);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: cards.reversed.map((card){
        if(cards.indexOf(card)<=6){
          return GestureDetector(
            onHorizontalDragEnd: coupondrag,
            child:FractionalTranslation(
              translation: stackCard((card)),
              child: card,
            ),

          );
        }
        else{
          return Container();
        }
      }).toList(),
    );
  }


Offset stackCard (couponcard card){
  int diff = card.index-currentIndex;
  if(card.index==currentIndex-1){
    return anim.value;
  }
  else if(diff>0 && diff<=6){
    return Offset(0.0,0.05*diff);
  }
  else{
    return Offset(0.0, 0.0);
  }
}


void coupondrag(DragEndDetails details){
  controller.reverse().whenComplete((){
    setState(() {
      controller.reset();
      couponcard removecard=cards.removeAt(0);
      cards.add(removecard);
      currentIndex=cards[0].index;
    });
  });
}



}


//layout of the crd
class couponcard extends StatelessWidget {
  final int index;
  final String title,img;
  final Color color1,color2;


  couponcard({this.index,this.img,this.title,this.color1,this.color2});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius:  BorderRadius.all(Radius.circular(50.0)),
      child: Container(
        height: 500,
        width: 500,
        decoration: BoxDecoration(
          gradient: new LinearGradient(
            colors:[color1,color2], 
            begin: Alignment.centerRight,
            end: new Alignment(-1.0, -1.0)

            ),
          
        ),
        child: Column(
            children: <Widget>[
            //SizedBox(height:20.0),
            FittedBox(
            child: Container(
                height: 200,
                width: 200,
                  child: Image(
                    fit: BoxFit.contain,
                    image: AssetImage(img),
                    alignment: Alignment.center,
                  ),
                ),
            ),
            //SizedBox(height:50.0),
            Container(
              height: 150,
              width: 150,
              child: Text(title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize:15.0
              ),),
            ),



            ],),
        
      ),
    );
  }
}