import 'dart:math';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/gen/assets.gen.dart';
import 'package:whatsapp_clone/models/status_model/status_model.dart';
import 'package:whatsapp_clone/res/colors.dart';

import 'package:whatsapp_clone/res/extensions.dart';
import 'package:whatsapp_clone/views/components/custom_tile.dart';

import 'package:whatsapp_clone/views/tabs/status/mock_list.dart';

class StatusTabView extends StatelessWidget {
  const StatusTabView({Key? key}) : super(key: key);

  Widget _myStatusWidget(BuildContext context) {
    return StatusTile(
      statusModel: myStatusModel,
      trailing: IconButton(
        color: context.secondaryColor,
        icon: const Icon(Icons.more_horiz),
        onPressed: () {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomScrollView(
          shrinkWrap: true,
          slivers: [
            SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ),
            SliverToBoxAdapter(child: _myStatusWidget(context)),
            const SliverToBoxAdapter(
                child: StatusUpdatesText(title: 'Recent Updates')),
            SliverList(
                delegate: SliverChildBuilderDelegate(
              (_, index) {
                final user = mockStatus[index];
                return StatusTile(
                  statusModel: user,
                  onTap: () {},
                );
              },
              childCount: mockStatus.length,
            )),
            const SliverToBoxAdapter(
                child: StatusUpdatesText(title: 'Seen Status')),
            SliverList(
                delegate: SliverChildBuilderDelegate(
              (_, index) {
                final user = mockStatus[index];
                return StatusTile(
                  statusModel: user,
                  onTap: () {},
                );
              },
              childCount: mockStatus.length,
            )),
          ],
        ),
        Positioned(
          bottom: 15,
          right: 10,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const AnimatedEditButton(),
              const SizedBox(height: 10),
              FloatingActionButton(
                  onPressed: () {}, child: const Icon(Icons.camera_alt)),
            ],
          ),
        ),
      ],
    );
  }
}

class AnimatedEditButton extends StatefulWidget {
  const AnimatedEditButton({
    Key? key,
  }) : super(key: key);

  @override
  State<AnimatedEditButton> createState() => _AnimatedEditButtonState();
}

class _AnimatedEditButtonState extends State<AnimatedEditButton> {
  double _dy = 1;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(
          const Duration(milliseconds: 300), () => setState(() => _dy = 0));
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      duration: const Duration(milliseconds: 500),
      curve: Curves.decelerate,
      offset: Offset(0, _dy),
      child: Material(
          shape: const CircleBorder(),
          color: kBitDarkGrey,
          clipBehavior: Clip.hardEdge,
          elevation: 4,
          child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.edit, color: kBlackColor))),
    );
  }
}

class StatusUpdatesText extends StatelessWidget {
  const StatusUpdatesText({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      width: double.infinity,
      color: const Color(0xFFE4E4E4),
      child: Text(title,
          style: context.style.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              letterSpacing: 0.4,
              color: context.style.bodySmall!.color)),
    );
  }
}

class StatusTile extends CustomTile<StatusModel> {
  const StatusTile({
    Key? key,
    required StatusModel statusModel,
    this.trailing,
    VoidCallback? onTap,
    VoidCallback? onLongTap,
  }) : super(key: key, model: statusModel, onTap: onTap, onLongTap: onLongTap);
  final Widget? trailing;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      onLongPress: onLongTap,
      leading: LayoutBuilder(builder: (context, constraints) {
        var diameter = constraints.maxHeight;
        var defaultSpace = 4.0;
        return DottedBorder(
            borderType: BorderType.Circle,
            dashPattern: [
              (pi * diameter) / model.totalStatusCount - defaultSpace,
              defaultSpace,
            ],
            strokeWidth: 2.5,
            color: context.secondaryColor,
            padding: const EdgeInsets.all(4),
            child: Assets.images.avatar.image());
      }),
      title: Text(model.postedBy),
      subtitle: Text(model.time),
      trailing: trailing,
    );
  }
}
