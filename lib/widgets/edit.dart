
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gymhome/GymOwnerwidgets/facilities.dart';
import 'package:gymhome/GymOwnerwidgets/gymprice.dart';
import 'package:gymhome/GymOwnerwidgets/location.dart';
import 'package:gymhome/GymOwnerwidgets/ownerhome.dart';
import 'package:gymhome/models/gyms.dart';
import 'package:gymhome/provider/gymsitems.dart';
import 'package:gymhome/widgets/checkbox.dart';
import 'package:gymhome/widgets/newhome.dart';


import 'package:provider/provider.dart';

class Editadd extends StatefulWidget {
   static const routeName = '/sawedd';
  @override
  // static const routeNamed = '/EditADD';
  _EditaddState createState() => _EditaddState();
}

class _EditaddState extends State<Editadd> {
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
    imageUrl: '',  location: '' , facilites:  '' , hours: ''
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
    Provider.of<Gymsitems>(context, listen: false).addProduct(_editedProduct);
    Navigator.of(context).pushNamed(OwnerHome.rounamed) ;
  //  Navigator.of(context).pushNamed(Location.routenamed);
    // if(_editfor.id != null){

    //   Provider.of<Gymsitems>(context , listen: false).Update(_editfor.id, _editfor);



    // }
    // else{  Provider.of<Gymsitems>(context, listen: false).addpro(_editfor);}


  }

  @override


  Widget build(BuildContext context) {
   final Gym = Provider.of<Gyms>(context);
    return Scaffold(
       appBar: AppBar(title: Center(child: Text('Add Gym ', style: TextStyle(color: Colors.black),)),backgroundColor: Colors.white, elevation: 0,actions: <Widget>[ IconButton(onPressed: (){}, icon: Icon(Icons.more_vert,color: Colors.black,),)], ),
      body:
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 400,
                  width: 390,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Card(
                    
                    child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Form(
                          key: _form,
                          child: ListView(
                            padding: EdgeInsets.all(10),
                            children: [
                              Text('Gym Information', style: TextStyle(fontSize: 30, color: Colors.blue),),
                              SizedBox(height: 20,),
                            TextFormField(
                            initialValue: _initValues['title'],
                            decoration: InputDecoration(
                              labelText: 'Name',
                            ),
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context).requestFocus(_priceFocusNode);
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please provide a value.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _editedProduct = Gyms(
                                title: value!,
                                price: _editedProduct.price,
                                description: _editedProduct.description,
                                imageUrl: _editedProduct.imageUrl,
                                id: _editedProduct.id,
                                isFavorite: _editedProduct.isFavorite,
                                 location: _editedProduct.location, 
                                      facilites: _editedProduct.facilites , 
                                      hours: _editedProduct.hours
                              );
                            },
                          ),
                          TextFormField(
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
                                isFavorite: _editedProduct.isFavorite,
                                 location: _editedProduct.location, 
                                      facilites: _editedProduct.facilites , 
                                      hours: _editedProduct.hours
                              );
                            },
                          ),
                          TextFormField(
                            initialValue: _initValues['description'],
                            decoration: InputDecoration(
                              labelText: 'Description',
                            ),
                            maxLines: 3,
                            focusNode: _descriptionFocusNode,
                            keyboardType: TextInputType.multiline,
                         
                            onSaved: (value) {
                              _editedProduct = Gyms(
                                title: _editedProduct.title,
                                price: _editedProduct.price,
                                description: value!,
                                imageUrl: _editedProduct.imageUrl,
                                id: _editedProduct.id,
                                isFavorite: _editedProduct.isFavorite,
                                 location: _editedProduct.location, 
                                      facilites: _editedProduct.facilites , 
                                      hours: _editedProduct.hours
                              );
                            },
                          ),
                              TextFormField(
                            initialValue: _initValues['faciltrs'],
                            decoration: InputDecoration(
                              labelText: 'faciltrs',
                            ),
                            maxLines: 3,
                            focusNode: _descriptionFocusNode,
                            keyboardType: TextInputType.multiline,
                         
                            onSaved: (value) {
                              _editedProduct = Gyms(
                                title: _editedProduct.title,
                                price: _editedProduct.price,
                                description: _editedProduct.description,
                                imageUrl: _editedProduct.imageUrl,
                                id: _editedProduct.id,
                                isFavorite: _editedProduct.isFavorite,
                                 location: _editedProduct.location, 
                                      facilites: value! , 
                                      hours: _editedProduct.hours
                              );
                            },
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                width: 100,
                                height: 100,
                                margin: EdgeInsets.only(
                                  top: 8,
                                  right: 8,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey,
                                  ),
                                ),
                                child: _imageUrlController.text.isEmpty
                                    ? Text('Enter a URL')
                                    : FittedBox(
                                        child: Image.network(
                                          _imageUrlController.text,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                              ),
                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(labelText: 'Image URL'),
                                  keyboardType: TextInputType.url,
                                  textInputAction: TextInputAction.done,
                                  controller: _imageUrlController,
                                  focusNode: _imageUrlFocusNode,
                                  validator: (value) {
                                    return null;
                                  },
                                  onFieldSubmitted: (_) {
                                    _Saved();
                                  },
                                  onSaved: (value) {
                                    _editedProduct = Gyms(
                                      title: _editedProduct.title,
                                      price: _editedProduct.price,
                                      description: _editedProduct.description,
                                      imageUrl: value!,
                                      id: _editedProduct.id,
                                      isFavorite: _editedProduct.isFavorite,
                                      location: _editedProduct.location, 
                                      facilites: _editedProduct.facilites , 
                                      hours: _editedProduct.hours
                                    );
                                  },
                                ),
                              ),
                                ],
                              ),
            //                    Column(
            //                      children: [
            //                        Row(
            //                          children: [
            //                             Container(
            //                         width: 60,
            //                         height: 25,
            //                         decoration: BoxDecoration(borderRadius: BorderRadius.circular(10) , color: Colors.blue),
            //                         child: FlatButton( 
                                    
            //                           child: Text('Pool',style: TextStyle(color: Colors.blue , fontSize: 13),),  
            //                           color: Colors.white,  
            //                           onPressed: () {Gym.poolstatus();},  

                                      
            //                           shape: RoundedRectangleBorder(side: BorderSide(
            //   color: Colors.blue,
            //   width: 1,
            //   style: BorderStyle.solid
            // ),
            //                         ),
            //                       ), 
                                 
            //                        ), 
            //                          ],
            //                        ),
            //                         // Row(
            //                         //   children: [
            //                         //     Text('Squash'),
            //                         //      MyStatefulWidget() ,
            //                         //   ],
            //                         // ),   
            //                      ],
            //                    ),    
                              ],
                          ),
                        ),
                      ),
                  ),
                ),
              SizedBox(height: 70,),
                         Container(
                                            width: 250,height: 40,
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.blue),
                                            child: FlatButton(
                                  child: Text(
                                      'Next', style: TextStyle(color: Colors.white),),
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
                                onPressed: (){Navigator.of(context).pop(); },
                                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                textColor: Theme.of(context).primaryColor,
                                  shape: RoundedRectangleBorder(side: BorderSide(
                        color: Colors.blue,
                        width: 1,
                        style: BorderStyle.solid
                      ), borderRadius: BorderRadius.circular(50)),
                              ),
                       ) ],
            ),
          ),
    );
  }
}
