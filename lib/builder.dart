// Copyright 2020 the Dart project authors.
//
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file or at
// https://developers.google.com/open-source/licenses/bsd

import 'package:flutter/material.dart';

import 'tree_controller.dart';
import 'tree_node.dart';
import 'tree_node_widget.dart';

Widget buildNodes(
  Iterable<TreeNode> nodes,
  double? indent,
  TreeController state,
  double? iconSize,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      for (final node in nodes)
        NodeWidget(
          treeNode: node,
          indent: indent,
          state: state,
          iconSize: iconSize,
        ),
    ],
  );
}
