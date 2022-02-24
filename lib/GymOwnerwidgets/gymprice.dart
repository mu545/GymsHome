import 'package:flutter/material.dart';
import 'package:gymhome/GymOwnerwidgets/location.dart';
import 'package:gymhome/models/gyms.dart';
import 'package:gymhome/provider/gymsitems.dart';
import 'package:provider/provider.dart';

class GymPrice extends StatefulWidget {
   static const routenames='/srsss';
  const GymPrice({ Key? key }) : super(key: key);

  @override
  _AddGymState createState() => _AddGymState();
}

class _AddGymState extends State<GymPrice> {
   final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Gyms(
    id: '',
    title: '',
    price: 0,
    description: '',
    imageUrl: '',  location: '' , facilites:  '' ,
  );

  var _initValues = {
    'title': '',
    'price': '',
    'description': '',
    'imageUrl': '',
  };
  var _isInit = true;
  bool _isLoading = false;

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  // void didChangeDependencies() {
  //   if (_isInit) {
  //     final productId = ModalRoute.of(context)!.settings.arguments as String;
  //     if (productId != null) {
  //       _editedProduct =
  //           Provider.of<Gymsitems>(context, listen: false).FindbyId(productId);
  //       _initValues = {
  //         'title': _editedProduct.title,
  //         'description': _editedProduct.description,
  //         'price': _editedProduct.price.toString(),
  //         // 'imageUrl': _editedProduct.imageUrl,
  //         'imageUrl': '',
  //       };
  //       _imageUrlController.text = _editedProduct.imageUrl;
  //     }
  //   }
  //   _isInit = false;
  //   super.didChangeDependencies();
  // }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  void _Saved() {
    final Validate = _form.currentState!.validate();
    // if (!Validate) {
    //   return;
    // }
    _form.currentState!.save();
    Provider.of<Gymsitems>(context, listen: false).addGyms(_editedProduct);
  //  Navigator.of(context).pushNamed(Location.routenamed);
    // if(_editfor.id != null){

    //   Provider.of<Gymsitems>(context , listen: false).Update(_editfor.id, _editfor);



    // }
    // else{  Provider.of<Gymsitems>(context, listen: false).addpro(_editfor);}


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(title: Center(child: Text('Add Gym ', style: TextStyle(color: Colors.black),)),backgroundColor: Colors.white, elevation: 0,actions: <Widget>[ IconButton(onPressed: (){}, icon: Icon(Icons.more_vert,color: Colors.black,),)], ),
   
   body: SingleChildScrollView(
     child: Column(
       children: [
         Container(  margin: EdgeInsets.symmetric(horizontal: 10 , vertical: 20), height: 400, width: 390 ,  child: Card(child: Column(children: [Row(children: [Container  ( margin: EdgeInsets.symmetric(horizontal: 20 , vertical: 10), child: Text('Price', style: TextStyle(fontSize: 30, color: Colors.blue),))],), 
      
        Container(margin: EdgeInsets.symmetric(horizontal: 10), height: 20, width: 390, decoration: BoxDecoration(border: Border.all(color: Colors.grey),borderRadius: BorderRadius.circular(5)), child: Row(children: [Container(
                   child: FlatButton( 
                                            
                                              child: Text('Day',style: TextStyle(color: Colors.grey , fontSize: 13),),  
                                              color: Colors.white,  
                                              onPressed: () {/** */},  
               
                                          ),
                 ), 
                                    
                                        FlatButton( 
                                          
                                            child: Text('Month',style: TextStyle(color: Colors.grey , fontSize: 13),),  
                                            color: Colors.white,  
                                            onPressed: () {/** */},  
               
                                        ), 
                                        FlatButton( 
                                          
                                            child: Text('3 Months',style: TextStyle(color: Colors.grey , fontSize: 13),),  
                                            color: Colors.white,  
                                            onPressed: () {/** */},  
               
                                        ), 
                                        FlatButton( 
                                          
                                            child: Text('6 Months',style: TextStyle(color: Colors.grey , fontSize: 13),),  
                                            color: Colors.white,  
                                            onPressed: () {/** */},  
               
                                        ), 
                                        // FlatButton( 
                                          
                                        //     child: Text('Month',style: TextStyle(color: Colors.blue , fontSize: 13),),  
                                        //     color: Colors.white,  
                                        //     onPressed: () {/** */},  
               
                                        // ), 
                                       
                                          ],),),
                                          SizedBox(height: 20,),
                                           Row(
                                             children: [
                                            Expanded(
                                              child:     TextFormField(
                      initialValue: _initValues['price'],
                      decoration: InputDecoration(
                        labelText: 'Price',
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _priceFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode);
                      },
                     
                      onSaved: (value) {
                        _editedProduct = Gyms(
                          title: _editedProduct.title,
                          price: double.parse(value!),
                          description: _editedProduct.description,
                          imageUrl: _editedProduct.imageUrl,
                          id: _editedProduct.id,
                        
                           location: _editedProduct.location, 
                                facilites: _editedProduct.facilites , 
                            
                        );
                      },
                    ),
                                            ),
                                       SizedBox(width: 10,),    Text('SAR')  ],
                                           ),
         SizedBox(height: 120,),
          Container(
           width: 250,height: 40,
           decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.blue),
           child: FlatButton(
                          child: Text(
                              'Send', style: TextStyle(color: Colors.white),),
                          onPressed: _Saved ,
                          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          textColor: Theme.of(context).primaryColor,
                        ),
         ),
         SizedBox(height: 10,)
   ,   
         Container(
           width: 250,height: 40,
           decoration: BoxDecoration(   borderRadius: BorderRadius.circular(20), color: Colors.white),
           child: FlatButton(
             
                          child: Text(
                              'Cancel', style: TextStyle(color: Colors.blue),),
                          onPressed: (){Navigator.of(context).pushNamed('/'); },
                          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          textColor: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(side: BorderSide(
                  color: Colors.blue,
                  width: 1,
                  style: BorderStyle.solid
                ), borderRadius: BorderRadius.circular(50)),
                        ),
         )],),)),
       ],
     ),
   ),
   
    );
  }
}