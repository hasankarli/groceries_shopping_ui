import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../models/product.dart';

class CartDetails extends StatefulWidget {
  const CartDetails({
    super.key,
    required this.carts,
    required this.closeCart,
  });

  final List<ProductItem> carts;
  final VoidCallback closeCart;

  @override
  State<CartDetails> createState() => _CartDetailsState();
}

class _CartDetailsState extends State<CartDetails> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.offset <=
            _scrollController.position.minScrollExtent) {
          setState(() {
            widget.closeCart();
          });
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = widget.carts.fold(
        0,
        (previousValue, item) =>
            previousValue + (item.product.price * item.quantity));
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      controller: _scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Cart",
            style: TextStyle(
              color: Colors.white,
              fontSize: 27.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 3.h),
          ...List.generate(
            widget.carts.length,
            (index) => Padding(
              padding: EdgeInsets.symmetric(vertical: 1.h),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 1.h),
                leading: CircleAvatar(
                  radius: 2.7.h,
                  backgroundColor: Colors.white,
                  backgroundImage:
                      AssetImage(widget.carts[index].product.image),
                ),
                title: Row(
                  children: [
                    Text(
                      '${widget.carts[index].quantity} x ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 2.w),
                    Expanded(
                      child: Text(widget.carts[index].product.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ],
                ),
                trailing: Text(
                    '\$${widget.carts[index].product.price * widget.carts[index].quantity}',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          SizedBox(height: 1.h),
          Container(
            alignment: Alignment.topLeft,
            height: 13.h,
            width: 100.w,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.all(0.7.h),
                  height: 5.h,
                  width: 5.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset('assets/images/car.png',
                      color: Colors.yellow),
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 1.h),
                      Text(
                        'Delivery',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 3.h),
                      Text(
                        'All orders of \$40 or more\nqualify for FREE delivery',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.sp,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Stack(
                        children: [
                          Container(
                            height: 5,
                            width: 40.w,
                            decoration: BoxDecoration(
                              color: Colors.grey[800],
                              borderRadius: BorderRadius.circular(1.h),
                            ),
                          ),
                          Container(
                            height: 5,
                            width: 30.w,
                            decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(1.h),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 1.h),
                  child: Text('\$30.00',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold)),
                )
              ],
            ),
          ),
          SizedBox(height: 4.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total: ',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 17.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('\$${(totalPrice + 30).toStringAsFixed(2)}',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 4.h),
          Center(
            child: SizedBox(
              width: 90.w,
              height: 6.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.h),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  "Next",
                  style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
