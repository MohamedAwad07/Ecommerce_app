import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:nemo_app/shared/components/components.dart';

import '../../shared/Cubit/states.dart';
import '../../shared/constants/constants.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();

}

class _CartPageState extends State<CartPage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  bool bottomSheet = false;
  double totalPrice = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    for(int i=0; i<userCart.length; ++i){
      var pro = AppProducts.where((product) => product['id'] == userCart[i]).toList()[0];
      double price = pro['price']*1.0;
      double discount = pro['discountPercentage']*1.0;
      totalPrice += (price - price * (discount / 100));
    }
    return SafeArea(
        child: Scaffold(
      key: scaffoldKey,
      body: Column(
        children: [
          CustomAppBar(
              title: "My Cart",
              backcolor: Colors.white,
              textColor: Colors.black),
          Expanded(
            child: AnimationLimiter(
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.all(_w / 200),
                physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                itemCount: userCart.length,
                itemBuilder: (BuildContext context, int index) {
                  var pro = AppProducts.where(
                          (product) => product['id'] == userCart[index]).toList();
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    delay: Duration(milliseconds: 100),
                    child: SlideAnimation(
                      duration: Duration(milliseconds: 2500),
                      curve: Curves.fastLinearToSlowEaseIn,
                      child: FadeInAnimation(
                        curve: Curves.fastLinearToSlowEaseIn,
                        duration: Duration(milliseconds: 2500),
                        child:myItems(
                            proId: userCart[index],
                            imagePath: pro[0]['thumbnail'],
                            title: pro[0]['title'],
                            description: pro[0]['description'],
                            price: pro[0]['price'] * 1.0,
                            discount: pro[0]['discountPercentage'],
                            fav: false),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          DottedBorder(
            dashPattern: [20, 15],
            color: Colors.grey.shade400,
            strokeWidth: 2,
            child: Container(
              width: double.infinity,
              height: 80,
              color: Colors.white,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(start: 25.0),
                    child: Text(
                      "Total : ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  // Expanded(
                  //   child: SizedBox(
                  //     width: double.maxFinite,
                  //   ),
                  // ),
                  SizedBox(width: 10,),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 70),
                    child: Text(
                      "\$${totalPrice.toStringAsFixed(1)}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.amber,
                          fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (bottomSheet) {
            Navigator.pop(context);
            bottomSheet = false;
          } else {
            scaffoldKey.currentState?.showBottomSheet(elevation: 20, (context) {
              return Container(
                // height: 300,
                width: double.infinity,
                color: Colors.white,

                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 30.0, left: 20, right: 20),
                        child: ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              var pro = AppProducts.where((product) => product['id'] == userCart[index]).toList();
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Row(
                                  children: [
                                    Text(
                                      pro[0]['title'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.grey.shade700),
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        width: double.maxFinite,
                                      ),
                                    ),
                                    Text(
                                      "\$${(pro[0]['price'] - pro[0]['price']*(pro[0]['discountPercentage']/100)).toStringAsFixed(1)}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 10,
                              );
                            },
                            itemCount: userCart.length),
                      ),
                      DottedBorder(
                        dashPattern: [20, 15],
                        color: Colors.grey.shade400,
                        strokeWidth: 2,
                        child: Container(
                          width: double.infinity,
                          height: 80,
                          color: Colors.white,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.only(
                                    start: 25.0),
                                child: Text(
                                  "Total price  : ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  width: double.maxFinite,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsetsDirectional.only(end: 70),
                                child: Text(
                                  "\$${totalPrice.toStringAsFixed(1)}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.amber,
                                      fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            });
            bottomSheet = true;
          }
          //setState(() {});
        },
        backgroundColor: Colors.white,
        child: bottomSheet
            ? Icon(
                Icons.keyboard_arrow_down,
                color: Colors.grey,
              )
            : Icon(
                Icons.keyboard_arrow_up_outlined,
                color: Colors.grey,
                shadows: [Shadow(color: Colors.white, blurRadius: 0)],
              ),
      ),
    ));
  }
}
