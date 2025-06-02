// Copyright 2020 the Dart project authors.
//
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file or at
// https://developers.google.com/open-source/licenses/bsd

import 'package:flutter/widgets.dart';

import 'builder.dart';
import 'tree_controller.dart';
import 'tree_node.dart';

/// Tree view with collapsible and expandable nodes.
class TreeView extends StatefulWidget {
  const TreeView({
    required this.nodes,
    super.key,
    this.indent = 40,
    this.iconSize,
    this.treeController,
  });

  /// List of root level tree nodes.
  final List<TreeNode> nodes;

  /// Horizontal indent between levels.
  final double? indent;

  /// Size of the expand/collapse icon.
  final double? iconSize;

  /// Tree controller to manage the tree state.
  final TreeController? treeController;

  @override
  TreeViewState createState() => TreeViewState();
}

class TreeViewState extends State<TreeView> {
  late final TreeController? _controller;

  @override
  void initState() {
    _controller = widget.treeController ?? TreeController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildNodes(
      widget.nodes,
      widget.indent,
      _controller!,
      widget.iconSize,
    );
  }
}
