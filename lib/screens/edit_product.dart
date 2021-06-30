import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tagging/flutter_tagging.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopat_seller/firebase_repository/auth.dart';
import 'package:shopat_seller/firebase_repository/src/entities/product_entity.dart';
import 'package:shopat_seller/firebase_repository/src/firestore_service.dart';
import 'package:shopat_seller/global/colors.dart';

class EditProductPage extends StatefulWidget {
  final ProductEntity product;

  EditProductPage({Key? key, required this.product}) : super(key: key);

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  TextEditingController _name = TextEditingController();
  TextEditingController _desc1 = TextEditingController();
  TextEditingController _desc2 = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _quantity = TextEditingController();

  bool _isSubmitLoading = false;
  String _selectedValuesJson = 'Nothing to show';
  late final List<Tag> _selectedTags;
  late List<String> _tagsListGoingtToDb = [];
  File _imageFile = File("");

  final picker = ImagePicker();

  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = File(pickedFile!.path);
      print("Path: ${pickedFile.path}");
    });
  }

  @override
  void initState() {
    super.initState();
    _name.text = widget.product.productName;
    _desc1.text = widget.product.description1;
    _desc2.text = widget.product.description2;
    _quantity.text = widget.product.quantityAvailable.toString();
    _price.text = widget.product.costPrice.toString();
    _selectedTags = [];
  }

  @override
  void dispose() {
    _selectedTags.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(FeatherIcons.arrowLeft),
                ),
                Text(
                  "Add a new product",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 18.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(
                          "Item Name",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF393D46),
                          ),
                        ),
                      ),
                      TextField(
                        controller: _name,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "Add name of the item",
                          hintStyle: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF393D46).withOpacity(0.60),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Color(0xFF393D46).withOpacity(0.60),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Color(0xFF393D46).withOpacity(0.15),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(
                          "Description",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF393D46),
                          ),
                        ),
                      ),
                      TextField(
                        controller: _desc1,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "Description Line 1",
                          hintStyle: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF393D46).withOpacity(0.60),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Color(0xFF393D46).withOpacity(0.60),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Color(0xFF393D46).withOpacity(0.15),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      TextField(
                        controller: _desc2,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "Description Line 2",
                          hintStyle: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF393D46).withOpacity(0.60),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Color(0xFF393D46).withOpacity(0.60),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Color(0xFF393D46).withOpacity(0.15),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(
                          "Price",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF393D46),
                          ),
                        ),
                      ),
                      TextField(
                        controller: _price,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "Price to display",
                          hintStyle: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF393D46).withOpacity(0.60),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Color(0xFF393D46).withOpacity(0.60),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Color(0xFF393D46).withOpacity(0.15),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(
                          "Quantity",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF393D46),
                          ),
                        ),
                      ),
                      TextField(
                        controller: _quantity,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "Quantity (max. 20)",
                          hintStyle: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF393D46).withOpacity(0.60),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Color(0xFF393D46).withOpacity(0.60),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Color(0xFF393D46).withOpacity(0.15),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Container(
                              child: _imageFile.path == ""
                                  ? Image.network(
                                      widget.product.image,
                                      height: 120.0,
                                      width: 120.0,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.file(
                                      _imageFile,
                                      height: 120.0,
                                      width: 120.0,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          SizedBox(
                            width: 16.0,
                          ),
                          InkWell(
                            onTap: () async {
                              await pickImage();
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Container(
                                  height: 120.0,
                                  width: 120.0,
                                  color: Colors.white,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(FeatherIcons.image),
                                      SizedBox(
                                        height: 8.0,
                                      ),
                                      Text(
                                        "Upload a picture",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFF393D46),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FlutterTagging<Tag>(
                          initialItems: _selectedTags,
                          textFieldConfiguration: TextFieldConfiguration(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              filled: true,
                              fillColor: Colors.green.withAlpha(30),
                              hintText: 'Add Tags',
                              labelText: 'Add Tags',
                            ),
                          ),
                          findSuggestions: TagService.getTags,
                          additionCallback: (value) {
                            return Tag(
                              name: value,
                            );
                          },
                          onAdded: (language) {
                            // api calls here, triggered when add to tag button is pressed
                            return language;
                          },
                          configureSuggestion: (tag) {
                            return SuggestionConfiguration(
                              title: Text(tag.name),
                              additionWidget: Chip(
                                avatar: Icon(
                                  Icons.add_circle,
                                  color: Colors.white,
                                ),
                                label: Text('Add New Tag'),
                                labelStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w300,
                                ),
                                backgroundColor: Colors.green,
                              ),
                            );
                          },
                          configureChip: (lang) {
                            return ChipConfiguration(
                              label: Text(lang.name),
                              backgroundColor: Colors.green,
                              labelStyle: TextStyle(color: Colors.white),
                              deleteIconColor: Colors.white,
                            );
                          },
                          onChanged: () {
                            setState(() {
                              _selectedValuesJson = _selectedTags
                                  .map<String>((lang) => '\n${lang.toJson()}')
                                  .toList()
                                  .toString();
                              _selectedValuesJson = _selectedValuesJson
                                  .replaceFirst('}]', '}\n]');
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                      Center(
                        child: InkWell(
                          onTap: () async {
                            if (!_isSubmitLoading) {
                              setState(() {
                                _isSubmitLoading = true;
                              });
                              for (var i in _selectedTags) {
                                _tagsListGoingtToDb.add(i.name);
                              }
                              if (_name.text.length > 0 &&
                                  _desc1.text.length > 0 &&
                                  _desc2.text.length > 0 &&
                                  _price.text.length > 0 &&
                                  _quantity.text.length > 0 &&
                                  int.parse(_quantity.text) <= 20) {
                                String imageUrl = "";
                                if (_imageFile.path.length > 1) {
                                  imageUrl =
                                      await FirestoreService().uploadImage(
                                    file: _imageFile,
                                  );
                                } else {
                                  imageUrl = widget.product.image;
                                }

                                var result =
                                    await FirestoreService().editProduct(
                                  product: ProductEntity(
                                    widget.product.id,
                                    _name.text,
                                    AuthService().getUserId() ?? "",
                                    _desc1.text,
                                    _desc2.text,
                                    imageUrl,
                                    int.parse(_price.text),
                                    0,
                                    int.parse(_quantity.text),
                                    _tagsListGoingtToDb,
                                    AuthService().getPhoneNumber() ?? "",
                                    DateTime.now().toString(),
                                    "Pending",
                                  ),
                                );
                                if (result['res'] == true) {
                                  Navigator.pop(context, 'success');
                                }
                              } else {
                                BotToast.showText(
                                    text: 'Please check all details');
                              }
                              setState(() {
                                _isSubmitLoading = false;
                              });
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            width: MediaQuery.of(context).size.width * 0.40,
                            height: 50.0,
                            decoration: BoxDecoration(
                              color: AppColors.accentColor,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  _isSubmitLoading
                                      ? Text(
                                          "Submitting ...",
                                          style: TextStyle(
                                            fontFamily: "Poppins",
                                            color: Colors.white,
                                          ),
                                        )
                                      : Text(
                                          "Submit",
                                          style: TextStyle(
                                            fontFamily: "Poppins",
                                            color: Colors.white,
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TagService {
  /// Mocks fetching language from network API with delay of 500ms.
  static Future<List<Tag>> getTags(String query) async {
    await Future.delayed(Duration(milliseconds: 500), null);
    return <Tag>[
      Tag(name: 'kirana'),
      Tag(name: 'clothing'),
      Tag(name: 'shoes'),
      Tag(name: 'bakery'),
    ]
        .where((lang) => lang.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}

class Tag extends Taggable {
  ///
  final String name;

  /// Creates Language
  Tag({
    required this.name,
  });

  @override
  List<Object> get props => [name];

  /// Converts the class to json string.
  String toJson() => '''  {
    "name": $name,
  }''';
}
