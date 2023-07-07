import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../models/product.dart';

class RowCart extends StatelessWidget {
  const RowCart({
    super.key,
    required this.productItems,
  });

  final List<ProductItem> productItems;

  @override
  Widget build(BuildContext context) {
    int totalQuantity = productItems.fold(
        0, (previousValue, item) => previousValue + item.quantity);

    return SizedBox(
      height: 7.h,
      child: Row(
        children: [
          Text(
            "Cart",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 2.w),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  productItems.length,
                  (index) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 1.5.w),
                    child: Hero(
                      tag: "${productItems[index].product.name}_cartTag",
                      child: CircleAvatar(
                        radius: 2.7.h,
                        backgroundImage: AssetImage(
                          productItems[index].product.image,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: 5.h,
            width: 5.h,
            decoration: BoxDecoration(
              color: Colors.orangeAccent[200],
              shape: BoxShape.circle,
            ),
            child: Text(
              "$totalQuantity",
              style: TextStyle(
                color: Colors.black,
                fontSize: 10.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
