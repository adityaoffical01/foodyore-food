import 'package:flutter/material.dart';

import 'package:foodyore/utils/Colors/AppColors.dart';
import 'package:foodyore/utils/helpers/App_Content.dart';
import 'package:foodyore/utils/helpers/Custom/Custom_AppBar.dart';
import 'package:foodyore/utils/styles/Text_Styles.dart';

class TermsConditionWidget extends StatelessWidget {
  const TermsConditionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: const CustomAppbar(title: 'Terms & Condition'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [_TermsBody()],
        ),
      ),
    );
  }
}

class _TermsBody extends StatelessWidget {
  const _TermsBody();

  @override
  Widget build(BuildContext context) {
    return Text(
      _termsText,
      style: AppTextStyles.caption.copyWith(
        color: AppColors.black,
        fontFamily: AppFonts.regular,
      ),
    );
  }
}

const String _termsText = '''
www.eatind.com platform is owned and operated by VEETHEE VIHARAN Pvt. Ltd. (VEETHEE VIHARAN) situated at Farm Chandrakanta, Chandrika Devi Road, Kathwara, Bakshi Ka Talab, Lucknow.

VEETHEE VIHARAN provides an online platform and services that connect customers (“CUSTOMERS”) with the “HOST” (collectively, the “Services”), accessible through www.EATIND.com and related applications.

By using the Site and Application, you agree to comply with and be legally bound by these Terms of Service (“Terms”), whether or not you become a registered user.

If you do not agree to these Terms, you have no right to use the Site or Application.


2. Definitions
“HOST” means the lawful owner or person in possession of property, farmland, restaurant, equipment, machinery or vehicles.
“CUSTOMER(S)” means a person booking services displayed on VEETHEE VIHARAN.
“Services” include dining, visiting host premises, entertainment activities and related offerings.
“Tax” includes GST, VAT or any other government levy.


3. Eligibility
You must be at least eighteen (18) years of age and legally capable of entering into this agreement.


4. Use of the Website
Users shall not upload, publish, transmit or share any content that:
• violates any law
• is harmful, obscene, defamatory or abusive
• infringes intellectual property
• harms minors
• contains malware or viruses
• threatens national integrity or public order

5. Remedies
VEETHEE VIHARAN reserves the right to remove content, suspend accounts or take legal action for violations.

6. Registration
Certain services require account registration with accurate and updated information.

7. Ownership
All platform content, trademarks and intellectual property belong to VEETHEE VIHARAN or its licensors.

8. Website Policy
Copyright infringement complaints must be reported to the Grievance Officer with proper documentation.

9. Third Party Liability
VEETHEE VIHARAN is not responsible for agreements or disputes between HOSTs and CUSTOMERS.

10. Disclaimer
The website is provided “AS IS” without warranties of any kind. Use is at your own risk.

11. Limitation of Liability
Liability is limited to the amount paid by the user in the one month preceding the claim.

12. Indemnity
Users agree to indemnify VEETHEE VIHARAN against claims arising from misuse of the platform.

13. Privacy
Use of the Website is governed by the Privacy Policy.

14. Consent
By using the service, you consent to communication via third-party channels.

15. Confidentiality
Users must protect confidential information and not disclose it unlawfully.

16. Miscellaneous
These Terms are governed by Indian law, with jurisdiction in Lucknow.

17. Third-Party Links
VEETHEE VIHARAN is not responsible for content on external sites.

18. Refund Policy
Refunds are granted at the sole discretion of VEETHEE VIHARAN management.

19. Grievance Officer
Name: Sandeep Srivastava  
Email: sandeep@eatind.com
''';
