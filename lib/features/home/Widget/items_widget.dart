import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zartek_machine/features/home/Widget/veg_nonveg_icon.dart';
import 'package:zartek_machine/features/home/controller/home_controller.dart';
import 'package:zartek_machine/model/dishes_model.dart';
import 'package:zartek_machine/model/user_model.dart';
import '../../../core/common/global_variables.dart';
import '../../../core/theme/pallete.dart';

class ItemsWidget extends ConsumerStatefulWidget {
    const ItemsWidget({super.key,required this.dish,required this.userModel});
   final DishesModel dish;
   final UserModel? userModel;

  @override
  ConsumerState<ItemsWidget> createState() => _ItemsWidgetState();
}

class _ItemsWidgetState extends ConsumerState<ItemsWidget> {
  final qtyProvider = StateProvider<int>((ref) {
    return 0;
  });
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (widget.userModel != null) {
        // UserModel userModel=await ref.read(homeControllerProvider.notifier).getUserData(widget.userModel!);
        bool exists = widget.userModel!.cart.any((cartDish) => cartDish.id == widget.dish.id);
        if(exists){
          DishesModel? cartItem = widget.userModel!.cart.firstWhere((
              cartDish) => cartDish.id == widget.dish.id);
          ref.read(qtyProvider.notifier).update((state) => cartItem.qty ?? 0,);
        }
        else{
          ref.read(qtyProvider.notifier).update((state) => 0,);
          print("lllllllllllllllllllll");
        }
      }
    }
      );
  }
  @override
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VegNonVegIcon(color: widget.dish.is_veg?AppColors.buttonGreenColour:AppColors.redColour),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.dish.name,
                  style: TextStyle(
                    color: AppColors.blackColour,
                    fontWeight: FontWeight.bold,
                    fontSize: width*(0.05),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      "INR ${widget.dish.price}",
                      style: TextStyle(
                        color: AppColors.blackColour,
                        fontWeight: FontWeight.w900,
                        fontSize: width*(0.04),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "${widget.dish.calories} Calories",
                      style: TextStyle(
                        color: AppColors.blackColour,
                        fontWeight: FontWeight.w900,
                        fontSize: width*(0.04),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  widget.dish.description,
                  style: TextStyle(
                    color: AppColors.greyTextColour,
                    fontSize: width*(0.04),
                  ),
                ),
                const SizedBox(height: 8),
                Consumer(
                  builder: (context,ref,child) {
                    final user=ref.watch(userProvider);
                    int qty=ref.watch(qtyProvider);
                    print("ssssssssssssssss$qty");
                    return Container(
                      height: height*(0.05),
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.buttonGreenColour,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove, color: AppColors.whiteColour),
                            onPressed: () {
                              if (qty > 0) {
                                ref.read(homeControllerProvider.notifier).updateCartWithDish(context: context, dish: widget.dish,
                                    isIncrement: false, user: user!);
                                ref.read(qtyProvider.notifier).state--;
                              }
                            },
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              '$qty',
                              style: const TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add, color: Colors.white),
                            onPressed: () {
                              ref.read(homeControllerProvider.notifier).updateCartWithDish(context: context, dish: widget.dish,
                                  isIncrement: true, user: user!);
                              ref.watch(qtyProvider.notifier).state++;
                            },
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                    );
                  }
                ),
                ...widget.dish.customizations_available?[
                const SizedBox(height: 4),
                Text(
                  "Customizations Available",
                  style: TextStyle(
                    color: AppColors.redColour,
                    fontWeight: FontWeight.w300,
                    fontSize: width*(0.035),
                  ),
                ),
                ]:[]
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: width*(0.2),
            height: height*(0.1),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(6),
            border: Border.all(color: AppColors.greyTextColour),
            image: DecorationImage(image: NetworkImage(widget.dish.image_url),fit: BoxFit.fill)),
          )
        ],
      ),
    );
  }
}
