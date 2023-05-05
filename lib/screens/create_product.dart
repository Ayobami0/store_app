import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app/providers/product.dart';
import 'package:store_app/providers/products_provider.dart';

class EditProductScreen extends StatefulWidget {
  static const String routeName = '/editProduct';
  const EditProductScreen({super.key});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final TextEditingController _imageUrlController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  Product _editedProduct =
      Product(id: '', title: '', description: '', amount: 0, imageUrl: '');
  var _initValues = {
    'title': '',
    'price': '',
    'description': '',
    'imageUrl': '',
  };
  bool _isInit = true;

  Future _saveForm() async {
    setState(() {
      _isLoading = true;
    });
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    if (_editedProduct.id.isNotEmpty) {
      try {
        await Provider.of<Products>(context, listen: false)
            .updateProducts(_editedProduct.id, _editedProduct);
      }
      catch(error){
        await showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text('An Error occurred!'),
              content: const Text('Something went wrong'),
              actions: [
                ElevatedButton(
                    onPressed: () => Navigator.pop(ctx),
                    child: const Text('Close'))
              ],
            ));
      }
    } else {
      try {
        await Provider.of<Products>(context, listen: false)
            .addProducts(_editedProduct);
      } catch (error) {
        await showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: const Text('An Error occurred!'),
                  content: const Text('Something went wrong'),
                  actions: [
                    ElevatedButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: const Text('Close'))
                  ],
                ));
      }
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.pop(context);
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context)?.settings.arguments;
      if (productId != null) {
        final product =
            Provider.of<Products>(context, listen: false).findById(productId);
        _editedProduct = product;
        _initValues = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'amount': _editedProduct.amount.toString(),
          'imageUrl': _editedProduct.imageUrl,
        };
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () => _saveForm(),
          )
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextFormField(
                          initialValue: _initValues['title'],
                          decoration: const InputDecoration(labelText: 'Title'),
                          onSaved: (value) {
                            _editedProduct = Product(
                                isFavourite: _editedProduct.isFavourite,
                                id: _editedProduct.id,
                                title: value!,
                                description: _editedProduct.description,
                                amount: _editedProduct.amount,
                                imageUrl: _editedProduct.imageUrl);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a Product title';
                            } else {
                              return null;
                            }
                          },
                          textInputAction: TextInputAction.next,
                        ),
                        TextFormField(
                            initialValue: _initValues['amount'],
                            decoration:
                                const InputDecoration(labelText: 'Price'),
                            onSaved: (value) {
                              _editedProduct = Product(
                                isFavourite: _editedProduct.isFavourite,
                                id: _editedProduct.id,
                                title: _editedProduct.title,
                                description: _editedProduct.description,
                                amount: double.parse(value!),
                                imageUrl: _editedProduct.imageUrl,
                              );
                            },
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a Product price';
                              }
                              if (double.tryParse(value) == null) {
                                return 'The Product price must be a number';
                              }
                              if (double.tryParse(value)! < 1) {
                                return 'Product price must be greater than 0';
                              }
                              return null;
                            }),
                        TextFormField(
                          initialValue: _initValues['description'],
                          maxLines: 3,
                          maxLength: 300,
                          decoration: const InputDecoration(
                            labelText: 'Description',
                          ),
                          onSaved: (value) {
                            _editedProduct = Product(
                                isFavourite: _editedProduct.isFavourite,
                                id: _editedProduct.id,
                                title: _editedProduct.title,
                                description: value!,
                                amount: _editedProduct.amount,
                                imageUrl: _editedProduct.imageUrl);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a Product Description';
                            }
                            if (value.length < 10) {
                              return 'Product description must be at least 10 characters';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.multiline,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 8, right: 10),
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey, width: 1)),
                              child: _imageUrlController.text.isEmpty
                                  ? const Text('Enter a Url')
                                  : Image.network(
                                      _imageUrlController.text,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            Expanded(
                              child: TextFormField(
                                maxLines: 3,
                                decoration: const InputDecoration(
                                  labelText: 'Image Url',
                                ),
                                onSaved: (value) {
                                  _editedProduct = Product(
                                    isFavourite: _editedProduct.isFavourite,
                                    id: _editedProduct.id,
                                    title: _editedProduct.title,
                                    description: _editedProduct.description,
                                    amount: _editedProduct.amount,
                                    imageUrl: value!,
                                  );
                                },
                                keyboardType: TextInputType.url,
                                textInputAction: TextInputAction.done,
                                controller: _imageUrlController,
                                onFieldSubmitted: (_) {
                                  _saveForm();
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a Product Image URL';
                                  }
                                  if (value.startsWith('http') &&
                                      !value.startsWith('https')) {
                                    return 'Invalid url entered. NOTE: URL must start with https';
                                  }
                                  if (!value.startsWith('https')) {
                                    return 'Invalid image url entered.';
                                  }
                                  return null;
                                },
                                onEditingComplete: () {
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
            ),
    );
  }
}
