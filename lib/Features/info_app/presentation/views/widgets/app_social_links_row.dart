import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'social_media_icon.dart';

class AppSocialLinksRow extends StatelessWidget {
  const AppSocialLinksRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialMediaIcon(
          icon: Icons.language,
          onTap: () => launchUrl(Uri.parse('https://www.moit.gov.ye/ar')),
        ),
        const SizedBox(width: 20),
        SocialMediaIcon(
          icon: FontAwesomeIcons.facebookF,
          onTap: () => launchUrl(Uri.parse(
              'https://www.facebook.com/profile.php?id=100089662458637&mibextid=ZbWKwL')),
        ), // فيسبوك),
        const SizedBox(width: 20),
        SocialMediaIcon(
          icon: FontAwesomeIcons.xTwitter,
          onTap: () => launchUrl(Uri.parse(
              'https://x.com/MOITNewsYE?t=AQabJlFLAiJK0KhoOvb7gg&s=08')),
        ),
      ],
    );
  }
}
