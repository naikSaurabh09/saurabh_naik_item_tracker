
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saurabh_naik_item_tracker/model/item_details_model.dart';
import 'package:saurabh_naik_item_tracker/providers/item_listing_provider.dart';
import 'package:saurabh_naik_item_tracker/widget/common_textfield.dart';

class CreateItem extends StatefulWidget {
  final ItemDetails? item;
  final int? itemIndex;
  final String fromScreen;

  const CreateItem({
    super.key,
    required this.fromScreen,
    this.itemIndex,
    this.item,
  });

  @override
  State<CreateItem> createState() => _CreateItemState();
}

class _CreateItemState extends State<CreateItem> {
  final GlobalKey<FormState> formKey = GlobalKey();

  final TextEditingController titleController = TextEditingController();
  final FocusNode titleFocusNode = FocusNode();

  final TextEditingController descriptionController = TextEditingController();
  final FocusNode descriptionFocusNode = FocusNode();

  @override
  void initState(){
    super.initState();
    if(widget.fromScreen == "edit"){
      titleController.text = widget.item!.title;
      descriptionController.text = widget.item!.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ItemsListingProvider itemsListingProvider = Provider.of<ItemsListingProvider>(context);
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          leading: InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back, size: 24,)),
          title: Text(widget.fromScreen == "edit"?"Edit Item":"Create Item",),
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CommonTextField(
                    key: const ValueKey("TitleTextField"),
                    textEditingController: titleController,
                    focusNode: titleFocusNode,
                    hintText: "Enter title",
                    labelText: "Enter title",
                    maxLines: 2,
                  ),
                  const SizedBox(height: 20,),
                  CommonTextField(
                    key: const ValueKey("DescriptionTextField"),
                    textEditingController: descriptionController,
                    focusNode: descriptionFocusNode,
                    hintText: "Enter description",
                    labelText: "Enter description",
                    maxLines: 6,
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: ElevatedButton(
            key: const ValueKey("CreateEditItemButton"),
            onPressed: (){
              if(widget.fromScreen == "create"){
                onCreateItem(context, itemsListingProvider);
              }
              else if(widget.fromScreen == "edit"){
                onEditItem(context, itemsListingProvider);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(),
            ),
            child: Text((widget.fromScreen == "create")?"Create Items to track":"Edit item"),
          ),
        ),
      ),
    );
  }

  void onCreateItem(BuildContext context, ItemsListingProvider provider){
    if(formKey.currentState!.validate()){
      provider.addItem(
        ItemDetails(
          title: titleController.text,
          description: descriptionController.text,
        ),
      );
      Navigator.pop(context);
    }
  }

  void onEditItem(BuildContext context, ItemsListingProvider provider){
    if(formKey.currentState!.validate()){
      provider.editItem(
        widget.itemIndex!,
        ItemDetails(
          title: titleController.text,
          description: descriptionController.text,
        ),
      );
      Navigator.pop(context);
    }
  }
}
