import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zartek_machine/features/home/Widget/veg_nonveg_icon.dart';
import 'package:zartek_machine/model/dishes_model.dart';
import '../../../core/common/global_variables.dart';
import '../../../core/theme/pallete.dart';
import '../controller/home_controller.dart';

class CartItemsWidget extends StatelessWidget {
  const CartItemsWidget({super.key,required this.dishesModel});
  final DishesModel dishesModel;

  @override
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VegNonVegIcon(color: dishesModel.is_veg?AppColors.buttonGreenColour:AppColors.redColour),
          const SizedBox(width: 3),
          SizedBox(
            width: width*(0.3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  dishesModel.name,
                  style: TextStyle(
                    color: AppColors.blackColour,
                    fontWeight: FontWeight.w600,
                    fontSize: width*(0.05),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "INR ${dishesModel.price}",
                  style: TextStyle(
                    color: AppColors.blackColour,
                    fontWeight: FontWeight.w500,
                    fontSize: width*(0.04),
                  ),
                ),
                const SizedBox(height:2 ),
                Text(
                  "Calories ${dishesModel.calories}",
                  style: TextStyle(
                    color: AppColors.blackColour,
                    fontWeight: FontWeight.w500,
                    fontSize: width*(0.04),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),
          Consumer(
              builder: (context,ref,child) {
                final user=ref.watch(userProvider);
                return Container(
                  width: width*(0.28),
                  height: height*(0.045),
                  decoration: BoxDecoration(
                    color: AppColors.orderButtonsColour,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove, color: AppColors.whiteColour),
                        onPressed: () {
                          if (dishesModel.qty > 0) {
                            ref.read(homeControllerProvider.notifier).updateCartWithDish(context: context, dish: dishesModel,
                                isIncrement: false, user: user!);
                          }
                        },
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 1),
                        child: Text(dishesModel.qty.toString(),
                          style: const TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add, color: Colors.white),
                        onPressed: () {
                          ref.read(homeControllerProvider.notifier).updateCartWithDish(context: context, dish: dishesModel,
                              isIncrement: true, user: user!);
                        },
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                );
              }
          ),
          const SizedBox(width: 6),
          SizedBox(
            width: width*(0.2),
            child: Text(
              "INR ${dishesModel.price}",
              style: TextStyle(
                color: AppColors.blackColour,
                fontWeight: FontWeight.w500,
                fontSize: width*(0.04),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
