import 'package:flutter/material.dart';
import 'package:gymhome/models/gyms.dart';
import 'package:gymhome/provider/gymsitems.dart';
import 'package:provider/provider.dart';

class OwnerDescrption extends StatefulWidget {
  const OwnerDescrption({ Key? key }) : super(key: key);
  static const routeName = '/gsssym';

  @override
  _GymDescrptionState createState() => _GymDescrptionState();
}

class _GymDescrptionState extends State<OwnerDescrption> {
  @override
  Widget build(BuildContext context) {
     final productid = ModalRoute.of(context)!.settings.arguments as String;
    final lodedproductr = Provider.of<Gymsitems>(context).FindbyId(productid);
          final Gym = Provider.of<Gyms>(context);
    
    return Scaffold(
  //     appBar: AppBar( iconTheme: IconThemeData(
  //   color: Colors.black, //change your color here
  // ),backgroundColor: Colors.white,elevation: 0, ),
      body: SingleChildScrollView(
        child: Column(children: [Container( width: 420, height: 200,  child: Image.network(lodedproductr.imageUrl,fit: BoxFit.cover,)) ,
        
        Row(
          children: [
            Container( margin: EdgeInsets.symmetric(horizontal: 10), child: Text(Gym.title, style: TextStyle(color: Colors.black),)),
              SizedBox(width: 170,),
              Column(
                children: [
                  Row(
                    children: [
                      // Text('4.5', style: TextStyle(fontWeight: FontWeight.bold)),
                      //   SizedBox(width: 8,),
                      // Icon(Icons.star) ,
                    ],
                  ),
                  //  Text('Based on 320 Reviews'),
                  //     SizedBox(height: 10,),
                   
                       
                ],
              ),
                    
                     
          ],
        ),
        Column(
          children: [
            Row( 
                           mainAxisAlignment: MainAxisAlignment.start,
                           children: [
                             Container( margin: EdgeInsets.symmetric(horizontal: 10), child: Text('',style: TextStyle(fontWeight: FontWeight.bold))),
                               SizedBox(width: 0,),
                          //  Icon(Icons.directions_walk) 
                           ],
                         ),
           Container(
             margin: EdgeInsets.symmetric(horizontal: 10),
             child: Row(
               children: [
                //  Text('Choose sup type'),
               ],
             ),
           ), SizedBox(height: 7,),],
        ),SizedBox(height: 5,)  ,Container(margin: EdgeInsets.symmetric(horizontal: 10),
              child: Row(mainAxisAlignment: MainAxisAlignment.end,
              
                children: [
                  Text(lodedproductr.price.toString()), Text('SAR' , style: TextStyle(fontWeight: FontWeight.bold),)
                ],
              ),
            ) , Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Row(children: [Text('Descrption')],), 
                  Row(
                    children: [
                      Text(Gym.description),SizedBox(width: 5,),
                      Text('_________________________________________________')
                    ],
                  ),
                ],
              ),
            ), 
            SizedBox(height: 10,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
             
              child: Row(
                children: [
                  Text(lodedproductr.description),
      
                ],
              ),
            ),SizedBox(height: 10,), Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Text('Facilites'),SizedBox(width: 5,),
                  Text('_________________________________________________')
                ],
              ),
            ),
            SizedBox(height:10),
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  Container(
                                    width: 60,
                                    height: 25,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10) , color: Colors.blue),
                                    child: FlatButton( 
                                    
                                      child: Text('Pool',style: TextStyle(color: Colors.blue , fontSize: 13),),  
                                      color: Colors.white,  
                                      onPressed: () {/** */},  
                                      shape: RoundedRectangleBorder(side: BorderSide(
              color: Colors.blue,
              width: 1,
              style: BorderStyle.solid
            ),
                                    ),
                                  ), 
                                 
                                   ), 
                                   SizedBox(width: 8,),Container(
                                    width: 73,
                                    height: 25,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10) , color: Colors.blue),
                                    child: FlatButton( 
                                    
                                      child: Text('Sauna',style: TextStyle(color: Colors.blue, fontSize: 13),),  
                                      color: Colors.white,  
                                      onPressed: () {/** */},  
                                      shape: RoundedRectangleBorder(side: BorderSide(
              color: Colors.blue,
              width: 1,
              style: BorderStyle.solid
            ),
                                    ),
                                  ), 
                                 
                                   ),SizedBox(width: 8,), Container(
                                    width: 76,
                                    height: 25,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10) , color: Colors.blue),
                                    child: FlatButton( 
                                    
                                      child: Text('Rowing',style: TextStyle(color: Colors.blue, fontSize: 13),),  
                                      color: Colors.white,  
                                      onPressed: () {/** */},  
                                      shape: RoundedRectangleBorder(side: BorderSide(
              color: Colors.blue,
              width: 1,
              style: BorderStyle.solid
            ),
                                    ),
                                  ), 
                                 
                                   ),SizedBox(width: 8,), Container(
                                    width: 76,
                                    height: 25,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10) , color: Colors.blue),
                                    child: FlatButton( 
                                    
                                      child: Text('Squach',style: TextStyle(color: Colors.blue, fontSize: 13),),  
                                      color: Colors.white,  
                                      onPressed: () {/** */},  
                                      shape: RoundedRectangleBorder(side: BorderSide(
              color: Colors.blue,
              width: 1,
              style: BorderStyle.solid
            ),
                                    ),
                                  ), 
                                 
                                   ),SizedBox(width: 8,), Container(
                                    width: 73,
                                    height: 25,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10) , color: Colors.blue),
                                    child: FlatButton( 
                                    
                                      child: Text('Lokers',style: TextStyle(color: Colors.blue, fontSize: 13),),  
                                      color: Colors.white,  
                                      onPressed: () {/** */},  
                                      shape: RoundedRectangleBorder(side: BorderSide(
              color: Colors.blue,
              width: 1,
              style: BorderStyle.solid
            ),
                                    ),
                                  ), 
                                 
                                   ) ],
                              ),
                            ),
                        SizedBox(width: 8, height: 10,), Row(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 8),
                                        width: 150,
                                        height: 25,
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10) , color: Colors.blue),
                                        child: FlatButton( 
                                        
                                          child: Text('Indoor Runing Track',style: TextStyle(color: Colors.blue, fontSize: 13),),  
                                          color: Colors.white,  
                                          onPressed: () {/** */},  
                                          shape: RoundedRectangleBorder(side: BorderSide(
              color: Colors.blue,
              width: 1,
              style: BorderStyle.solid
            ),
                                        ),
                                      ), 
                                     
                                       ),
                                        Container(
                              margin: EdgeInsets.symmetric(horizontal: 8),
                                        width: 66,
                                        height: 25,
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10) , color: Colors.blue),
                                        child: FlatButton( 
                                        
                                          child: Text('Khijh',style: TextStyle(color: Colors.blue, fontSize: 13),),  
                                          color: Colors.white,  
                                          onPressed: () {/** */},  
                                          shape: RoundedRectangleBorder(side: BorderSide(
              color: Colors.blue,
              width: 1,
              style: BorderStyle.solid
            ),
                                        ),
                                      ), 
                                     
                                       ),
                                        Container(
                              margin: EdgeInsets.symmetric(horizontal: 8),
                                        width: 100,
                                        height: 25,
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10) , color: Colors.blue),
                                        child: FlatButton( 
                                        
                                          child: Text('Steam Bath',style: TextStyle(color: Colors.blue, fontSize: 13),),  
                                          color: Colors.white,  
                                          onPressed: () {/** */},  
                                          shape: RoundedRectangleBorder(side: BorderSide(
              color: Colors.blue,
              width: 1,
              style: BorderStyle.solid
            ),
                                        ),
                                      ), 
                                     
                                       ),
                          ],
                        ),  ],
                        ),  
                     SizedBox(height: 10,) , Container(
                         margin: EdgeInsets.symmetric(horizontal: 10),
                         child: Row(
                           children: [
                             Text('Photos'),
                           ],
                         ),
                       ), Image.network(''), SizedBox(height: 10,)
                       ,
                       Divider(color: Colors.black,)

                         , Container(
                           margin: EdgeInsets.symmetric(horizontal: 10),
                           child: Row(
                             children: [
                              //  Text('Comments'),
                             ],
                           ),
                         ) ,  ],
                       ),
      ),
    //       bottomNavigationBar: Container(
    //      width: 200,
    //      child: BottomNavigationBar(
    //       //  fixedColor: Colors.black,
    //       unselectedItemColor: Colors.grey,
    //       items: const <BottomNavigationBarItem>[
           
    //         BottomNavigationBarItem(
    //           icon: Icon(Icons.add),
    //           label: '',
    //         ),
    //          BottomNavigationBarItem(
    //           icon: Icon(Icons.add),
    //           label: '',
    //         ),
         
    //         //  BottomNavigationBarItem(
    //         //   icon: Icon(Icons.school),
    //         //   label: 'School',
    //         // ),
    //         //  BottomNavigationBarItem(
    //         //   icon: Icon(Icons.school),
    //         //   label: 'School',
    //         // ),
    //       ],
      
    // ),)
          
      
    );
  }
}
//  Row(children: [
//             Container(
              
//               margin: EdgeInsets.symmetric(horizontal: 10 , vertical: 10),
//               decoration: 
            
            
            
//             BoxDecoration(borderRadius: BorderRadius.horizontal(),color: Colors.white, ),child: Row(
//               children: [
//                 Container(
//                                     width: 66,
//                                     height: 25,
//                                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(10) , color: Colors.blue),
//                                     child: FlatButton( 
                                    
//                                       child: Text('Day',style: TextStyle(color: Colors.blue , fontSize: 13),),  
//                                       color: Colors.white,  
//                                       onPressed: () {/** */},  
//                                       shape: RoundedRectangleBorder(side: BorderSide(
//               color: Colors.grey,
//               width: 1,
//               style: BorderStyle.solid
//             ),
//                                     ),
//                                   ), 
                                 
//                                    ),  Container(
//                                     width: 73,
//                                     height: 25,
//                                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(10) , color: Colors.blue),
//                                     child: FlatButton( 
                                    
//                                       child: Text('Month',style: TextStyle(color: Colors.blue , fontSize: 13),),  
//                                       color: Colors.white,  
//                                       onPressed: () {/** */},  
//                                       shape: RoundedRectangleBorder(side: BorderSide(
//               color: Colors.grey,
//               width: 1,
//               style: BorderStyle.solid
//             ),
//                                     ),
//                                   ), 
                                 
//                                    ),  Container(
//                                     width:88,
//                                     height: 25,
//                                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(10) , color: Colors.blue),
//                                     child: FlatButton( 
                                    
//                                       child: Text('3 Months',style: TextStyle(color: Colors.blue , fontSize: 13),),  
//                                       color: Colors.white,  
//                                       onPressed: () {/** */},  
//                                       shape: RoundedRectangleBorder(side: BorderSide(
//               color: Colors.grey,
//               width: 1,
//               style: BorderStyle.solid
//             ),
//                                     ),
//                                   ), 
                                 
//                                    ),  Container(
//                                     width: 92,
//                                     height: 25,
//                                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(10) , color: Colors.blue),
//                                     child: FlatButton( 
                                    
//                                       child: Text(' 6 Months',style: TextStyle(color: Colors.blue , fontSize: 13),),  
//                                       color: Colors.white,  
//                                       onPressed: () {/** */},  
//                                       shape: RoundedRectangleBorder(side: BorderSide(
//               color: Colors.grey,
//               width: 1,
//               style: BorderStyle.solid
//             ),
//                                     ),
//                                   ), 
                                 
//                                    ),  Container(
//                                     width: 68,
//                                     height: 25,
//                                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(10) , color: Colors.blue),
//                                     child: FlatButton( 
                                    
//                                       child: Text('Year',style: TextStyle(color: Colors.blue , fontSize: 13),),  
//                                       color: Colors.white,  
//                                       onPressed: () {/** */},  
//                                       shape: RoundedRectangleBorder(side: BorderSide(
//               color: Colors.grey,
//               width: 1,
//               style: BorderStyle.solid
//             ),
//                                     ),
//                                   ), 
                                 
//                                    ), 
//               ],
//             ),)],)