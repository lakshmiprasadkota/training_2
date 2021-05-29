import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:training_test2/models/all_products_model.dart';
import 'package:training_test2/network/base_network.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Products products = Products();
  bool indicator = false;
  Response res;
  String tk;

  void getMothod() async {
    setState(() {
      indicator = true;
    });
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String access_token = prefs.get("access_token");
      tk = access_token;
      Response response = await dioClient.ref.get("/products?page=0",
          options: Options(
              validateStatus: (status) => status < 500,
              headers: {"Authorization": "Bearer $access_token"}));
      setState(() {
        products = productsFromJson(jsonEncode(response.data));
        indicator = false;
        print("accessed token is ${access_token}");
      });
      print(response);
    } catch (e) {
      setState(() {
        indicator = false;
      });
      print(e);
    }
  }

  @override
  void initState() {
    getMothod();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            indicator
                ? Center(child: CircularProgressIndicator())
                : Container(
                    child: products.products.length == 0
                        ? Text("no Data")
                        : ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: products.products.length,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 8),
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Image.network("http://vps-d5b18cef.vps.ovh.net:5000${products.products[index].image}",width: 30,),
                                        Column(
                                          children: [
                                            Text(
                                                "${products.products[index].name}"),
                                            Text(products
                                                .products[index].description),
                                            Text(
                                                "${products.products[index].amount}"),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 22,
                              );
                            }),
                  )
          ],
        ),
      ),
    );
  }
}
