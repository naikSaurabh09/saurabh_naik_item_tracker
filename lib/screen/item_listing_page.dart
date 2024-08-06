import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saurabh_naik_item_tracker/helper_functions/logger_helper.dart';
import 'package:saurabh_naik_item_tracker/model/item_details_model.dart';
import 'package:saurabh_naik_item_tracker/providers/item_listing_provider.dart';
import 'package:saurabh_naik_item_tracker/screen/create_item.dart';
import 'package:saurabh_naik_item_tracker/widget/common_elevated_button.dart';
import 'package:saurabh_naik_item_tracker/widget/item_list_tile.dart';

class ItemListingScreen extends StatefulWidget {
  const ItemListingScreen({super.key});

  @override
  State<ItemListingScreen> createState() => _ItemListingScreenState();
}

class _ItemListingScreenState extends State<ItemListingScreen> {
  @override
  Widget build(BuildContext context) {
    final ItemsListingProvider itemsListingProvider =
    Provider.of<ItemsListingProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Item Tracker",
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: itemsListingProvider.itemsList.isEmpty
          ? createItemsButton(context, itemsListingProvider)
          : listingOfItems(context, itemsListingProvider),
    );
  }

  Widget createItemsButton(
      BuildContext context, ItemsListingProvider itemsListingProvider) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          itemsListingProvider.itemsList.isEmpty
              ? const Text("No Items present to track")
              : const SizedBox(),
          SizedBox(
            height: itemsListingProvider.itemsList.isEmpty ? 20 : 0,
          ),
          itemsListingProvider.itemsList.isEmpty
              ?
          CommonElevatedButton(
            key: const ValueKey("CenterCreateItemButton"),
            onButtonTap: () {
              navigateToCreateItem(context);
            },
            buttonColor: Colors.black,
            buttonLabel: "Create Items to track",
          )
              :
          Row(
            children: [
              Expanded(
                child: CommonElevatedButton(
                  key: const ValueKey("BottomCreateItemButton"),
                  onButtonTap: () {
                    navigateToCreateItem(context);
                  },
                  buttonColor: Colors.black,
                  buttonLabel: "Create Items to track",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget listingOfItems(
      BuildContext context, ItemsListingProvider itemsListingProvider) {
    return Column(
      children: [
        const SizedBox(
          height: 8,
        ),
        Expanded(
          child: ListView.separated(

              itemCount: itemsListingProvider.itemsList.length,
              shrinkWrap: true,
              separatorBuilder: (context, index) => const SizedBox(
                height: 8,
              ),
              itemBuilder: (context, index) {
                //Get size and Position
                final GlobalKey itemKey = GlobalKey();
                String size = "0.0";
                String position = "0.0";
                Offset itemPosition = const Offset(0, 0);
                WidgetsBinding.instance.addPostFrameCallback((duration) {
                  RenderBox renderBox = itemKey.currentContext?.findRenderObject() as RenderBox;

                  size = "${renderBox.size}";

                  itemPosition = renderBox.localToGlobal(Offset.zero);
                  position = "${itemPosition.dx} - ${itemPosition.dy}";
                  "Size: $size \n Poistion: $position".log();
                });

                final element = itemsListingProvider.itemsList[index];
                return ItemListTile(
                  key: itemKey,
                  title: element.title,
                  description: element.description,
                  onDelete: () {
                    showDialogue(context,
                        itemsListingProvider: itemsListingProvider,
                        item: element,
                        itemIndex: index);
                  },
                  onEdit: () {
                    onEdit(
                        context,
                        itemIndex: index,
                        item: element
                    );
                  },
                );
              }),
        ),
        itemsListingProvider.itemsList.isNotEmpty
            ? createItemsButton(context, itemsListingProvider)
            : const SizedBox()
      ],
    );
  }

  void navigateToCreateItem(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const CreateItem(
            fromScreen: "create",
          )),
    );
  }

  void showDialogue(
      BuildContext context, {
        required ItemsListingProvider itemsListingProvider,
        required ItemDetails item,
        required int itemIndex,
      }) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            title: Text.rich(
              TextSpan(
                  text: "Are you sure you want to delete ",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                  children: [
                    TextSpan(
                      text: item.title,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    const TextSpan(
                      text: " ?",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    )
                  ]),
            ),
            titleTextStyle: const TextStyle(
              fontSize: 20,
              color: Colors.grey,
            ),
            actions: [
              CommonElevatedButton(
                onButtonTap: () {
                  Navigator.of(context).pop();
                },
                buttonColor: Colors.red,
                buttonLabel: "NO",
              ),
              const SizedBox(
                width: 20,
              ),
              CommonElevatedButton(
                onButtonTap: () {
                  onDelete(
                    context,
                    itemsListingProvider: itemsListingProvider,
                    itemIndex: itemIndex,
                  );
                },
                buttonColor: Colors.green,
                buttonLabel: "YES",
              ),
            ],
          );
        });
  }

  void onDelete(
      BuildContext context, {
        required ItemsListingProvider itemsListingProvider,
        required int itemIndex,
      }) {
    itemsListingProvider.deleteItem(itemIndex);
    Navigator.of(context).pop();
  }

  void onEdit(
      BuildContext context, {
        required ItemDetails item,
        required int itemIndex,
      }){
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CreateItem(
            fromScreen: "edit",
            item: item,
            itemIndex: itemIndex,
          )),
    );
  }
}
