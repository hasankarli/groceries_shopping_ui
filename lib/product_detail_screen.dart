import 'dart:async';

import 'package:flutter/material.dart';
import 'package:groceries_shopping_ui/models/product.dart';
import 'package:sizer/sizer.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen(
      {super.key, required this.index, required this.onCartChanged});
  final int index;
  final VoidCallback onCartChanged;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String _cartTag = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 1.9.h),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.white,
              spreadRadius: 30,
              blurRadius: 30,
              offset: Offset(0, 10), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 7.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                padding: EdgeInsets.all(0.6.h),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.5),
                    ),
                    shape: BoxShape.circle),
                child: IconButton(
                    iconSize: 3.h,
                    onPressed: () {},
                    icon: const Icon(Icons.favorite_border)),
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    widget.onCartChanged();
                    setState(() {
                      _cartTag = '_cartTag';
                    });
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 7.h,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 235, 184, 82),
                      borderRadius: BorderRadius.circular(4.h),
                    ),
                    child: Center(
                      child: Text(
                        'Add to Cart',
                        style: TextStyle(
                          letterSpacing: 0.4,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Colors.white,
              leading: Padding(
                padding: EdgeInsets.only(left: 4.w),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              elevation: 0,
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 7.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: products[widget.index].name + _cartTag,
                  child: Center(
                    child: SizedBox(
                        width: 100.w,
                        height: 30.h,
                        child: Image.asset(products[widget.index].image)),
                  ),
                ),
                SizedBox(height: 4.h),
                AnimatedWidget(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        products[widget.index].name,
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.5.h),
                        child: Text(
                          '500g',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.h),
                              border:
                                  Border.all(color: Colors.grey, width: 0.5),
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.remove)),
                                SizedBox(
                                  width: 1.w,
                                ),
                                Text('1',
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  width: 1.w,
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.add)),
                              ],
                            ),
                          ),
                          Text(
                            '\$${products[widget.index].price}',
                            style: TextStyle(
                              fontSize: 25.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        'About the product',
                        style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 2.5.h),
                      Text(
                        products[widget.index].description * 4,
                        style: TextStyle(
                          overflow: TextOverflow.fade,
                          fontSize: 12.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AnimatedWidget extends StatefulWidget {
  const AnimatedWidget({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  State<AnimatedWidget> createState() => _AnimatedWidgetState();
}

class _AnimatedWidgetState extends State<AnimatedWidget> {
  var opacity = 0.0;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 100), () {
      setState(() {
        opacity = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 100),
      curve: Curves.bounceIn,
      opacity: opacity,
      child: widget.child,
    );
  }
}
