import 'package:flutter/material.dart';

class EditProduct extends StatefulWidget {
  static const routeName = 'edit-product';

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageurlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();

  @override
  void initState() {
    _imageurlFocusNode.addListener(_imageUrlChanged);
    super.initState();
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageurlFocusNode.dispose();
    _imageUrlController.dispose();
    _imageurlFocusNode.removeListener(_imageUrlChanged);

    super.dispose();
  }

  void _imageUrlChanged() {
    if (!_imageurlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Product',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
            child: ListView(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                label: Text('Title'),
              ),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_priceFocusNode);
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                label: Text('Price'),
              ),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              focusNode: _priceFocusNode,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_descriptionFocusNode);
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                label: Text('Description'),
              ),
              maxLines: 3,
              keyboardType: TextInputType.multiline,
              focusNode: _descriptionFocusNode,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.only(
                    top: 8,
                    right: 5,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  child: _imageUrlController.text.isEmpty
                      ? const Text('Enter URL')
                      : FittedBox(
                          fit: BoxFit.cover,
                          child: Image.network(
                            _imageUrlController.text,
                          ),
                        ),
                ),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      label: Text('Image Url'),
                    ),
                    keyboardType: TextInputType.url,
                    textInputAction: TextInputAction.done,
                    focusNode: _imageurlFocusNode,
                    controller: _imageUrlController,
                  ),
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }
}
