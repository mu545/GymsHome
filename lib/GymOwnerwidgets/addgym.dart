// import 'package:flutter/material.dart';
// import 'package:gymhome/GymOwnerwidgets/gymprice.dart';
// import 'package:gymhome/GymOwnerwidgets/location.dart';
// import 'package:gymhome/models/gyms.dart';
// import 'package:gymhome/provider/gymsitems.dart';
// import 'package:provider/provider.dart';

// class AddGym extends StatefulWidget {
//   static const routenames='/ss';
//   const AddGym({ Key? key }) : super(key: key);

//   @override
//   _AddGymState createState() => _AddGymState();
// }

// class _AddGymState extends State<AddGym> {
//   final _priceNode = FocusNode();
//   final _desnode = FocusNode();
//   final _ImageCon = TextEditingController();
//   final _Imagefous = FocusNode();
//   final _form = GlobalKey<FormState>();
//   var _IsInt = true;
//   var _editfor =
//       Gyms(id: '' , title: '', price: 0, description: '', imageUrl: '' , location: '' , facilites: '' , hours: '');
//   var _Intva = {'title': '', 'price': '', 'descrption': '', 'ImageUrl': '' , 'location' : '' , 'facilites' : '' ,'hour':  ''};

//   @override
//   void intState() {
//     _Imagefous.addListener(_update);
//     super.initState();
//   }

//   bool _isLoading = false;

//   @override
//   // void didChangeDependencies() {
//   //   if (_IsInt) {
//   //     final productId = ModalRoute.of(context)!.settings.arguments as String;
    
//   //       _editfor =
//   //           Provider.of<Gymsitems>(context, listen: false).FindbyId(productId);
//   //       _Intva = {
//   //         'title': _editfor.title,
//   //         'price': _editfor.price.toString(),
//   //         'descrption': _editfor.description,
//   //         'ImageUrl': ''
//   //       };
//   //       _ImageCon.text = _editfor.imageUrl;
      
//   //   }
//   //   _IsInt = false;
//   //   super.didChangeDependencies();
//   // }

//   void dispose() {
//     _Imagefous.removeListener(_update);
//     _priceNode.dispose();
//     _desnode.dispose();
//     _ImageCon.dispose();
//     _Imagefous.dispose();
//     super.dispose();
//   }

//   void _update() {
//     if (!_Imagefous.hasFocus) setState(() {});
//   }

// //   void _Saved() {
// //     // final Validate = _form.currentState!.validate();
// //     // if (!Validate) {
// //     //   return;
// //     // }
// //     // _form.currentState!.save();
//     // Provider.of<Gymsitems>(context, listen: false).addpro(_editfor);
        
// // //  Navigator.of(context).pushNamed(Location.routenamed);
// //     // if(_editfor.id != null){

// //     //   Provider.of<Gymsitems>(context , listen: false).Update(_editfor.id, _editfor);



// //     // }
// //     // else{  Provider.of<Gymsitems>(context, listen: false).addpro(_editfor);}


// //   }
  
//   void _saveForm()  {
//     // final isValid = _form.currentState?.validate();

//     // if (isValid!) {
//     //   return;
//     // }
//     _form.currentState!.save();
//     Provider.of<Gymsitems>(context, listen: false).addProduct(_editfor).then((_) {});
//     // finally {
//     //     setState(() {
//     //       _isLoading = false;
//     //     });
//     //     Navigator.of(context).pop();
//     //   }
//     }
//     // setState(() {
//     //     _isLoading = false;
//     // });
//     // Navigator.of(context).pop();
//     // Navigator.of(context).pop();
  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//        appBar: AppBar(title: Center(child: Text('Add Gym ', style: TextStyle(color: Colors.black),)),backgroundColor: Colors.white, elevation: 0,actions: <Widget>[ IconButton(onPressed: (){}, icon: Icon(Icons.more_vert,color: Colors.black,),)], ),
   
//    body: SingleChildScrollView(
//      child: Column(
//        children: [
//          Container(  margin: EdgeInsets.symmetric(horizontal: 10 , vertical: 20), height: 450, width: 390 ,  child: Card(child: Column(children: [Row(children: [Container  ( margin: EdgeInsets.symmetric(horizontal: 20 , vertical: 10), child: Text('Gym Information', style: TextStyle(fontSize: 30, color: Colors.blue),))],), Container(
//           width: 250, height: 40, child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Expanded(
//                   child:  TextFormField(
//                       decoration: InputDecoration(labelText: 'Name'),
//                       initialValue: _Intva['title'],
//                       textInputAction: TextInputAction.next,
//                       onFieldSubmitted: (_) {
//                         FocusScope.of(context).requestFocus(_priceNode);
//                       },
//                       onSaved: (value) {
//                         _editfor = Gyms(
//                           title: value!,
//                           price: _editfor.price,
//                           description: _editfor.description,
//                           imageUrl: _editfor.imageUrl,
//                           id: _editfor.id,
//                           location: _editfor.location , 
//                           facilites: _editfor.facilites , 
//                           hours: _editfor.hours
//                         );
//                       },
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'Please enter a valied name';
//                         }
//                         return null;
//                       },
//                     ),
//                 ),
//               ],
//             ),
//          ),
//           SizedBox(height: 10,),
//          SingleChildScrollView(
           
//            child: Container(
//              height: 150,width: 300,
//              child: Row( 
               
//                children: [
//                  Expanded(
//                    child: Column(
//                      children: [
//                        Expanded(
                        
//                          child: Container(
//                            height: 300,
//                            child:  TextFormField(
//                             decoration: InputDecoration(labelText: 'Descrabtion'),
//                             initialValue: _Intva['descrption'],
//                             maxLines: 3,
//                             keyboardType: TextInputType.multiline,
//                             focusNode: _desnode,
//                             onSaved: (value) {
//                               _editfor = Gyms(
//                                 title: _editfor.title,
//                                 price: _editfor.price,
//                                 description: value!,
//                                 imageUrl: _editfor.imageUrl,
//                                 id: _editfor.id,
//                                     location: _editfor.location , 
//                           facilites: _editfor.facilites , 
//                           hours: _editfor.hours
//                               );
//                             },
//                             validator: (value) {
//                               if (value!.isEmpty) {
//                                 return 'Please enter a valied descraption';
//                               }
//                               return null;
//                             },
//                           ),
//                          ),
                         
//                        ),
//                         ],
//                    ),
//                  ),
                
//                ],
//              ),
             
//            ),
//          ), 
//          SizedBox(height: 10,),
//           Container(
//            width: 250,height: 40,
//            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.blue),
//            child: FlatButton(
//                           child: Text(
//                               'Next', style: TextStyle(color: Colors.white),),
//                           onPressed: _saveForm ,
//                           padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
//                           materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                           textColor: Theme.of(context).primaryColor,
//                         ),
//          ),
//          SizedBox(height: 10,)
//    ,   
//          Container(
//            width: 250,height: 40,
//            decoration: BoxDecoration(   borderRadius: BorderRadius.circular(20), color: Colors.white),
//            child: FlatButton(
             
//                           child: Text(
//                               'Cancel', style: TextStyle(color: Colors.blue),),
//                           onPressed: (){ },
//                           padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
//                           materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                           textColor: Theme.of(context).primaryColor,
//                             shape: RoundedRectangleBorder(side: BorderSide(
//                   color: Colors.blue,
//                   width: 1,
//                   style: BorderStyle.solid
//                 ), borderRadius: BorderRadius.circular(50)),
//                         ),
//          )],),)),
//        ],
//      ),
//    ),
   
//     );
//   }
// }