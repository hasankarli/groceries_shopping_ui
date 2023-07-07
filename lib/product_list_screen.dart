import 'package:flutter/material.dart';

import 'package:groceries_shopping_ui/const.dart';
import 'package:sizer/sizer.dart';

import 'components/cart_details.dart';
import 'components/row_cart.dart';
import 'models/product.dart';
import 'product_detail_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen>
    with SingleTickerProviderStateMixin {
  var openCart = false;
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    super.initState();
  }

  var productItems = <ProductItem>[];

  void _onVerticalGesture(DragUpdateDetails details) {
    if (details.primaryDelta! < -0.7) {
      setState(() {
        openCart = true;
      });
    } else if (details.primaryDelta! > 10) {
      setState(() {
        openCart = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        leading: Padding(
          padding: EdgeInsets.only(left: 4.w),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {},
          ),
        ),
        elevation: 0,
        title: const Row(
          children: [
            Text(
              'Pasta & Noodles',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 2.w),
            child: IconButton(
              onPressed: () {},
              icon: Image.asset('assets/images/filter.png'),
            ),
          ),
        ],
      ),
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) =>
            LayoutBuilder(builder: (context, constraints) {
          return Stack(
            alignment: Alignment.topCenter,
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                top: openCart ? -(constraints.maxHeight - 16.h) : 0,
                left: 0,
                right: 0,
                height: productItems.isNotEmpty
                    ? constraints.maxHeight - 8.h
                    : constraints.maxHeight,
                child: Container(
                  padding: EdgeInsets.only(bottom: 0.3.h),
                  decoration: BoxDecoration(
                      color: AppTheme.backgroundColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(4.h),
                        bottomRight: Radius.circular(4.h),
                      )),
                  child: GridView.count(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    crossAxisCount: 2,
                    childAspectRatio: ((45.w) / (70.h / 2)),
                    children: products
                        .map((product) => GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      transitionDuration:
                                          const Duration(milliseconds: 300),
                                      reverseTransitionDuration:
                                          const Duration(milliseconds: 300),
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          FadeTransition(
                                        opacity: animation,
                                        child: ProductDetailScreen(
                                          index: products.indexOf(product),
                                          onCartChanged: () {
                                            setState(() {
                                              if (productItems
                                                  .where((p) =>
                                                      p.product == product)
                                                  .isNotEmpty) {
                                                productItems
                                                    .firstWhere((p) =>
                                                        p.product == product)
                                                    .quantity += 1;
                                              } else {
                                                productItems.add(ProductItem(
                                                    product: product,
                                                    quantity: 1));
                                              }
                                            });
                                          },
                                        ),
                                      ),
                                    ));
                              },
                              child: Container(
                                height: 25.h,
                                margin: EdgeInsets.all(2.w),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(2.h),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Hero(
                                        tag: product.name,
                                        child: Container(
                                          padding: EdgeInsets.all(3.5.h),
                                          child: Image.asset(
                                            product.image,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(2.w),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '\$${product.price}',
                                            style: TextStyle(
                                              letterSpacing: 0.5,
                                              fontSize: 17.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 1.5.h),
                                          Text(
                                            product.name,
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 1.h),
                                          Text(
                                            '500g',
                                            style: TextStyle(
                                              fontSize: 10.sp,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          SizedBox(height: 1.h),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                bottom: 0,
                height: openCart
                    ? 78.h
                    : productItems.isNotEmpty
                        ? 8.h
                        : 0.h,
                width: 100.w,
                child: GestureDetector(
                  onVerticalDragUpdate: _onVerticalGesture,
                  child: Container(
                    alignment: Alignment.topCenter,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 2,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 700),
                      switchInCurve: Curves.easeInOut,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        child: openCart
                            ? CartDetails(
                                carts: productItems,
                                closeCart: () {
                                  setState(() {
                                    openCart = false;
                                  });
                                })
                            : RowCart(productItems: productItems),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
