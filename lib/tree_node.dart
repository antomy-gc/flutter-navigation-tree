// Copyright 2020 the Dart project authors.
//
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file or at
// https://developers.google.com/open-source/licenses/bsd

import 'package:flutter/material.dart';

import 'builder.dart';
import 'tree_controller.dart';

class TreeNode {
  TreeNode({required this.key, this.children, Widget? content})
      : content = content ?? const SizedBox.shrink();

  final List<TreeNode>? children;
  final Widget content;
  final Key? key;

  Widget buildChild(double? indent, TreeController state, double? iconSize) {
    return children != null
        ? buildNodes(children!, indent, state, iconSize)
        : const SizedBox.shrink();
  }

  bool isLeaf() {
    return children == null;
  }
}

class FutureTreeNode extends TreeNode {
  FutureTreeNode({
    required super.key,
    this.childrenBuilder,
    super.content,
  });

  final Future<List<TreeNode>> Function()? childrenBuilder;
  Future<List<TreeNode>>? _cachedFuture;

  @override
  Widget buildChild(double? indent, TreeController state, double? iconSize) {
    if (childrenBuilder == null) return const SizedBox.shrink();

    _cachedFuture ??= childrenBuilder!();

    return FutureBuilder<List<TreeNode>>(
      future: _cachedFuture,
      builder: (context, snapshot) {
        return snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData
            ? buildNodes(snapshot.data!, indent, state, iconSize)
            : const Progress();
      },
    );
  }

  @override
  bool isLeaf() {
    return childrenBuilder == null;
  }
}

class Progress extends StatelessWidget {
  const Progress({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: RepaintBoundary(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
