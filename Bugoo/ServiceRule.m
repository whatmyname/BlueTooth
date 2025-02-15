
//
//  ServiceRule.m
//  Bugoo
//
//  Created by bugoo on 20/7/17.
//  Copyright © 2017年 bugoo. All rights reserved.
//

#import "ServiceRule.h"

@interface ServiceRule ()
@property (nonatomic,strong)UIView *rootView;
@property (nonatomic,strong)UITextView *text;
@end

@implementation ServiceRule

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _rootView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH(self.view), HEIGHT(self.view))];
    _rootView.backgroundColor = [Utility colorWithHexString:@"e8ebeb"];
    
    [self.view addSubview:_rootView];
    
    self.title = HXString(@"服务条款");
    
    
    _text = [[UITextView alloc]initWithFrame:CGRectMakeIPHONE6Adapt(15, 15, 345, 580)];
    [_text setEditable:NO];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;// 字体的行间距
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:17],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    _text.attributedText = [[NSAttributedString alloc] initWithString:HXString(@"应用程序所有权及使用条款协议\n本使用条款之内容(下称\"使用条款\")适用于布古科技位于www.bugootech.com.tw的应用程序，及所有由布古科技及其从属公司链接至www.bugootech.com.tw之应用程序。(称为\"本应用程序\")。本应用程序为香港商富桑国际企业有限公司在台分公司及其授权使用人之财产。藉由使用此应用程序，将视为您已同意本使用条款之内容;如果您不同意，请勿使用此应用程序。\n布古科技基于其独立判断，保留在任何时候变更、修改、增加或删除使用条款内容之权利。您有责任定期检阅使用条款的变动。随着张贴于本应用程序上的变动信息，您对本应用程序的持续使用，视为您同意接受该变动。只要您遵循该使用条款，布古科技将授予您一个人化、无专属性、不可转让、有限的权限进入并使用本应用程序。\n内容\n所有于本应用程序之文字、图表、用户界面、可视界面、图片、商标、标记、声音、音乐、美术作品及计算机编码(合称为\"本应用程序内容\")，包括但不限于包含在公司所有，或其控管、授权之应用程序所出现对内容之设计、结构、选择、协调、表达、\"lookandfeel\"及安排等，均属布古科技所有、控制或取得授权；并且受商业形象、著作权法、专利法、商标法以及各类智能财产权及公平交易法之保护。\n除本使用条款有明文规定外，非经布古科技事先之书面同意，本应用程序及其内容之任何部分，不得复制、再制、重印、上载、张贴、公开展示、编码、翻译、传送或散布(包括\"反映\")至其他计算机、服务器、应用程序、出版物媒介发行或为任何商业组织散布。\n您得在符合下列条件下，使用布古科技提供附于布古科技产品或服务(例如资料单、知识库文件及类似资料)上之信息，自本应用程序下载各项信息。(1)不在出现所有权通知文句之文件，移除该文句；(2)仅出于个人使用、非商业信息之目的使用该文件，未复制或张贴该信息于任何联机计算机或播放其于任何媒介；(3)未对该信息作任何修改；以及(4)未就该文件作任何额外之声明或保证。\n您对本应用程序之使用\n您不得使用任何\"deep-link\"，\"page-scrape\"，\"robot\",\"spider\"或其它自动装置、程序、计算、方法或任何相似或相同之手动程序，以进入、取得、复制或监测本应用程序或内容之任何部份，或在任何情况下，重制或规避浏览结构或本应用程序及内容的介绍，透过任何非本应用程序允许之方式，取得或试图取得任何资料、文件或信息。布古科技保留禁止此类活动之权利。\n您不得以探试密码或任何其它之非法手段，未经授权进入：本应用程序之任何部份或画面、与布古科技服务器链接之系统或网路、或透过该应用程序提供之服务。\n您不得探查、扫描或测试本应用程序及任何连接至本应用程序之网路的弱点，亦不得破坏本应用程序或链接至本应用程序之网路的安全或认证措施。您不得回复查寻、追踪或找寻任何关于其他用户或本网路之访客、布古科技之其他顾客，包括任何非您所有之布古科技帐户之来源；或出于显示非您个人所有信息之目的，包括但不限于他人之身份资料，探索本应用程序或其提供之服务或信息。\n您同意不会采取任何行为，施加不合理或不成比例之大量资料，于本应用程序或布古科技之系统或网路，或任何链接至布古科技之网路或系统。\n您同意不使用任何设备、软件或程序，干扰或试图干扰本应用程序、于本应用程序进行交易之正常运作功能或干扰他人使用本应用程序。\n您不得伪造身份或操控识别功能，伪造您透过本应用程序传送至布古科技之讯息或传输内容或任何经由本应用程序提供之服务，您不可假冒他人或无权代表他人，或模仿其他个人或团体。\n您不得以本使用条款所禁止、认为不法之事项为目的，使用本应用程序或其内容，亦不得征求任何非法或侵害布古科技或其他人权利之活动。\n购买及其它约定事项\n额外的约定事项，得适用于本应用程序购买商品及服务，以及本应用程序之特定部分或特色商品，包括竞赛、促销或其它相似性的特色商品，该条款之内容为本使用条款之一部。您同意遵守该其他之约定事项，包括您是否已达可使用或参加该服务或特色商品之法律年龄。如果本使用条款之内容，与本应用程序就特定部分、特色商品或任何经由或透过本应用程序所提供服务，所公告约定之内容有所冲突者，后者约定之内容将优先适用于您使用本应用程序该部分内容或特色商品之部分。\n布古科技若就其产品及服务有任何义务，将依其提供之合约内容为规范。本应用程序之内容不得构成该合约之一部，或修改该合约内容。\n布古科技得在任何时间，不经通知而修改所有于本应用程序提供之产品、服务或其价格。本应用程序中关于产品和服务之资料可能过时，布古科技不承诺于本应用程序有随时更新该产品和服务资料之义务。\n以下各项之内容，亦适用于规范您对本应用程序之使用，并应合并适用:\n商标信息\n著作权信息\n权利及许可\n侵犯著作权之损害赔偿请求权\n预防盗版行为\n报告盗版行为\n布古科技之建言政策\n软件授权信息\n法律联络\n布古科技得随时变更上开各项内容，并在变更内容张贴于本应用程序时立即生效。\n帐户、密码及安全\n本应用程序或透过本应用程序所提供之某些特色商品或服务，得要求您建立帐户(包括设定布古科技ID和密码)。您负有全责维护您帐户信息之保密性，包括您的密码和任何在您的帐户下发生之所有活动。您同意于帐户或密码未经授权被使用或安全性有任何破坏时，应立刻通知布古科技。然而，您可能须对他人使用您的帐户密码，导致布古科技或其他用户或访客所受之损害负责。\n\n无论何时，非经其他布古科技ID所有人之明示同意，您不得使用其身份、密码或帐户。若未遵守该义务，布古科技对因此所生之任何损失，将不能也不会负赔偿责任。\n隐私性\n布古科技的隐私权政策适用于本应用程序之使用，其规定内容为本使用条款之一部。检视布古科技之隐私权政策，请点击这里。另外，藉由使用本应用程序，您承认和同意网际网路传输是无法完全保密或安全的。您瞭解任何您寄发到本应用程序之消息或信息，皆有可能被其他人阅读或拦截，既便经通知特定传输已为编码之信息(例如信用卡信息)。\n链接至其它应用程序及布古科技应用程序\n本应用程序得链接至其它独立第三人之应用程序(\"链接应用程序\")。这些链接应用程序仅为方便顾客而提供。该链接应用程序非由布古科技所控制，且布古科技就其内容不为背书亦不负任何责任，包括任何该链接应用程序之信息或内容。就与该链接应用程序互动之事项，您应自行独立判断。\n声明\n布古科技不保证本应用程序或其内容、服务及特色商品无任何错误或不中断，亦不保证所有瑕疵将被更正，或您对本应用程序的使用将有特定之结果。本应用程序及其内容是基于现状(\"AS-IS\"和\"AS-AVAILABLE\")为传送。所有提供于本应用程序之信息，将可能随时不经通知而变更。布古科技不保证您自本应用程序下载之文件或其它资料可免于病毒、感染或不具破坏性。布古科技兹声明并无任何明示或暗示之保证，包括所有内容正确性、无侵害权利及就产品特定目的之销售性及适用性之保证。布古科技声明对于任何与您使用本应用程序或布古科技服务有关之第三人行为或不行为，布古科技均不负任何责任。您对于使用本应用程序及链接应用程序应承担所有责任。若使用本应用程序或对其内容有任何不满意，您唯一的救济方式是停止使用本应用程序或内容。双方当事人就此救济方式之限制，得协议讨论。\n上述声明适用于因任何债务不履行、错误、遗漏、中断、删除、瑕疵、运作或传输之延迟、计算机病毒、通信线路失败，偷窃或破坏或未经授权而进入、变造及使用，不论是违约、侵权行为、过失或其它行为造成之损害、责任或伤害。\n布古科技保留权利，在任何时候，得不经通知为以下之事项:(1)基于任何原因，修改、暂停或终止本应用程序或其任何部份之开放或运作；(2)修改或变更本应用程序或其部份适用的政策或内容；以及(3)于有必要为定期或非定期之维修，修改错误，或为其他变更时，中断本应用程序或其部份之运作。\n责任范围\n除法律明文禁止外，在任何情况下，布古科技对于任何间接、持续性、惩戒性、偶然或惩罚性违约金之赔害赔偿，包括利益之丧失，不负任何责任。即便布古科技曾被告知该损害可能发生。\n赔偿\n您同意并保证布古科技及其干部、董事、股东、前手，及有利害关系之承接人、员工、代理人、从属公司，不因您使用本应用程序导致第三人向布古科技提出之任何请求、损失、责任、主张或费用(包括律师费)而受有任何损害，并愿意赔偿布古科技因而所受之损害。\n本使用条款之违反\n就任何与您使用计算机有关之调查或申诉；或为对可能对布古科技、本应用程序之用户(包括布古科技之顾客)之权利或财产，造成损害或干扰(故意或非故意)之他人，进行确认、连系或提出诉讼；若我们认为有揭露您信息之必要(包括您的身份)者，布古科技得予以揭露。布古科技保留于认为有遵守之法律、命令、法律程序或政府要求之必要时，得在任何时间透露任何信息之权利。布古科技亦得在认为法律允许或要求应揭露您的信息时(包括基于防范诈欺之目的)，而与其他公司或机构交换信息。\n您承认并同意布古科技得保留任何您与布古科技，或透过本应用程序、或任何于本应用程序或由应用程序提供之服务所进行之传送或沟通，且布古科技有权因法律要求而揭露该等信息。布古科技并得于认为有达到下列目的之合理必要时，透露或保留该等信息：(1)遵从法律程序，(2)执行本使用条款，(3)关于就该资料侵害他人权利时，其诉讼主张之答辩，(4)保护布古科技、其员工、应用程序之用户或访客及大众之权利、财产或个人安全。\n您同意如果我们认为您违反本使用条款或其他与使用本应用程序有关之合约或准则，布古科技得终止您进入本应用程序，以及/或封锁您将来进入本应用程序。您亦同意您对本使用条款之违反，将构成非法及不公平之商业行为，并对布古科技造成无法以金钱赔偿回复的伤害，并且您同布古科技在认为必要或适当之情况下，得取得禁制令或平衡救济。这些救济方式，为布古科技依法或公平原则可得救济之额外救济方式。\n您同意布古科技得依其判断且不作事先通知，因下列原因终止您进入本应用程序，包括(但不限于)(1)依法律强制执行或其他政府机构之要求；(2)依您之要求(删除自已建立之帐户)、(3)本应用程序或本应用程序所提供服务之中止、资料修改，或(4)不可预期之技术问题。\n若布古科技因您违反本使用条款，而对您采取法律行动，布古科技将有权向您请求，您亦同意支付所有合理之律师费及诉讼费用，以及布古科技可请求之其他损害赔偿。您同意布古科技就因您违反使用条款而终止您进入本应用程序，对您或任何第三人，不负任何赔偿责任。\n准据法及争端解决\n您同意所有您进入或使用本应用程序之相关事项，包括所有争议，就无关法律冲突之事项，将依中华民国之法律规范。您同意以位台湾台北地方法院为第一审管辖法院为个人管辖权之法庭及审判地点，并放弃对该管辖权及审判地点之异议。基于本使用条款之诉讼请求，必需在请求之原因发生后、或该请求被禁止之一年内提出。除胜诉之一方得请求之费用及律师费外，请求之损害赔偿仅得以现金支付。有关您使用应用程序之任何争议或不同意见，双方应以善意，尽力协商解决之，该争议未能于合理期间（不超过30天）协商解决者，任何一方得将该争议提交调解。若调解不成，双方应就其可适用之法律，寻求可享有之权利或救济方式。\n禁止之无效事项\n布古科技于中华民国管理及操作www.bugootech.com.tw之本应用程序；其它布古科技应用程序，得于中华民国境外各地管理操作。虽然全球各地均可链接进入本应用程序，但并非所有特色商品、在本应用程序上或透过本应用程序讨论、推荐、提供的产品或服务，皆能开放给在各地之所有民众，或适合、可供在中华民国境外使用。布古科技保留权利，依其独立判断，得限制其所提供于任何地方之顾客之特色商品、产品、服务之约定及数量。就于本应用程序所为之特色商品、产品、服务之要约为依法所禁止时，其要约为无效。如果您选择由中华民国境外链接至本应用程序，您系依您独立之决定，并应遵守当地适用之法律。\n杂项规定\n您不得违反任何适用之法令(包括但不限于中华民国出口法规)，而使用、出口或再出口任何本应用程序内容，或拷贝或援用本应用程序内容，或于本应用程序提供之任何产品或服务。\n布古科技提供进入其国际性资料之路径，依法院或其他有权限之司法机关，认定为无效或无执行力，该条文应在必要之最小范围内限制或删除，并以另一最符合本使用条款意旨之有效条文替代，以使本使用条款依然全面有效并具执行力。在您与布古科技之间，本使用条款之内容构成关于您对本应用程序之使用约定之所有合约。其它您和布古科技，就使用本应用程序之任何书面、口头协议或先前存在之理解，在此被取代而消灭。布古科技，不接受任何关于本使用条款之再要约，并且亦在此一并拒绝该要约。布古科技任何未坚持或未执行本使用条款之行为，并不构成放弃任何条文、或放弃其执行本使用条款之权利，布古科技与您或任何人间之行为，亦不被视为修改本使用条款之任何条文。本使用条款不会被解释或成为任何其他人主张权利或救济之依据。\n布古科技提供进入其国际性资料之路径，因此，得推荐或相互推荐未于您国家发表之布古科技产品、程序和服务。该推荐并不意味，您所在国家之布古科技欲发表该产品、程序或服务。\n回应及信息\n任何您于本应用程序之回应，将被视为不具机密性。布古科技有权无限制地自由使用该信息。\n包含在本应用程序之信息得随时不经通知变更。") attributes:attributes];

    
    
    
    
    _text.backgroundColor = [UIColor clearColor];
    _text.font = [UIFont systemFontOfSize:14];
    _text.textColor = [Utility colorWithHexString:@"555555"];

    
    [_rootView addSubview:_text];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
