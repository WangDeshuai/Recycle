//
//  Engine.h
//  Recycle
//
//  Created by mac on 16/5/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^SuccessBlock)(NSDictionary*dic);
typedef void (^ErrorBlock)(NSError*error);



@interface Engine : NSObject

#pragma mark -- 首页轮播
+(void)GetFirstLunBosuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark -- 登录第一步
+(void)LoginName:(NSString*)name Password:(NSString*)mima success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark -- 登录第二步
+(void)LoginUid:(NSString*)uid Code:(NSString*)code success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;


#pragma mark -- 注册
+(void)Register:(NSString*)name Password:(NSString*)mima  Phone:(NSString*)phone YanZheng:(NSString*)yanzhengm success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark -- 获取手机验证码
+(void)getHuoQuPhoneNumber:(NSString*)phonenum  type:(NSString*)ty  success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;


#pragma mark -- 获取省份
+(void)getAllProvincesuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark -- 根据省份获取城市
+(void)getCityCode:(NSString*)code success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark -- 前台供求列表
+(void)getQianTai:(NSString*)address MID:(NSString*)mid Page:(NSString*)page Category:(NSString*)cate  success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark -- 供求分类
+(void)getGongQiuFenLeiClass:(NSString*)Category success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark -- 前台供求详情
+(void)getQianTaiXiangQingID:(NSString*)messageID Uid:(NSString*)uid success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark -- 求购列表//未用
+(void)getQiuGou:(NSString*)address MID:(NSString*)mid Page:(NSString*)page Category:(NSString*)cate  success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark -- 拍卖列表
+(void)getPaiMaicid:(NSString*)Cid Pid:(NSString*)pid Time:(NSString*)time Page:(NSString*)page Pagesize:(NSString*)pagesize GuanJian:(NSString*)gjz success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --拍卖详细信息
+(void)getPaiMaiXiangXiId:(NSString*)idd Uid:(NSString*)uid success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;


#pragma mark -- 资产列表
+(void)getZhiChanPage:(NSString*)page Pagesize:(NSString*)pagesize   Category:(NSString*)cate Adds:(NSString*)adds Date:(NSString*)time GuanJianZi:(NSString*)guanjian   success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark -- 资产详情
+(void)getZiChanXiangQingID:(NSString*)messageID Uid:(NSString*)uid success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark -- 资寻分类
+(void)getZiFenLeisuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark -- 资寻列表
+(void)getZiXunLieBiaoPage:(NSString*)page Pagesize:(NSString*)pagesize uid:(NSString*)Uid pwd:(NSString*)Pwd Where:(NSString*)where Classid:(NSString*)classid  success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark -- 资寻详情
+(void)getZiXunXiangQingMessageID:(NSString*)messageid success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark -- 资寻新闻(3个选填没有填)
+(void)getZiXunXinWenPage:(NSString*)page Pagesize:(NSString*)pagesize   classID:(NSString*)cid  success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;



#pragma mark -- 报价列表
+(void)getBaoJiaPage:(NSString*)page pagesize:(NSString*)Pagesize bgclass:(NSString*)Bjclass success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark -- 报价详情
+(void)getBaoJiaXiangQing:(NSString*)messageid success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark -- 相关报价
+(void)getXiangGuanBaoJiapage:(NSString*)Page pagesize:(NSString*)Pagesize bjclass:(NSString*)Bjclass success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --报价分类
+(void)baoJiaClassCid:(NSString*)cid success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;



#pragma mark --留言功能
+(void)getLiuYanxxid:(NSString*)Xxid contact:(NSString*)Contact handtel:(NSString*)shoujihao content:(NSString*)neirong type:(NSString*)Type uid:(NSString*)Uid ruid:(NSString*)Ruid success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;




#pragma mark --首页热门行业信息
+(void)HuoQuFirstHangYeMessageType:(NSString*)type success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark -- 新增接口首页行业 去掉的信息
+(void)HuoquFirstHangYesuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --首页搜索关键字信息
+(void)HuoQuSearchYeMessagesuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --首页拍的分类
+(void)PaiMessage:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --首页拍的分类拍卖列表信息

#pragma mark --首页拍卖详细信息
+(void)PaiMessageID:(NSString*)idd Uid:(NSString*)uid success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --首页猜你喜欢
+(void)getShouyeCainiLikeCid:(NSString*)cid Pagesize:(NSString*)pagesize Page:(NSString*)page success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --根据登录ID去获取会员信息
+(void)getHuiYuanMessageUid:(NSString*)uid  success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --修改会员信息
+(void)xiuGaiMyMessageKey:(NSString*)token SuiJi:(NSString*)suiji Key:(NSString*)key ShengCode:(NSString*)code success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --上传图片得到图片地址后，再把地址给服务器
+(void)shangchuanTouXiang:(NSData*)touxiangData Key:(NSString*)token success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --上传图片得到图片地址后，再把地址给服务器
+(void)shangchuanImageArr:(NSMutableArray*)touxiangData Key:(NSString*)token success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --我的订阅
+(void)getMydingYueMessageToken:(NSString*)token TextFiled:(NSString*)textMessage Address:(NSString*)address MessageLaiyuan:(NSString*)laiyuan Type:(NSString*)type  success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --获取订阅信息
+(void)getDingYueXinXiToken:(NSString*)token Type:(NSString*)type success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --查看订阅条件下的信息
+(void)getDingYueTiaoJianToke:(NSString*)token messageID:(NSString*)idd success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --删除订阅条件下的mchid 信息
+(void)getDeleteDingyueToken:(NSString*)token messageID:(NSString*)idd success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --发布供求信息
+(void)fabuGongQiuMessageToken:(NSString*)token BiaoTi:(NSString*)biaoti hangye:(NSString*)cid ShengFenCode:(NSString*)code MiaoShu:(NSString*)miaoshu chengse:(NSString*)chense Price:(NSString*)jiage Kucun:(NSString*)kucun YouxiaoQi:(NSString*)youxiaoq xingHao:(NSString*)xinghao Type:(NSString*)type picArr:(NSMutableArray*)imageArr success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --发布资产信息
+(void)fabuZiChaMessageToken:(NSString*)token BiaoTi:(NSString*)biaoti MiaoShu:(NSString*)miaoshu Price:(NSString*)jiage KuCun:(NSString*)kucun YouXiaoQi:(NSString*)youciaoq HangYeId:(NSString*)cid MyWeiZhi:(NSString*)weizhiCode imgaeArr:(NSMutableArray*)imageStr success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --发布拍卖
+(void)fabuPaiMaiToken:(NSString*)token BiaoTi:(NSString*)biaoti MiaoShu:(NSString*)miaoshu LianXiRen:(NSString*)lianxiren LianXiDianHua:(NSString*)dianhua BaoZhengjin:(NSString*)baozhengjin StarDate:(NSString*)stardate EndDate:(NSString*)endstar Address:(NSString*)dizhi ClassBie:(NSString*)leibie DiQu:(NSString*)diqu Commper:(NSString*)gongsi success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;


#pragma mark -- 删除供求信息
+(void)deleteGongQiu:(NSString*)token MessageId:(NSString*)type success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --删除资产
+(void)deleteZiChanFabuKey:(NSString*)key MessageID:(NSString*)idd success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --删除拍卖
+(void)deletePaiMaiFabuKey:(NSString*)key MessageID:(NSString*)idd success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark -- 修改供求信息状态(上线还是下线)
+(void)xiuGaiShangXianXiaXianKey:(NSString*)key MessageID:(NSString*)idd success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark -- 刷新供求
+(void)shuaXinReashGongQiuKey:(NSString*)key MessageID:(NSString*)idd success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark -- 修改供求
+(void)xiuGaiGongYingKey:(NSString*)key XinXiID:(NSString*)messageID BiaoTi:(NSString*)biaoti GQName:(NSString*)name Cid:(NSString*)cid GQProvid:(NSString*)shengCode Content:(NSString*)content picArr:(NSMutableArray*)imageArr success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark -- 修改资产
+(void)xiuGaiZiChanKey:(NSString*)key XinXiID:(NSString*)messageID BiaoTi:(NSString*)biaoti  Cid:(NSString*)cid GQProvid:(NSString*)shengCode Content:(NSString*)content YouXiaoQi:(NSString*)youxiaqi Price:(NSString*)price ShuLiang:(NSString*)shuliang imgaeArr:(NSMutableArray*)imageStr success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark -- 修改拍卖
+(void)xiuGaiPaiMaiKey:(NSString*)key XinXiID:(NSString*)messageID BiaoTi:(NSString*)biaoti  Cid:(NSString*)cid GQProvid:(NSString*)shengCode Content:(NSString*)content StarTime:(NSString*)time1 EndTime:(NSString*)endtime ComperName:(NSString*)gongSiName People:(NSString*)lianxiren Address:(NSString*)dizhi PhoneNumber:(NSString*)shoujiHao success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;


#pragma mark -- 获取附近商户(发现当中的身边店铺)
+(void)getShenBianDianPuCityCode:(NSString*)cityCode success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --拍卖行业
+(void)getPaiMaiHangYesuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --获取附近商机
+(void)getFuJinShangJiCityCode:(NSString*)code Page:(NSString*)page Type:(NSString*)type success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --锁定信息
+(void)getSuoDingMessageKey:(NSString*)token messageID:(NSString*)idd Infoclass:(NSString*)type success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --解锁信息
+(void)getJieSuoMessageKey:(NSString*)token messageID:(NSString*)idd Infoclass:(NSString*)classinfo success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;



#pragma mark -- 获取锁定信息列表
+(void)getSuoDiangMessageToken:(NSString*)token success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark -- 获取锁定信息展示页面
+(void)getSuoDingXiangQingYeMianKey:(NSString*)token MessageID:(NSString*)idd Infoclass:(NSString*)type success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark -- 会员中心供求列表（我的发布供应）
+(void)getMyPublicGongQiuZhongXinKey:(NSString*)token Type:(NSString*)type Page:(NSString*)page success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark -- 会员中心获取资产信息（我的发布资产）
+(void)getMyPublicZiChanZhongXinKey:(NSString*)token Type:(NSString*)type Page:(NSString*)page success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark -- 用户中心获取拍卖信息（我的拍卖）
+(void)getMyPublicPaiMaiKey:(NSString*)token Type:(NSString*)type Page:(NSString*)page success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark -- 会员中心展示界面（我的发布供求）
+(void)getMyPublicPaiMaiKey:(NSString*)token MessageId:(NSString*)type success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark -- 会员中心展示界面（我的发布获取资产信息）
+(void)getMyPublicZiChanMessageKey:(NSString*)token MessageId:(NSString*)type success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark -- 会员中心展示界面（我的发布拍卖信息）
+(void)getMyPublicPaiMaiMessageKey:(NSString*)token MessageId:(NSString*)type success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;


#pragma mark --前台搜索列表
+(void)geQianTaiSearchLieBiaoSWord:(NSString*)sword  GID:(NSString*)gid success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --前台搜索列表详细(同一个接口)
+(void)geQianTaiSearchLieBiaoSWord:(NSString*)sword  Address:(NSString*)address VipJibie:(NSString*)vip Page:(NSString*)page GID:(NSString*)gid success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --用户留言列表
+(void)getYongHuLiuYanLieBiaoKey:(NSString*)token Page:(NSString*)page Type:(NSString*)type success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark -- 获取留言提醒对话
+(void)getLiuYanDuiHuaKey:(NSString*)key Ruid:(NSString*)ruid success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark -- 获取会员权限
+(void)getVipQuanXianKey:(NSString*)token success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark -- 升级特权页面
+(void)shengJiTeQuanYeMiansuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark -- 海量商机,暴力宣传，私人秘书
+(void)haiLiangShangJiVipClass:(NSString*)vipclass Key:(NSString*)key success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark -- 支付方式
+(void)zhiFuPaysuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --Lable宽度适应
+ (CGFloat)getWidthWithFontSize:(CGFloat)size height:(CGFloat)height string:(NSString *)string;
#pragma mark --将时间戳按指定格式时间输出,spString为毫秒
+ (NSString*)nsdateToTime:(NSString*)string;

#pragma mark --手机修改密码
+(void)XiuGaiMiMaPhoneNumber:(NSString*)number Password:(NSString*)mima PhoneCode:(NSString*)code success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark -- 拨打电话
+(void)tellPhone:(NSString*)tell;

#pragma mark --图片压缩问题
+(UIImage *)compressImageWith:(UIImage *)image width:(float)width height:(float)height;
#pragma mark --图片上传压缩问题
+(NSData *)imageWithImage:(UIImage*)image
             scaledToSize:(CGSize)newSize;

#pragma mark -- 获取会员级别
+(void)getVIPjiBiesuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --更新缓存
+(void)GengXinHuanCunsuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --0 1
+(void)kankanissuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;


#pragma mark --登录状态
+(void)loginStye:(NSString*)toke success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;


#pragma mark-- 是否更新缓存
+(BOOL)isUpdate:(NSString*)time;
#pragma mark --读取plist文件
+(NSMutableDictionary*)plistDuqu22;
+(NSMutableArray*)plistDuquVipName;
@end
