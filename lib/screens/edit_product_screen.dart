import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/book_model.dart';
import '../providers/book_provider.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({Key? key}) : super(key: key);

  static const routName = '/edit-product';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _form = GlobalKey<FormState>();
  final _imageForm = GlobalKey<FormState>();

  var _product = BookModel(
    id: '',
    title: '',
    description: '',
    price: 0.0,
    imageUrl: '',
    authorId: '0',
    rating: 0,
  );

  var _hasImage = true;
  var _init = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (_init) {
      final productId = ModalRoute.of(context)!.settings.arguments;
      if (productId != null) {
        // get info from old products
        final _editingProduct =
            Provider.of<BookProvider>(context).findById(productId as String);
        _product = _editingProduct;
      }
    }

    _init = false;
  }

  void _showImageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Rasm URLni kiriting.'),
          content: Form(
            key: _imageForm,
            child: TextFormField(
              initialValue: _product.imageUrl,
              decoration: const InputDecoration(
                labelText: 'Rasm URL',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.url,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Iltimos, mahsulot havolasini kiriting.';
                } else if (!value.startsWith('http')) {
                  return 'Mahsulotni URLini kiritng.';
                }
              },
              onSaved: (newValue) {
                _product = BookModel(
                  id: _product.id,
                  title: _product.title,
                  description: _product.description,
                  price: _product.price,
                  imageUrl: newValue!,
                  authorId: _product.authorId,
                  rating: _product.rating,
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('BEKOR QILISH'),
            ),
            ElevatedButton(
              onPressed: _saveImageForm,
              child: const Text('SAQLASH'),
            ),
          ],
        );
      },
    );
  }

  void _saveImageForm() {
    final isValid = _imageForm.currentState!.validate();
    if (isValid) {
      _imageForm.currentState!.save();
      setState(() {
        _hasImage = true;
      });
      Navigator.of(context).pop();
      setState(() {});
    }
  }

  Future<void> _saveForm() async {
    FocusScope.of(context).unfocus();
    final isValid = _form.currentState!.validate();
    setState(() {
      _hasImage = _product.imageUrl.isNotEmpty;
    });
    if (isValid && _hasImage) {
      _form.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      if (_product.id.isEmpty) {
        try {
          await Provider.of<BookProvider>(context, listen: false)
              .addProduct(_product);
        } catch (error) {
          await showDialog<Null>(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: const Text('Xatolik!'),
                content:
                    const Text('Mahsulot qo\'shishda xatolik sodir bo\'ldi'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    child: const Text('Oynani yopish'),
                  ),
                ],
              );
            },
          );
        }
      } else {
        try {
          await Provider.of<BookProvider>(context, listen: false)
              .updateProduct(_product);
        } catch (e) {
          await showDialog<Null>(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: const Text('Xatolik!'),
                content: const Text(
                    'Mahsulotni o\'zgartirishda xatolik sodir bo\'ldi'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    child: const Text('Oynani yopish'),
                  ),
                ],
              );
            },
          );
        }
      }
      setState(() {
        _isLoading = false;
      });

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Mahsulot qo\'shish'),
        actions: [
          IconButton(
            onPressed: () => _saveForm(),
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GestureDetector(
              onDoubleTap: () => FocusScope.of(context).unfocus(),
              child: Form(
                key: _form,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: _product.title,
                        decoration: const InputDecoration(
                          labelText: 'Nomi',
                          border: OutlineInputBorder(),
                        ),
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Iltimos mahsulot nomini kiriting.';
                          }
                        },
                        onSaved: (newValue) {
                          _product = BookModel(
                            id: _product.id,
                            title: newValue!,
                            description: _product.description,
                            price: _product.price,
                            imageUrl: _product.imageUrl,
                            authorId: _product.authorId,
                            rating: _product.rating,
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        initialValue: _product.price == 0
                            ? ''
                            : _product.price.toStringAsFixed(2),
                        decoration: const InputDecoration(
                          labelText: 'Narxi',
                          border: OutlineInputBorder(),
                        ),
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Iltimos mahsulot narxini kiriting.';
                          } else if (double.tryParse(value) == null) {
                            return 'To\'g\'ri narxi kiriting.';
                          } else if (double.parse(value) < 1) {
                            return 'Mahsulot narxi 0dan katta bo\'lishi kerak';
                          }
                        },
                        onSaved: (newValue) {
                          _product = BookModel(
                            id: _product.id,
                            title: _product.title,
                            description: _product.description,
                            price: double.parse(newValue!),
                            imageUrl: _product.imageUrl,
                            authorId: _product.authorId,
                            rating: _product.rating,
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        initialValue: _product.description,
                        decoration: const InputDecoration(
                          labelText: 'Tarifi',
                          border: OutlineInputBorder(),
                          alignLabelWithHint: true,
                        ),
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Iltimos mahsulot tarifini kiriting.';
                          } else if (value.length < 10) {
                            return 'Iltimos, batafsil ma\'lumot kiriting.';
                          }
                        },
                        onSaved: (newValue) {
                          _product = BookModel(
                            id: _product.id,
                            title: _product.title,
                            description: newValue!,
                            price: _product.price,
                            imageUrl: _product.imageUrl,
                            authorId: _product.authorId,
                            rating: _product.rating,
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        initialValue: _product.rating == 0
                            ? ''
                            : _product.rating.toString(),
                        decoration: const InputDecoration(
                          labelText: 'Reyting',
                          border: OutlineInputBorder(),
                        ),
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Iltimos mahsulot reytingini kiriting.';
                          } else if (int.parse(value) < 0 ||
                              int.parse(value) > 5) {
                            return 'Mahsulot reytingi 0dan katta 5dan kichik bo\'lishi kerak';
                          }
                        },
                        onSaved: (newValue) {
                          _product = BookModel(
                            id: _product.id,
                            title: _product.title,
                            description: _product.description,
                            price: _product.price,
                            imageUrl: _product.imageUrl,
                            authorId: _product.authorId,
                            rating: int.parse(newValue!),
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      Card(
                        margin: const EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: BorderSide(
                            color: _hasImage
                                ? Colors.grey
                                : Theme.of(context).errorColor,
                          ),
                        ),
                        child: InkWell(
                          onTap: () => _showImageDialog(context),
                          splashColor:
                              Theme.of(context).primaryColor.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(5),
                          highlightColor: Colors.transparent,
                          child: Container(
                            height: 180,
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: _product.imageUrl.isEmpty
                                ? Text(
                                    'Asosiy rasm URL-ni kiriting.',
                                    style: TextStyle(
                                      color: _hasImage
                                          ? Colors.black
                                          : Theme.of(context).errorColor,
                                    ),
                                  )
                                : Image.network(
                                    _product.imageUrl,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
