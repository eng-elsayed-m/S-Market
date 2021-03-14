import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/product_detail_screen.dart';

class EditProductScreen extends StatefulWidget {
  static const nav = "/edit-product";

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _priceNode = FocusNode();
  final _descriptionNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _inputDec = InputDecoration(
    labelStyle: TextStyle(color: Color(0xFFfb743e), fontSize: 30),
    
  );
  String _title = "";
  String _description = "";
  String _price = "";
  @override
  void initState() {
    super.initState();
    _imageUrlFocusNode.addListener(_updatePreview);
  }

  void _updatePreview() {
    if (!_imageUrlFocusNode.hasFocus) {
      if (validateImage(_imageUrlController.text)) {
        setState(() {});
      }
    }
  }

  bool validateImage(String text) {
    if (text.isEmpty) {
      return false;
    }
    if (!text.startsWith("http") && !text.startsWith("https") ||
        !text.endsWith(".jpg") &&
            !text.endsWith(".jpeg") &&
            !text.endsWith(".png")) {
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    super.dispose();
    _imageUrlFocusNode.removeListener(_updatePreview);
    _priceNode.dispose();
    _descriptionNode.dispose();
    _imageUrlFocusNode.dispose();
    _imageUrlController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final product = Provider.of<Products>(context).searchItem(id);
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          title: Text("Edit Prouct"),
          elevation: 0,
          actions: [
            IconButton(
                icon: Icon(Icons.done_outline_outlined),
                onPressed: () {
                  _formKey.currentState.save();
                  if (!_formKey.currentState.validate()) {
                    return;
                  }
                  Provider.of<Products>(context, listen: false).editProduct(
                    id,
                      Product(
                          id: id,
                          price: double.parse(_price),
                          description: _description,
                          title: _title,
                          imageUrl: validateImage(_imageUrlController.text)
                              ? _imageUrlController.text
                              : product.imageUrl));
                  Navigator.of(context)
                      .popAndPushNamed(ProductDetailScreen.nav, arguments: id);
                }),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 10.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  decoration: _inputDec.copyWith(
                    labelText: "Title ",
                  ),
                  style: TextStyle(color: Colors.white,fontSize: 20),
                  initialValue: product.title,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) =>
                      FocusScope.of(context).requestFocus(_priceNode),
                  onSaved: (val) {
                    _title = val;
                  },
                  validator: (text) {
                    if (text.isEmpty) {
                      return "Tile is empty";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: _inputDec.copyWith(
                    labelText: "Price ",
                  ),
                  style: TextStyle(color: Colors.white,fontSize: 20),
                  initialValue: product.price.toString(),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _priceNode,
                  onFieldSubmitted: (_) =>
                      FocusScope.of(context).requestFocus(_descriptionNode),
                  onSaved: (val) {
                    _price = val;
                  },
                  validator: (text) {
                    if (text.isEmpty) {
                      return "Price is empty";
                    }
                    if (double.tryParse(text) == null) {
                      return "Please enter valid value";
                    }
                    if (double.parse(text) <= 0) {
                      return "price can't be smaller or equal zero ,bitch !";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: _inputDec.copyWith(
                    labelText: "Description ",
                  ),
                  style: TextStyle(color: Colors.white,fontSize: 20),
                  initialValue: product.description,
                  keyboardType: TextInputType.multiline,
                  focusNode: _descriptionNode,
                  onSaved: (val) {
                    _description = val;
                  },
                  validator: (text) {
                    if (text.isEmpty) {
                      return "Description is empty";
                    }
                    if (text.length < 10) {
                      return "can't be less than 10 character";
                    }
                    return null;
                  },
                  maxLines: 3,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(top: 10, right: 10),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.red,
                              width: 1,
                              style: BorderStyle.solid)),
                      child: FittedBox(
                          child: Image.network(
                            _imageUrlController.text.isEmpty
                                ? product.imageUrl
                                : _imageUrlController.text,
                          )),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(hintText: "Image url",
                          labelText: "if empty or invalid image won't change ",
                          labelStyle: TextStyle(fontSize: 12,color: Colors.white)),
                        style: TextStyle(color: Colors.white,fontSize: 23),
                        keyboardType: TextInputType.url,
                        focusNode: _imageUrlFocusNode,
                        controller: _imageUrlController,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
