import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newpro/model/product_model.dart';
import 'package:newpro/features/product_display/screens/product_display.dart';
import '../controller/product_controller.dart';

class ProductAdd extends ConsumerStatefulWidget {
  const ProductAdd({super.key});

  @override
  ConsumerState<ProductAdd> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<ProductAdd> {
  add(data) {
    ref.read(controllerProvider).add(data);
  }

  void _showImagePicker(BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(20)),
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Pick from gallery'),
                onTap: () async {
                  uploadImage(ImageSource.gallery);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Take a photo'),
                onTap: () async {
                  uploadImage(ImageSource.camera);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  List<String> images = [];
  final picker = ImagePicker();

  Future<void> uploadImage(ImageSource source) async {
    final XFile? pickedImage =
        await picker.pickImage(source: source, imageQuality: 10);
    if (pickedImage == null) return;

    File imageFile = File(pickedImage.path);
    Reference ref = FirebaseStorage.instance
        .ref()
        .child("namitha/images/${DateTime.now()}");
    UploadTask uploadTask = ref.putFile(imageFile);

    TaskSnapshot taskSnapshot = await uploadTask;
    String imageUrl = await taskSnapshot.ref.getDownloadURL();

    setState(() {
      images.add(imageUrl);
      print(images);
    });
  }

  TextEditingController _name = TextEditingController();
  TextEditingController _price = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          width: w,
          height: h,
          // color: Colors.yellow,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: Padding(
                      padding: const EdgeInsets.only(top: 60.0),
                      child: Text(
                        'Product Add',
                        style: TextStyle(color: Colors.blue, fontSize: 27),
                      ),
                    ))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 100.0),
                  child: Container(
                    width: w * 0.8,
                    child: TextFormField(
                      style: TextStyle(color: Colors.black),
                      controller: _name,
                      validator: (value) {
                        if (value == '') {
                          return 'please enter a product';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.name,
                      inputFormatters: [
                        FilteringTextInputFormatter(RegExp('[a-z,A-z]'),
                            allow: true)
                      ],
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          hintStyle: TextStyle(color: Colors.black),
                          labelStyle: TextStyle(color: Colors.black),
                          hintText: 'Productname',
                          labelText: 'ProductName',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6))),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: w * 0.8,
                  child: TextFormField(
                    style: TextStyle(color: Colors.black),
                    controller: _price,
                    validator: (value) {
                      if (value == '') {
                        return 'Please enter a price';
                      }
                      final numericValue = int.tryParse(value!);
                      if (numericValue == null || numericValue <= 0) {
                        return 'Price must be a positive number';
                      }
                      return null; // Return null for no validation error
                    },
                    keyboardType: TextInputType.number,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.black),
                        labelStyle: TextStyle(color: Colors.black),
                        focusColor: Colors.black,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        hintText: 'ProductPrice',
                        labelText: 'ProductPrice',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(6))),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    onPressed: () {
                      _showImagePicker(context);
                    },
                    child: Text('select image')),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 100,
                  width: 150,
                  color: Colors.transparent,
                  child: images == null
                      ? Center(
                          child: Text(
                          "No image ",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ))
                      : ListView.builder(
                          physics: BouncingScrollPhysics(
                              decelerationRate: ScrollDecelerationRate.fast),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (ctx, index) {
                            return Image(
                              image: NetworkImage(images[index]),
                              fit: BoxFit.fill,
                            );
                          },
                          itemCount: images.length,
                        ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                    onPressed: () {
                      var data = Productmodel(
                          name: _name.text,
                          price: int.parse(_price.text),
                          image: images,
                          id: '',
                          delete: false);
                      add(data);
                      if (_name.text != '' && _price.text != '') {
                        _name.clear();
                        _price.clear();
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Added successfully')));
                      } else {
                        _name.text == ''
                            ? ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('please enter ProductName')))
                            : ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content:
                                        Text('please enter ProductPrice')));
                      }
                    },
                    child: Text('Add Product')),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductDisplay()));
                    },
                    child: Text("view"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
