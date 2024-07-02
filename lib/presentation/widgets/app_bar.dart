import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snapgallery/domain/entity/pair.dart';
import 'package:snapgallery/domain/entity/topic.dart';
import 'package:snapgallery/presentation/widgets/topic_tab.dart';

class SGAppBar extends StatefulWidget {
  const SGAppBar(
      {super.key,
      required this.tabIndex,
      required this.topics,
      required this.onTabChanged,
      required this.onDrawerTap,
      required this.onSearchTap});

  final int tabIndex;
  final List<Topic> topics;
  final ValueChanged<Pair<int, Topic>> onTabChanged;
  final VoidCallback onDrawerTap;
  final VoidCallback onSearchTap;

  @override
  _AppBarState createState() => _AppBarState();
}

class _AppBarState extends State<SGAppBar> {
  void _onTabChanged(Pair<int, Topic> pair) {}

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 60.0,
      stretch: true,
      floating: true,
      pinned: false,
      snap: false,
      elevation: 10.0,
      backgroundColor: Colors.grey.shade50,
      surfaceTintColor: Colors.grey.shade50,
      scrolledUnderElevation: 8.0,
      centerTitle: true,
      title: Text(
        'Unsplash',
        style: GoogleFonts.ubuntuMono(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: IconButton(
        icon: const Icon(
          CupertinoIcons.rectangle_3_offgrid_fill,
          size: 23,
          color: Colors.black,
        ),
        onPressed: () {
          widget.onDrawerTap();
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(
            CupertinoIcons.search,
            size: 23,
            color: Colors.black,
          ),
          onPressed: () {
            widget.onSearchTap();
          },
        ),
      ],
      bottom: ScrollTabBar(
          tabIndex: widget.tabIndex,
          onTabChanged: widget.onTabChanged,
          topics: widget.topics),
    );
  }
}
