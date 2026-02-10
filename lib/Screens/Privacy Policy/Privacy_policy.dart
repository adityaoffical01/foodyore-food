import 'package:flutter/material.dart';
import 'package:foodyore/utils/Colors/AppColors.dart';
import 'package:foodyore/utils/helpers/App_Content.dart';
import 'package:foodyore/utils/helpers/Custom/Custom_AppBar.dart';
import 'package:foodyore/utils/styles/Text_Styles.dart';

class PrivacyPolicyWidget extends StatelessWidget {
  const PrivacyPolicyWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Privacy Policy'),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12,
            children: [
              _sectionBody(
                "This privacy policy (“Privacy Policy”) sets forth VEETHEE VIHARAN Private Limited and its affiliates and subsidiaries’ commitment to respecting your online privacy and recognises your need for appropriate protection and management of any Personal Information (as defined below) you share with us. The Privacy Policy applies to our Services offered by us available under the domain www.eatind.com and its related sub-domains, websites, services and tools, or any successor site (herein after referred to as the “Website”). By visiting the Website, you agree to be bound by the terms and conditions of this Privacy Policy. Please read this Privacy Policy carefully to understand VEETHEE VIHARAN's policies and practices regarding your information and how VEETHEE VIHARAN will treat it. By accessing or using its Services and / or registering for an account with VEETHEE VIHARAN, you agree to this Privacy Policy and you are consenting to VEETHEE VIHARAN's collection, processing, use, disclosure, retention, and protection of your personal information as described here. If you do not provide the information VEETHEE VIHARAN requires, VEETHEE VIHARAN may not be able to provide all of its Services to you.",
              ),
              _sectionTitle(
                'IF YOU DO NOT AGREE PLEASE DO NOT USE OR ACCESS THE WEBSITE.',
              ),
              _sectionBody(
                "The words “you” or “your” or “User” as used herein, refer to all individuals and/or entities accessing or using the Website for any reason. The words “VEETHEE VIHARAN” “we” or “us” or “our” as used herein, refer to VEETHEE VIHARAN Private Limited, its affiliates, its subsidiaries, the Website and/or or any permitted assignees. This Privacy Policy describes the information, as part of the normal operation of our Services that we collect from you and what may happen to that information. This Privacy Policy DOES NOT apply to information that you provide to, or that is collected by, any third-party, such as social networks that you use in connection with our Services. VEETHEE VIHARAN encourages you to consult directly with such third-parties about their privacy practices. Although this Privacy Policy may seem long, we have prepared a detailed policy because we believe you should know as much as possible about the Website, Services and our practices so that you can make informed decisions. Please click on the link https:// www.eatind.com to send us an email stating that you have read the Privacy Policy and understood the purpose for which your Personal Information is being collected and how the same shall be used and granting your express consent to such purpose and use. If, at a later date, you wish to withdraw this consent, please send us an email at www.eatind.com",
              ),
              _sectionBody(
                "By accepting the Privacy Policy and the Terms of Use, which prescribes terms and conditions for use of the Website or availing Services, you expressly consent to our use and disclosure of your personal information in accordance with this Privacy Policy. This Privacy Policy is incorporated into and subject to the terms of the Terms of Use and the terms not defined here, have their meanings ascribed to in the Terms of Use. This Privacy Policy and Terms of Use are effective upon your visit of Website. We encourage you to read the terms of the Privacy Policy and the Terms of Use in their entirety before you use the Website",
              ),
              _sectionTitle("1. Your Privacy - Our Commitment"),
              _sectionBody(
                "We are extremely proud of our commitment to protect your privacy. We value your trust in us. We will work hard to earn your confidence so that you can use our services unhesitatingly and recommend us to friends and family. Please read the following policy to understand how your Personal Information will be treated as you make full use of our Website. For the purposes of this Privacy Policy, the term “Personal Information” shall mean any information that may be used to identify you including, but not limited to: (i) first and last name, a home or other physical address and an email address or other contact information (including mobile / landline numbers), whether at work or at home; (ii) sensitive information such as your experience and income level; (iii) any report such as a result of back ground check, profiling etc.; (iv) should you post a profile or resume or apply/send enquiry for an opportunity, the information contained therein (the amount of information you choose to keep confidential is entirely up to your discretion; you may enter as much or as little information as you choose, except for the information which is mandatorily required); (v) such information as opportunities you have applied for, projects / assignments & opportunities you have viewed and similar information in your use of the Website; and (vi) reviews on your profile, if any.",
              ),
              _sectionTitle("2. Information We Collect"),
              _sectionBody(
                "When you use our Website, we collect and store your Personal Information. Our primary goal in doing so is to provide a safe, efficient and customised experience to our Users. This allows us to provide services and features that most likely meet your needs, and to customise our Website to make your experience safer and easier. Importantly, we only collect Personal Information about you that we consider necessary for achieving this purpose. To fully use our Website, you will need to register using our online registration form to set up an account ('Account'), where you may be required to provide us with your contact and identity information and other Personal Information as indicated on the forms throughout the Website and complete the registration process. Once you give us your Personal Information, and initiate the registration process, you are not anonymous to us. Where possible, we indicate which fields are mandatorily required and which fields are optional. You always have the option to not provide information by choosing not to use a particular service or feature on the Website, unless we require it so. We may automatically track certain information about you based upon your behavior on our Website. You agree that we may use such information to do internal research on our Users’ demographics, interests, and behavior to better understand, protect and serve our Users. This information is compiled and analysed on an aggregated basis. This information may include, but not limited to, the URL that you just came from (whether this URL is on our site or not), which URL you next go to (whether this URL is on our Website or not), your computer browser information, and your Internet Protocol (“IP”) address. We use data collection devices such as “cookies” on certain pages of the Website to help analyse our web page flow, measure promotional effectiveness, and promote trust and safety. “Cookies” are small files placed on your hard drive that assist us in providing our services. We offer certain features that are only available through the use of a “cookie”. We also use cookies to allow you to enter your password less frequently during a session. Cookies can also help us provide information that is targeted to your interests. Most cookies are “session cookies”, meaning that they are automatically deleted from your hard drive at the end of a session. By accepting this Privacy Policy, you confirm your consent to VEETHEE VIHARAN’s use of cookies and other such technologies. You are always free to decline our cookies if your browser permits, although in that case you may not be able to use certain features on the Website and you may be required to re-enter your password more frequently during a session. You agree, if you send us personal correspondence, such as emails or letters, or if other users or third parties send us correspondence about your activities or postings on the Website, we may collect and/or store such information. You agree that we may collect IP address from all visitors to the Website, like most websites. An IP address is a number that is automatically assigned to your computer when you use the Internet. We use IP addresses to help diagnose problems with our server, administer our Website, analyse trends, track users’ movement, gather broad demographic information for aggregate use in order for us to improve the Website, and deliver customised, personalized content.",
              ),
              _sectionTitle("3. Use of your Personal Information"),
              _sectionBody(
                "You agree that we may use your Personal Information to facilitate the services you request. You agree that we may use your Personal Information and other information we obtain from your current and past activities on the Website to: resolve disputes; troubleshoot problems; measure your interest in the services provided by us, inform you about our products, services, and updates; customise your experience; detect and protect us against error, fraud and other criminal activity; enforce Terms of Use; and as otherwise described to you at the time of collection. At times, we may look across multiple Users to identify problems or resolve disputes, and in particular we may examine your Personal Information to identify users using multiple User IDs or aliases. We may compare and review your Personal Information for errors, omissions and for accuracy. You agree that we may use Personal Information about you to improve our marketing and promotional efforts, to analyse site usage, improve the Website’s content and service offerings, and customise the Website’s content, layout, and services. These uses improve the Website and better tailor it to meet your needs, so as to provide you with an efficient, safe and customised experience while using the Website. You agree that we collect and share your Personal Information with third parties such as google analytics, mail chimp and any other third parties that we may use in the future. You agree that we may use your Personal Information to contact you and deliver information to you that, in some cases, are targeted to your interests, such as targeted administrative notices, services offerings, and communications relevant to your use of the Website. By accepting the Terms of Use and Privacy Policy, you expressly agree to receive this information. If you do not wish to receive these communications, we encourage you to opt out of the receipt of certain communications in your profile. You may make changes to your profile at any time.",
              ),
              _sectionTitle("4. Disclosure of your Personal Information"),

              _sectionBody(
                "You agree and confirm that we do not rent, sell, or share Personal Information about you with other people (save with your consent) or non-affiliated companies except to provide products or Services under Terms of Use or this Privacy Policy, or under the following circumstances: \ni. We use your Personal Information to facilitate the Services you request. We will share your Personal Information internally with those staff members who need it to complete your request or carry out your instructions regarding the receipt of marketing information. \nii. to provide the Personal Information to trusted partners who work on behalf of or with us under confidentiality agreements. These entities may use your Personal Information to help us communicate with you about offers from us and our marketing partners; \niii. to respond to summons, court orders, or legal process, or to establish or exercise our legal rights or defend against legal claims; iv. to share Personal Information in order to investigate, prevent, or take action regarding illegal activities, suspected fraud, situations involving potential threats to the physical safety of any person, violations of Terms of Use, or as otherwise required by law; \nv. to transfer Personal Information about you if we are acquired by or merged with another company. In this event, we will notify you before information about you is transferred and becomes subject to a different privacy policy; and \nvi. from time to time, to reveal general statistical information about our Website and visitors, such as number of visitors, number and type of services purchased, etc. Further, you agree that we may share your Personal Information with the following categories of activities with from time-to-time:",
              ),
              _sectionTitle('5. Advertisements'),
              _sectionBody(
                "When you access the Website or enter Personal Information on the Website, such information is collected by the Website. The Personal Information is used by the Website in accordance with the terms of this Privacy Policy. The Website may also aggregate (gather up data across all Accounts) Personal Information and disclose such information in a non-personally identifiable manner to advertisers and other third parties for other marketing and promotional purposes.",
              ),
              _sectionTitle(
                "6. Services offered on the Website by third parties",
              ),
              _sectionBody(
                "There are certain services for which third parties request for information before the service is listed on the Website. The information provided by you for such purposes is simultaneously collected by the Website and the respective third party. This information is utilised by the third party in accordance with its privacy policy and the terms of the offer. Because we do not control the privacy practices of these third parties, you should evaluate their practices before deciding to use their services",
              ),
              _sectionTitle("7. Posting to public areas of the website"),
              _sectionBody(
                "Please remember that if you post any of your Personal Information in public areas of the Website such as blogs, such information may be collected and used by others over whom we have no control. We are not responsible for the use made by third parties of information you post or otherwise make available in public areas of Website.",
              ),
              _sectionTitle("8. Access or change your Personal Information"),
              _sectionBody(
                "You may review, correct, update or change your account information at any time. To protect your privacy and security, we will verify your identity before granting access or making changes to your Personal Information. If you have registered your profile on the Website, your ID and Password are required in order to access your Account. You may also opt out of any future contacts from us at any time. You can contact us using the information on the Contact Us web page, at any time and do the following:\ni. See what data we have about you, if any;\nii. Change / correct any data we have about you;\niii. Have us delete any data we have about you; and\niv. Express any concern you have about our use of your data.",
              ),
              _sectionTitle("9. Authentication using Facebook and Google"),
              _sectionBody(
                "VEETHEE VIHARAN may use Facebook and Google to authenticate our users to facilitate faster sign in for our existing users or new users. VEETHEE VIHARAN may use name, email, mobile number only for the purpose of registration of the user. The participation of such users will also be subject to the terms of this Privacy Policy",
              ),
              _sectionTitle("10. Retention of Data"),
              _sectionBody(
                "Your personal information may be retained and may continue to be used until: (i) the relevant purposes for the use of your information described in this Privacy Policy are no longer applicable; and (ii) we are no longer required by applicable law, regulations, contractual obligations or legitimate business purposes to retain your personal information and the retention of your personal information is not required for the establishment, exercise or defense of any legal claim.",
              ),
              _sectionTitle("11. Other Websites"),
              _sectionBody(
                "Our Website may contain links to other websites. Please note that when you click on one of these links, you are entering another website over which the Website has no control and will bear no responsibility. Often these websites require you to enter your Personal Information. We encourage you to read the privacy statements on all such websites as their policies may differ from ours. You agree that we shall not be liable for any breach of your privacy of Personal Information or loss incurred by your use of these websites.",
              ),
              _sectionTitle("12.Changes to this privacy policy"),
              _sectionBody(
                "We reserve the right to update, change or modify this Privacy Policy at any time. The amendment to this Privacy Policy shall come to effect from the time of such update, change or modification",
              ),
              _sectionTitle('13.disclaimer'),
              _sectionBody(
                "We endeavor to safeguard the user’s Personal Information to ensure that the same is kept private. However, we cannot guarantee the security of the user’s Personal Information. Unauthorized entry or use, hardware or software failure, and other factors, may compromise the security of user’s Personal Information at any time. We shall not be liable for any loss or damage sustained by reason of any disclosure (inadvertent or otherwise) of any Personal Information concerning the User’s account and/or information relating to or regarding online transactions using credit cards/ debit cards and/or their verification process and particulars nor for any error, omission or inaccuracy with respect to any information so disclosed and used.",
              ),
              _sectionTitle(
                '14. Dispute resolution, governing law and jurisdiction',
              ),
              _sectionBody(
                "In the event of any dispute arises between the parties, any claim arising out of or relating to this Agreement shall be settled shall be conducted in English. A sole arbitrator would be appointed with the consent of both the parties to preside over the Arbitration proceedings whose award shall be binding on both the parties. This Agreement shall be governed by and construed in accordance with the laws of India. The adjudication of any dispute will be the exclusive jurisdiction of the courts of Lucknow.",
              ),
              _sectionTitle("15. assignability"),
              _sectionBody(
                "We may assign any of our responsibilities/obligations to any other person without notice to the User, at its sole discretion. However, you shall not assign, sub-licence or otherwise transfer any of your rights or obligations under this Privacy Policy to any other party, unless a written consent is taken from us. ",
              ),
              _sectionTitle("16.Contacting the website holder"),
              _sectionBody(
                "In accordance with the Information Technology Act, 2000 and rules made there under, the name and contact details of the Grievance Officer are as under :\nName: Sandeep Srivastava\nEmail Id: sandeep@eatind.com\n\nIn the event you have any complaints about the Website, its contents or anything related thereto or if you wish to make a complaint regarding any violation of the provisions of the Privacy Policy, you may send a written complaint to the Grievance Officer, who shall redress the complaint within one month.\n\n",
              ),
            ],
          ),
        ),
      ),
    );
  }

  // for titile
  Widget _sectionTitle(String title) {
    return Text(
      title.toUpperCase(),
      style: AppTextStyles.bodySmall.copyWith(color: AppColors.primaryColor),
    );
  }

  Widget _sectionBody(String text) {
    return Text(
      text,
      style: AppTextStyles.caption.copyWith(
        color: AppColors.black,
        fontFamily: AppFonts.regular,
      ),
    );
  }
}
