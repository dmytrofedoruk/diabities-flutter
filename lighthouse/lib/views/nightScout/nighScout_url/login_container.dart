import 'package:flutter/material.dart';

class NightScoutContainer extends StatelessWidget {
  final Widget heading;
  final Widget form;
  final Widget? footer;
  final Widget? socials;
  final String? subtitleLogin;

  const NightScoutContainer({
    Key? key,
    required this.heading,
    required this.form,
    this.socials,
    this.footer,
    this.subtitleLogin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ThemeData theme = Theme.of(context);
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(25, 150, 25, 0),
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  heading,
                  const SizedBox(height: 30),
                  form,
                  // const SizedBox(height: 23),
                  // Text(subtitleLogin ?? 'or login with', style: theme.textTheme.caption),
                  if (socials != null) const SizedBox(height: 20),
                  if (socials != null) socials!,
                ],
              ),
            ),
          ),
          if (footer != null)
            SliverFillRemaining(
              hasScrollBody: false,
              fillOverscroll: true,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 32, top: 16),
                  child: footer,
                ),
              ),
            )
        ],
      ),
    );
  }
}
