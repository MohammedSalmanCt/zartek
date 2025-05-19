import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zartek_machine/core/common/global_variables.dart';
import 'package:zartek_machine/core/common/widgets/loader.dart';
import 'package:zartek_machine/features/home/Widget/drawer.dart';
import 'package:zartek_machine/features/home/Widget/items_widget.dart';
import 'package:zartek_machine/core/theme/pallete.dart';
import 'package:zartek_machine/features/home/controller/home_controller.dart';
import 'package:zartek_machine/features/home/screen/order_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    final user=ref.watch(userProvider);
      return ref.watch(fetchCategoryAndDishesProvider).when(
          data: (categories) {
            return DefaultTabController(
              length: categories.length,
              child: Scaffold(
                drawer: Drawer(
                    width: width*(0.95),
                    child: DrawerWidget()
                ),
                backgroundColor: AppColors.backGroundColour,
                appBar: AppBar(
                  backgroundColor: AppColors.backGroundColour,
                  leading: Builder(
                    builder: (context) => InkWell(
                      onTap: () {
                        Scaffold.of(context).openDrawer();
                      },
                      child: Icon(Icons.menu, color: AppColors.appBarIconColour),
                    ),
                  ),
                  actions: [
                    InkWell(
                      onTap: () {
                        Navigator.push(context, CupertinoPageRoute(builder: (context) => OrderScreen(),));
                      },
                      child:user != null && user.cart.isNotEmpty
                          ? Badge(
                        label: Text(
                          user.cart.length.toString(),
                          style: TextStyle(
                            color: AppColors.whiteColour,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        backgroundColor: AppColors.redColour,
                        child: Icon(
                          Icons.shopping_cart,
                          color: AppColors.appBarIconColour,
                        ),
                      )
                          : Icon(
                        Icons.shopping_cart,
                        color: AppColors.appBarIconColour,
                      )
                    ),
                    SizedBox(width: width * 0.05),
                  ],
                ),
                body:
                categories.isNotEmpty?
                Column(
                  children: [
                    TabBar(
                      isScrollable: true,
                      labelColor: AppColors.selectTabColour,
                      unselectedLabelColor: AppColors.unSelectedTabColour,
                      indicatorColor: AppColors.selectTabColour,
                      tabs: List.generate(
                        categories.length,
                            (index) => Tab(text: categories[index].name),
                      ),
                    ),
                    Expanded(
                        child:TabBarView(
                          children: List.generate(categories.length, (tabIndex) => SizedBox(
                            width: width,
                            child: ListView.builder(
                              itemCount: categories[tabIndex].dishes.length,
                              shrinkWrap: true,
                              itemBuilder: (context, dishIndex) {
                                final dishMap = categories[tabIndex].dishes[dishIndex];
                                return Column(
                                  children: [
                                    ItemsWidget(dish: dishMap,userModel: user,),
                                    const Divider(),
                                  ],
                                );
                              },
                            ),
                          )),
                        )
                    ),
                  ],
                )
                    :Center(
                  child: Text("No categories found!"),
                ),
              ),
            );
          },
        error: (error, stackTrace) {
          print(error);
          return Center(child: Text(error.toString()));
        },
        loading: () => Loader(),);
      }
  }

