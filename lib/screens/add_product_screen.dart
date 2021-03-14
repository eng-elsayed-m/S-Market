import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products.dart';

class AddProductScreen extends StatefulWidget {
  static const nav = "/add-product";

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final _priceNode = FocusNode();
  final _descriptionNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _inputDec = InputDecoration(
    labelStyle: TextStyle(color: Color(0xFFfb743e), fontSize: 30),
  );
  String _title = "";
  String _description = "";
  double _price = 0.0;

  @override
  void initState() {
    super.initState();
    _imageUrlFocusNode.addListener(_updatePreview);
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updatePreview);
    _priceNode.dispose();
    _descriptionNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _updatePreview() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          title: Text("Add Product"),
          elevation: 0,
          actions: [
            IconButton(
                icon: Icon(Icons.done_outline_outlined),
                onPressed: () {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }
                  _formKey.currentState.save();
                  Provider.of<Products>(context, listen: false).addProduct(
                      Product(
                          id: null,
                          imageUrl: _imageUrlController.text,
                          title: _title,
                          description: _description,
                          price: _price));
                  Navigator.of(context).pop();
                }),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  decoration: _inputDec.copyWith(
                    labelText: "Title ",
                  ),
                  style: TextStyle(color: Colors.white, fontSize: 20),
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
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _priceNode,
                  onFieldSubmitted: (_) =>
                      FocusScope.of(context).requestFocus(_descriptionNode),
                  onSaved: (val) {
                    _price = double.parse(val);
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
                    style: TextStyle(color: Colors.white, fontSize: 20),
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
                    maxLines: 3),
                SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.red,
                              width: 1,
                              style: BorderStyle.solid)),
                      child: _imageUrlController.text.isEmpty
                          ? Text("Add image Url")
                          : FittedBox(
                              child: Image.network(
                              _imageUrlController.text,
                              fit: BoxFit.contain,
                            )),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                            labelText: "Image url",
                            labelStyle:
                                TextStyle(fontSize: 12, color: Colors.white)),
                        style: TextStyle(color: Colors.white, fontSize: 23),
                        keyboardType: TextInputType.url,
                        controller: _imageUrlController,
                        focusNode: _imageUrlFocusNode,
                        validator: (text) {
                          if (text.isEmpty) {
                            return "Enter image url";
                          }
                          if (!text.startsWith("http") &&
                                  !text.startsWith("https") ||
                              !text.endsWith(".jpg") &&
                                  !text.endsWith(".jpeg") &&
                                  !text.endsWith(".png")) {
                            return "enter a valid image url";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
