// Copyright (c) 2018, the Zefyr project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zefyr/zefyr.dart';

/// Custom image delegate used by this example to load image from application
/// assets.
class CustomImageDelegate implements ZefyrImageDelegate<ImageSource> {
  @override
  ImageSource get cameraSource => ImageSource.camera;

  @override
  ImageSource get gallerySource => ImageSource.gallery;

  @override
  ImageSource get unsplashSource => throw UnimplementedError();

  @override
  Future<String> pickImage(_, ImageSource source) async {
    final file = await ImagePicker.pickImage(source: source);
    if (file == null) return null;
    return file.uri.toString();
  }

  @override
  Widget buildImage(BuildContext context, String key) {
    // print('buildImage key: $key');
    // final url = key.replaceFirst('image:', '');
    return Image.network(
        'https://firebasestorage.googleapis.com/v0/b/kilmaapp.appspot.com/o/users%2F9ukEt3oZUGUdzHz2JhElKKkGuw42%2Fimages%2FoJ%40VaWlNu%23un(qbvAboqHkBg)%401000.jpeg?alt=media');

    // We use custom "asset" scheme to distinguish asset images from other files.
    // if (key.startsWith('asset://')) {
    //   final asset = AssetImage(key.replaceFirst('asset://', ''));
    //   return Image(image: asset);
    // } else {
    //   // Otherwise assume this is a file stored locally on user's device.
    //   final file = File.fromUri(Uri.parse(key));
    //   final image = FileImage(file);
    //   return Image(image: image);
    // }
  }
}
