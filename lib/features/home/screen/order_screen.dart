import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zartek_machine/core/constants/assets_constants.dart';
import 'package:zartek_machine/core/theme/pallete.dart';
import 'package:zartek_machine/features/home/Widget/cart_item_widget.dart';
import 'package:zartek_machine/features/home/Widget/order_placer_alert.dart';
import 'package:zartek_machine/features/home/controller/home_controller.dart';
import 'package:zartek_machine/features/home/screen/home_screen.dart';
import 'package:zartek_machine/model/dishes_model.dart';

import '../../../core/common/global_variables.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key,});

  @override
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.backGroundColour,
      appBar: AppBar(
        backgroundColor: AppColors.backGroundColour,
        leading: InkWell(
          onTap: () => Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder:(context) => HomeScreen(),), (route) => false,),
          child: Icon(Icons.arrow_back_outlined,color: AppColors.appBarIconColour,size: width*(0.06),),
        ),
        title: Text("Order Summary",style: TextStyle(color: AppColors.appBarIconColour,fontSize: width*(0.05),fontWeight: FontWeight.w600),),
        elevation: 6,
        bottomOpacity: 2,
      ),
      body: Consumer(builder: (context,ref,child) {
        double items=0;
        double totalAmount=0;
       final userModel= ref.watch(userProvider);
       if( userModel != null) {
         for(var i in userModel.cart){
           items=items + i.qty;
           totalAmount=totalAmount+(i.qty*double.parse(i.price));
         }
         return  userModel.cart.isEmpty
             ?Center(
           child: SizedBox(
             width: width,
             height: height * 0.5,
             child: Image.asset(AssetsConstants.empty),
           ),
         )
             :SingleChildScrollView(
           child: Column(
             mainAxisAlignment: MainAxisAlignment.start,
             children: [
               Container(
                 margin: EdgeInsets.symmetric(
                     horizontal: width * 0.04, vertical: height * 0.03),
                 decoration: BoxDecoration(
                   color: AppColors.whiteColour,
                   borderRadius: BorderRadius.circular(5),
                   boxShadow: [
                     BoxShadow(
                       color: Colors.black54.withOpacity(0.2),
                       spreadRadius: 1,
                       blurRadius: 4,
                       offset: Offset(0, 2),
                     ),
                   ],
                 ),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     Container(
                       width: width * 0.9,
                       height: height * 0.065,
                       margin: EdgeInsets.only(top: height * 0.01),
                       decoration: BoxDecoration(
                         color: AppColors.orderButtonsColour,
                         borderRadius: BorderRadius.circular(5),
                       ),
                       child: Center(
                         child: Text(
                           "${userModel.cart.length} Dishes - ${items.toStringAsFixed(0)} Items",
                           style: TextStyle(
                             fontWeight: FontWeight.w600,
                             color: AppColors.whiteColour,
                             fontSize: width * 0.05,
                           ),
                         ),
                       ),
                     ),
                     SizedBox(height: height * 0.03),
                     SizedBox(
                       width: width,
                       child: ListView.builder(
                         physics: NeverScrollableScrollPhysics(),
                         shrinkWrap: true,
                         itemCount: userModel.cart.length,
                         itemBuilder: (context, index) {
                           DishesModel dish=userModel.cart[index];
                           return Consumer(
                             builder: (context, ref, child) {
                               return Column(
                                 children: [
                                   CartItemsWidget(dishesModel: dish,),
                                   SizedBox(height: 3),
                                   Divider(),
                                 ],
                               );
                             },
                           );
                         },
                       ),
                     ),
                     SizedBox(height: height * 0.005),
                     Padding(
                       padding: EdgeInsets.symmetric(
                         horizontal: width * 0.04,
                         vertical: height * 0.01,
                       ),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Text(
                             "Total Amount",
                             style: TextStyle(
                               color: AppColors.blackColour,
                               fontWeight: FontWeight.w600,
                               fontSize: width * 0.048,
                             ),
                           ),
                           Text(
                             "INR $totalAmount",
                             style: TextStyle(
                               color: AppColors.buttonGreenColour,
                               fontWeight: FontWeight.w500,
                               fontSize: width * 0.04,
                             ),
                           ),
                         ],
                       ),
                     ),
                   ],
                 ),
               ),
               SizedBox(height: height * 0.01),
               Consumer(
                 builder: (context,ref,child) {
                   return GestureDetector(
                     onTap: () {
                       ref.read(homeControllerProvider.notifier).clearCart(context: context, user: userModel);
                       showOrderPlacedPoPup(context: context, width: width, height: height);
                       Navigator.pop(context);
                       Navigator.pop(context);
                     },
                     child: Container(
                       width: width * 0.9,
                       height: height * 0.065,
                       decoration: BoxDecoration(
                         color: AppColors.orderButtonsColour,
                         borderRadius: BorderRadius.circular(width * 0.08),
                       ),
                       child: Center(
                         child: Text(
                           "Place Order",
                           style: TextStyle(
                             fontWeight: FontWeight.w500,
                             color: AppColors.whiteColour,
                             fontSize: width * 0.055,
                           ),
                         ),
                       ),
                     ),
                   );
                 }
               ),
               SizedBox(height: height * 0.015),
             ],
           ),
         );
        }
            else{
           return   Center(
                   child: Column(
                     children: [
                       Text("Cart is Empty",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 15),),
                       SizedBox(
                       width: width,
                       height: height * 0.5,
                       child: Image.asset(AssetsConstants.empty),
                       ),
                     ],
                   ),
                   );}
      },)
    );
  }
}
