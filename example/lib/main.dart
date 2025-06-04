import 'package:flutter/material.dart';
import 'package:flutter_navigation_tree/tree_controller.dart';
import 'package:flutter_navigation_tree/tree_node.dart';
import 'package:flutter_navigation_tree/tree_view.dart';

void main() => runApp(const Demo());

class Demo extends StatelessWidget {
  const Demo({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TreeController(allNodesExpanded: false);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('TreeView demo')),
        body: TreeView(
          treeController: controller,
          nodes: [
            TreeNode(
              content: const Text('Root'),
              key: ValueKey('root'),
              children: [
                TreeNode(
                  key: ValueKey('child-1'),
                  content: const Text('Child 1'),
                ),
                FutureTreeNode(
                  key: ValueKey('child-2'),
                  content: const Text('Child 2'),
                  childrenBuilder: () => Future.delayed(Duration(seconds: 1), () => [
                    TreeNode(
                      key: ValueKey('grand-1'),
                      content: const Text('Grandchild 1'),
                    ),
                    TreeNode(
                      key: ValueKey('grand-2'),
                      content: const Text('Grandchild 2'),
                    ),
                  ]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}