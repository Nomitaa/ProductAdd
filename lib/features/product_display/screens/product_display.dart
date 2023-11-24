import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:newpro/features/product_edit/screens/product_edit.dart';
import '../controller/productdisplay_controller.dart';

class ProductDisplay extends ConsumerWidget {
  const ProductDisplay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    void delete(String productId) {
      ref.read(productdisplayprovider).delete(productId);
    }

    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Product Display'))),
      body: ref.watch(productdisplayStreamProvider).when(
        data: (data) => ListView.builder(
          physics: BouncingScrollPhysics(
              decelerationRate: ScrollDecelerationRate.fast),
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            String imgUrl = '';
            for (var image in data[index].image) {
              imgUrl = image;
            }

            return Card(
              semanticContainer: true,
              elevation: 4,
              shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Container(
                width: w / 2,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: w * 0.5,
                          height: h / 8,
                          child: Image(
                            image: NetworkImage(imgUrl),
                          ),
                        ),
                        SizedBox(width: 15),
                        InkWell(
                          onTap: () {
                            delete(data[index].id);
                          },
                          child: Icon(
                            CupertinoIcons.delete,
                            color: Colors.red,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProductEdit(product: data[index]),
                              ),
                            );
                          },
                          child: Text("Edit"),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 55.0),
                      child: Text(data[index].name),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 55.0),
                      child: Text(data[index].price.toString()),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        error: (error, stackTrace) {
          return Scaffold(
            body: Center(child: Text('Error: $error')),
          );
        },
        loading: () {
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}