import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entity/pair.dart';
import '../../domain/entity/topic.dart';

class ScrollTabBar extends StatelessWidget implements PreferredSizeWidget {
  const ScrollTabBar(
      {Key? key,
      required this.tabIndex,
      required this.onTabChanged,
      required this.topics})
      : super(key: key);

  final int tabIndex;
  final List<Topic> topics;
  final ValueChanged<Pair<int, Topic>> onTabChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: topics.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (ctx, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    onTabChanged(Pair(index, topics[index]));
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.all(5),
                    constraints: const BoxConstraints(
                        minWidth: 50,
                        minHeight: 34,
                        maxWidth: 180,
                        maxHeight: 34),
                    decoration: BoxDecoration(
                      color:
                          tabIndex == index ? Colors.white70 : Colors.white54,
                      borderRadius: BorderRadius.circular(5),
                      border: tabIndex == index
                          ? Border.all(color: Color(0xFFBDBDBD), width: 1.2)
                          : Border.all(color: Color(0xFFFFFFFF), width: 1.2),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            topics[index].title,
                            style: GoogleFonts.ubuntu(
                              fontWeight: FontWeight.w500,
                              color: tabIndex == index
                                  ? Colors.black
                                  : Colors.grey.shade400,
                            ),
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
