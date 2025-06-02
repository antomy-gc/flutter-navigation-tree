// Copyright 2020 the Dart project authors.
//
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file or at
// https://developers.google.com/open-source/licenses/bsd

import 'package:flutter/material.dart';

import 'tree_controller.dart';
import 'tree_node.dart';

/// Widget that displays one [TreeNode] and its children.
class NodeWidget extends StatefulWidget {
  const NodeWidget({
    required this.treeNode,
    required this.state,
    this.indent,
    this.iconSize,
    super.key,
  });

  final TreeNode treeNode;
  final double? indent;
  final double? iconSize;
  final TreeController state;

  @override
  NodeWidgetState createState() => NodeWidgetState();
}

class NodeWidgetState extends State<NodeWidget> {
  bool get _isLeaf {
    return widget.treeNode.isLeaf();
  }

  bool get _isExpanded {
    return widget.state.isNodeExpanded(widget.treeNode.key!);
  }

  @override
  Widget build(BuildContext context) {
    final icon = _isLeaf
        ? null
        : _isExpanded
            ? Icons.expand_more
            : Icons.chevron_right;

    final onIconPressed = _isLeaf
        ? null
        : () => setState(
              () => widget.state.toggleNodeExpanded(widget.treeNode.key!),
            );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _isLeaf
                ? SizedBox(
                    width: 40,
                    height: 40,
                    child: Center(
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.onSurface,
                          // .custom()!
                          // .indriveColors
                          // .grayscale
                          // .shade9, // TODO(ikuzmin): add override parameter for icon colors
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  )
                : IconButton(
                    iconSize: widget.iconSize ?? 24.0,
                    padding: EdgeInsets.zero,
                    icon: Icon(icon),
                    onPressed: onIconPressed,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface, // TODO(ikuzmin): add override parameter for icon colors
                  ),
            widget.treeNode.content,
          ],
        ),
        if (_isExpanded && !_isLeaf)
          Padding(
            padding: EdgeInsets.only(left: widget.indent!),
            child: widget.treeNode.buildChild(
              widget.indent,
              widget.state,
              widget.iconSize,
            ),
          ),
      ],
    );
  }
}
