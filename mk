#!name=Script - All in one . By nzw9314
#!desc=该模块为脚本合集,用于Remove Ads + unlock vip.集成: NobyDa、yichahucha、Choler、onewayticket、langkhach以及个人收集整理的脚本. 需要配置 CA 证书并启用 MitM 开关.  您可以在使用后手动将本模块禁用，以免产生不必要的MITM.如果您是YouTube会员.请添加-*.googlevideo.com到hostname，否则无法加载视频.
#!system=ios
[General]
# > 优酷 去广告
force-http-engine-hosts = %APPEND% vali.cp31.ott.cibntv.net

[Rule]
# > 京东  去启动广告
URL-REGEX,^https?:\/\/api\.m\.jd\.com\/client\.action\?functionId=start$,REJECT-TINYGIF
# > 哔哩哔哩 去广告 
URL-REGEX,https://app.bilibili.com/x/v2/(splash|search/(defaultword|square)),REJECT
URL-REGEX,https://api.bilibili.com/x/v2/dm/ad,REJECT
# > YouTube 去片头广告
URL-REGEX,^https?:\/\/[\w-]+\.googlevideo\.com\/.+&(oad|ctier),REJECT-TINYGIF
# > 知乎 去广告

//SOME MCN INFO MAY BE USEFUL
//URL-REGEX,https://www.zhihu.com/api/v4/mcn/,REJECT
DOMAIN,appcloud2.zhihu.com,REJECT

//DO NOT GET CDN-BASED IP
DOMAIN,118.89.204.198,REJECT

USER-AGENT,AVOS*,REJECT
URL-REGEX,https://api.zhihu.com/(ad|drama|fringe|commercial|market/popover|search/(top|preset|tab)|.*featured-comment-ad),REJECT
AND,((USER-AGENT,ZhihuHybrid*), (URL-REGEX,.*recommend)),REJECT
# > 人人视频 去广告
AND,((USER-AGENT,PUClient*), (NOT,((DOMAIN-SUFFIX,rr.tv)))),REJECT
URL-REGEX,^https?:\/\/api\.rr\.tv\/(?:ad\/getAll$|storage/business/rootName/app/homePage),REJECT
# > 优酷 去广告
URL-REGEX,^http:\/\/vali\.cp31\.ott\.cibntv\.net\/youku\/,REJECT-TINYGIF
# > 爱美剧 去广告
URL-REGEX,^http(s)://api.bjxkhc.com/index.php/app/ios/pay/ok$ ,REJECT-TINYGIF
URL-REGEX,^http(s)://api.bjxkhc.com/index.php/app/ios/ver/index_ios$,REJECT
URL-REGEX,^http(s)://api.bjxkhc.com/index.php/app/ios/ads/index,REJECT-TINYGIF
[URL Rewrite]
# > TikTok 解锁
(?<=_region=)CN(?=&) JP 307
(?<=&app_version=)16..(?=.?.?&) 1 307
(?<=\?version_code=)16..(?=.?.?&) 1 307 
# > 抖音 去广告&水印
^https?:\/\/.+?\.amemv\.com\/aweme\/v\d\/feed\/ https://aweme.snssdk.com/aweme/v1/feed/ header
^https?:\/\/.+?\.amemv\.com\/aweme\/v\d\/aweme\/post\/ https://aweme.snssdk.com/aweme/v1/aweme/post/ header
^https?:\/\/.+?\.amemv\.com\/aweme\/v\d\/follow\/feed\/ https://aweme.snssdk.com/aweme/v1/follow/feed/ header
^https?:\/\/.+?\.amemv\.com\/aweme\/v\d\/nearby\/feed\/ https://aweme.snssdk.com/aweme/v1/nearby/feed/ header
^https?:\/\/.+?\.amemv\.com\/aweme\/v\d\/search\/item\/ https://aweme.snssdk.com/aweme/v1/search/item/ header
^https?:\/\/.+?\.amemv\.com\/aweme\/v\d\/general\/search\/single\/ https://aweme.snssdk.com/aweme/v1/general/search/single/ header
^https?:\/\/.+?\.amemv\.com\/aweme\/v\d\/hot/search\/video\/list\/ https://aweme.snssdk.com/aweme/v1/hot/search/video/list/ header

[Header Rewrite]
# > 小小影视vip (By Eric)
https:\/\/.*.xiaoxiao(img|apps|appxs).com header-replace Cookie xxx_api_auth=6131333537653261363463323331666265663763396239663835636662373930

[Script]
# Chavy box (多账号Cookie保存切换)
# 访问: http://boxjs.com管理
Rewrite: BoxJs = type=http-request,pattern=^https?://boxjs.com(/api|/home|/sub|/my|/app|/log|/revert)?($|\/),script-path=https://gitee.com/chavyleung/scripts/raw/master/chavy.box.js, requires-body=true, timeout=120

# > yichahucha
# > 京东比价
jd_price.js = type=http-response,pattern=https?://api\.m\.jd\.com/client\.action\?functionId=(wareBusiness|serverConfig|basicConfig),requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/yichahucha/surge/master/jd_price.js,script-update-interval=0
# > 淘宝比价
# 不生效或失效的需要卸载 tb 重装，注意不开脚本进 tb 会失效
tb_price.js = requires-body=1,script-path=https://raw.githubusercontent.com/yichahucha/surge/master/tb_price.js,type=http-request,pattern=^http://.+/amdc/mobileDispatch
tb_price.js = requires-body=1,script-path=https://raw.githubusercontent.com/yichahucha/surge/master/tb_price.js,type=http-response,pattern=^https?://trade-acs\.m\.taobao\.com/gw/mtop\.taobao\.detail\.getdetail
# > 奈飞评分
nf_rating.js = script-path=https://raw.githubusercontent.com/yichahucha/surge/master/nf_rating.js,type=http-request,pattern=^https?://ios\.prod\.ftl\.netflix\.com/iosui/user/.+path=%5B%22videos%22%2C%\d+%22%2C%22summary%22%5D
nf_rating.js = requires-body=1,script-path=https://raw.githubusercontent.com/yichahucha/surge/master/nf_rating.js,type=http-response,pattern=^https?://ios\.prod\.ftl\.netflix\.com/iosui/user/.+path=%5B%22videos%22%2C%\d+%22%2C%22summary%22%5D
单集评分 = type=http-response,pattern=^https?://ios\.prod\.ftl\.netflix\.com/iosui/warmer/.+type=show-ath,requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/yichahucha/surge/master/nf_rating_season.js
# > 微博去广告
wb_launch.js = requires-body=1,script-path=https://raw.githubusercontent.com/yichahucha/surge/master/wb_launch.js,type=http-response,pattern=^https?://(sdk|wb)app\.uve\.weibo\.com(/interface/sdk/sdkad.php|/wbapplua/wbpullad.lua)
wb_ad.js = type=http-response,requires-body=1,max-size=-1,pattern=^https?://m?api\.weibo\.c(n|om)/2/(statuses/(unread|extend|positives/get|(friends|video)(/|_)(mix)?timeline)|stories/(video_stream|home_list)|(groups|fangle)/timeline|profile/statuses|comments/build_comments|photo/recommend_list|service/picfeed|searchall|cardlist|page|!/photos/pic_recommend_status|video/tiny_stream_video_list|photo/info),script-path=https://raw.githubusercontent.com/yichahucha/surge/master/wb_ad.js

# > Choler
# > 抖音 & TikTok Remove Ad & Logo
douyin_ad = type=http-response,pattern=^https?:\/\/aweme\.snssdk\.com\/aweme\/v1\/(feed|aweme\/post|follow\/feed|nearby\/feed|search\/item|general\/search\/single|hot\/search\/video\/list)\/,requires-body=1,max-size=-1,script-path=https://Choler.github.io/Surge/Script/douyin.js

# > 微信公众号
WeChat.js = script-path=https://Choler.github.io/Surge/Script/WeChat.js,type=http-request,pattern=^https://mp\.weixin\.qq\.com/mp/getappmsgad
# > YouTube
//YouTube.js = script-path=https://Choler.github.io/Surge/Script/YouTube.js,type=http-request,pattern=^https://[\s\S]*\.googlevideo\.com/.*&(oad|ctier)

# > 腾讯新闻 去广告
QQNews.js = requires-body=1,script-path=https://Choler.github.io/Surge/Script/QQNews.js,type=http-response,pattern=^https://r\.inews\.qq.com\/get(QQNewsUnreadList|RecommendList)
# > 人人视频 去广告
rrsp_video = type=http-response,requires-body=true,pattern=^https?:\/\/api\.rr\.tv\/watch\/v\d\/get_movie_info,script-path=https://Choler.github.io/Surge/Script/rrsp.js
rrsp_banner = type=http-response,requires-body=true,pattern=^https?:\/\/api\.rr\.tv\/v\dplus\/index\/channel$,script-path=https://Choler.github.io/Surge/Script/rrsp.js
# > onewayticket255
# > 知乎 去广告
zhihu people = type=http-response,requires-body=1,max-size=0,pattern=https://api.zhihu.com/people/,script-path=https://raw.githubusercontent.com/onewayticket255/Surge-Script/master/surge%20zhihu%20people.js
zhihu feed = type=http-response,requires-body=1,max-size=0,pattern=https://api.zhihu.com/moments/recommend,script-path=https://raw.githubusercontent.com/onewayticket255/Surge-Script/master/surge%20zhihu%20feed.js
zhihu recommend = type=http-response,requires-body=1,max-size=0,pattern=https://api.zhihu.com/topstory/recommend,script-path=https://raw.githubusercontent.com/onewayticket255/Surge-Script/master/surge%20zhihu%20recommend.js
zhihu answer = type=http-response,requires-body=1,max-size=0,pattern=https://api.zhihu.com/v4/questions,script-path=https://raw.githubusercontent.com/onewayticket255/Surge-Script/master/surge%20zhihu%20answer.js
# > 哔哩哔哩 精简&去广告
//收藏排行 = type=http-response,requires-body=1,max-size=0,pattern=https://app.bilibili.com/x/v2/space\?access_key,script-path=https://raw.githubusercontent.com/onewayticket255/Surge-Script/master/surge%20bilibili%20space.js
首页 tab = type=http-response,requires-body=1,max-size=0,pattern=https://app.bilibili.com/x/resource/show/tab\?access_key,script-path=https://raw.githubusercontent.com/onewayticket255/Surge-Script/master/surge%20bilibili%20tab.js
bilibili feed = type=http-response,requires-body=1,max-size=0,pattern=https://app.bilibili.com/x/v2/feed/index\?access_key,script-path=https://raw.githubusercontent.com/onewayticket255/Surge-Script/master/surge%20bilibili%20feed.js
个人中心 = type=http-response,requires-body=1,max-size=0,pattern=https://app.bilibili.com/x/v2/account/mine\?access_key,script-path=https://raw.githubusercontent.com/onewayticket255/Surge-Script/master/surge%20bilibili%20account.js
bilibili view = type=http-response,requires-body=1,max-size=0,pattern=https://app.bilibili.com/x/v2/view\?access_key,script-path=https://raw.githubusercontent.com/onewayticket255/Surge-Script/master/surge%20bilibili%20view%20relate.js
bilibili reply = type=http-response,requires-body=1,max-size=0,pattern=https://api.bilibili.com/x/v2/reply/main\?access_key,script-path=https://raw.githubusercontent.com/onewayticket255/Surge-Script/master/surge%20bilibili%20reply.js
bilibili live = type=http-response,requires-body=1,max-size=0,pattern=https://api.live.bilibili.com/xlive/app-room/v1/index/getInfoByRoom\?access_key,script-path=https://raw.githubusercontent.com/onewayticket255/Surge-Script/master/surge%20bilibili%20live.js
# > NobyDa
# > 皮皮虾  Remove Ad & Logo
Super.js = requires-body=1,max-size=-1,script-path=https://raw.githubusercontent.com/Liquor030/Sub_Ruleset/master/Script/Super.js,type=http-response,pattern=^https?://.*\.snssdk\.com/bds/(feed/stream|comment/cell_reply|cell/cell_comment|cell/detail|ward/list|user/favorite|user/cell_coment|user/cell_userfeed|user/publish_list)
# > 酷我音乐SVIP (By yxiaocai)
Kuwo.js = requires-body=1,script-path=https://raw.githubusercontent.com/NobyDa/Script/master/Surge/JS/KuWoMusicDownload.js,type=http-request,pattern=^https?:\/\/musicpay\.kuwo.cn\/music\.pay\?uid=\d+
Kuwo.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/NobyDa/Script/master/Surge/JS/Kuwo.js,type=http-response,pattern=^https?:\/\/vip1\.kuwo\.cn\/(vip\/v2\/user\/vip|vip\/spi/mservice)
# > 小小影视  去广告(By Eric)
小小影视 = type=http-response,pattern=https:\/\/.*\/getGlobalData,requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/Alex0510/Eric/master/surge/Script/xxysad.js,script-update-interval=0
# > 爱美剧Vip (by huihui）(官网：app.meiju2018.com)
aimeiju.js = requires-body=1,script-path=https://raw.githubusercontent.com/NobyDa/Script/master/QuantumultX/File/aimeiju.js,type=http-response,pattern=^https?:\/\/api.bjxkhc.com\/index\.php\/app\/ios\/(vod\/show|(user|vod|topic|type)\/index)
# > 网易蜗牛读书VIP (By yxiaocai and JO2EY)
wnyd.js = requires-body=1,script-path=https://raw.githubusercontent.com/NobyDa/Script/master/QuantumultX/File/wnyd.js,type=http-response,pattern=^https?:\/\/p\.du\.163\.com\/gain\/readtime\/info\.json
# > 看漫画极速版vip (By HoGer)
kmh.js = requires-body=1,script-path=https://raw.githubusercontent.com/NobyDa/Script/master/QuantumultX/File/kmh.js,type=http-response,pattern=^https?:\/\/getuserinfo\.321mh\.com\/app_api\/v5\/getuserinfo\/
# > 知音漫客VIP (By mieqq)
Zymh.js = requires-body=1,script-path=https://raw.githubusercontent.com/NobyDa/Script/master/QuantumultX/File/Zymh.js,type=http-response,pattern=^https://getuserinfo-globalapi.zymk.cn/app_api/v5/(getuserinfo|coin_account|getuserinfo_ticket|getcomicinfo)/
# > VSCO滤镜VIP
vsco.js = requires-body=1,script-path=https://raw.githubusercontent.com/nzw9314/QuantumultX/master/NobyDa/QuantumultX/File/vsco.js,type=http-response,pattern=^https?:\/\/vsco\.co\/api\/subscriptions\/2.1\/user-subscriptions\/
# > 大片-视频编辑器 VIP
dapian.js = requires-body=1,script-path=https://raw.githubusercontent.com/NobyDa/Script/master/QuantumultX/File/dapian.js,type=http-response,pattern=^https?:\/\/api\.vnision\.com\/v1\/(users\/|banners)
# > 91短视频
91.js = requires-body=1,script-path=https://raw.githubusercontent.com/NobyDa/Script/master/QuantumultX/File/91.js,type=http-response,pattern=“^https?:\/\/.+\.(my10api|(.*91.*))\.(com|tips|app|xyz)(:\d{2,5})?\/api.php$”
# > 香蕉视频VIP
xjsp.js = requires-body=1,script-path=https://raw.githubusercontent.com/NobyDa/Script/master/QuantumultX/File/xjsp.js,type=http-response,pattern=^https?:\/\/.*\.(lago|fuli|xiang(jiao|xiang))apps\.com\/(ucp\/index|getGlobalData|.+\/reqplay\/)
# > 用药助手解锁专业版 (By Primovist)
yyzs.js = requires-body=1,script-path=https://raw.githubusercontent.com/NobyDa/Script/master/Surge/JS/yyzs.js,type=http-response,pattern=^https?:\/\/(i|newdrugs)\.dxy\.cn\/(snsapi\/username\/|app\/user\/(pro\/stat\?|init\?timestamp=))
# > 陆琪讲故事
luqi.js = requires-body=1,script-path=https://raw.githubusercontent.com/NobyDa/Script/master/Surge/JS/luqi.js,type=http-response,pattern=^https:\/\/www\.luqijianggushi\.com\/api\/v2\/user\/get
# > WPS (By eHpo)
Wps.js = requires-body=1,script-path=https://raw.githubusercontent.com/NobyDa/Script/master/Surge/JS/Wps.js,type=http-response,pattern=^https://account.wps.*/api/users/
# > Gyroscope 解锁 pro (By Maasea)
gyroscope.js = requires-body=1,script-path=https://raw.githubusercontent.com/nzw9314/QuantumultX/master/NobyDa/Surge/JS/gyroscope.js,type=http-response,pattern=^https:\/\/api\.gyrosco\.pe\/v1\/account\/$
# > 大千视界
dqsj.js = requires-body=1,script-path=https://raw.githubusercontent.com/NobyDa/Script/master/Surge/JS/dqsj.js,type=http-response,pattern=^https:\/\/api\.mvmtv\.com\/index\.php.*(c=user.*a=info|a=addr.*vid=.*)
# JibJab解锁pro
jibjab.js = requires-body=1,script-path=https://raw.githubusercontent.com/NobyDa/Script/master/Surge/JS/jibjab.js,type=http-response,pattern=^https:\/\/origin-prod-phoenix\.jibjab\.com\/v1\/user
# Termius 解锁本地pro  (By Maasea)
Termius.js = requires-body=1,script-path=https://raw.githubusercontent.com/nzw9314/QuantumultX/master/NobyDa/Surge/JS/Termius.js,type=http-response,pattern=https:\/\/api\.termius\.com\/api\/v3\/bulk\/account\/
# 小影 解锁Vip (By @hiepkimcdtk55)
vivavideo.js = requires-body=1,script-path=https://raw.githubusercontent.com/NobyDa/Script/master/Surge/JS/vivavideo.js,type=http-response,pattern=^https:\/\/viva\.v21xy\.com\/api\/rest\/u\/vip
# 彩云天气 Vip
彩云天气 = type=http-response,pattern=https://biz.caiyunapp.com/v2/user\?app_name=weather,requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/nzw9314/Surge/master/Script/caiyun.js
# Keep 解锁私人课程和动作库 (QX存在bug 该脚本可能无法生效)
Keep.js = requires-body=1,script-path=https://raw.githubusercontent.com/nzw9314/QuantumultX/master/NobyDa/Surge/JS/Keep.js,type=http-response,pattern=^https:\/\/api\.gotokeep\.com\/(.+\/subject|.+\/dynamic)
# 扫描全能王 pro
CamScanner.js = requires-body=1,script-path=https://raw.githubusercontent.com/NobyDa/Script/master/Surge/JS/CamScanner.js,type=http-response,pattern=^https:\/\/(api|api-cs)\.intsig\.net\/purchase\/cs\/query_property\?
# VUE pro
VUE.js = requires-body=1,script-path=https://raw.githubusercontent.com/NobyDa/Script/master/Surge/JS/VUE.js,type=http-response,pattern=^https:\/\/api\.vuevideo\.net\/api\/v1\/(users\/.+\/profile|subtitle\/prepare)
# NiChi 解锁素材
NiChi.js = requires-body=1,script-path=https://raw.githubusercontent.com/NobyDa/Script/master/Surge/JS/NiChi.js,type=http-response,pattern=^https?:\/\/mp\.bybutter\.com\/mood\/(official-templates|privileges)
# PicsArt美易 pro
PicsArt.js = requires-body=1,script-path=https://raw.githubusercontent.com/NobyDa/Script/master/Surge/JS/PicsArt.js,type=http-response,pattern=^https:\/\/api\.(picsart|meiease)\.c(n|om)\/users\/show\/me\.json
# Splice 视频编辑器 pro
Splice.js = requires-body=1,script-path=https://raw.githubusercontent.com/nzw9314/QuantumultX/master/NobyDa/Surge/JS/Splice.js,type=http-response,pattern=^https:\/\/splice\.oracle\.\w+\.com\/devices\/me
# 动画疯 去广告
Bahamut.js = requires-body=1,script-path=https://raw.githubusercontent.com/NobyDa/Script/master/Surge/JS/Bahamut.js,type=http-request,pattern=https:\/\/api\.gamer\.com\.tw\/mobile_app\/anime\/v3\/token\.php
Bahamut.js = requires-body=1,script-path=https://raw.githubusercontent.com/NobyDa/Script/master/Surge/JS/Bahamut.js,type=http-response,pattern=https:\/\/api\.gamer\.com\.tw\/mobile_app\/anime\/v3\/token\.php
# > 以下为nzw9314收集整理
# > superuv
# > 驾校一点通 (by @superuv)
jxydt.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/nzw9314/QuantumultX/master/Script/jxydt.js,type=http-response,pattern=^https:\/\/vipapi\.jxedt\.com\/vip\/check
# > 海豚记账 (by @superuv)
HTJZ.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/nzw9314/QuantumultX/master/Script/HTJZ.js,type=http-response,pattern=https:\/\/book\.haitunwallet\.com\/app\/vip\/status
# > Pocket list (by @superuv)
pock.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/nzw9314/QuantumultX/master/Script/pock.js,type=http-response,pattern=^https:\/\/pocketlists\.com\/api\/v1\/pocketlists.me.get
# > 幕布(by @superuv)
mb.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/nzw9314/QuantumultX/master/Script/mb.js,type=http-response,pattern=https:\/\/mubu\.com\/api\/app\/user\/info
# 智能证件照相机 (by @superuv)
znzj.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/nzw9314/QuantumultX/master/Script/znzj.js,type=http-response,pattern=^https:\/\/app\.xunjiepdf\.com\/api\/v4\/virtualactregister
# 猫咪翻译(by @superuv)
mmfy.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/nzw9314/QuantumultX/master/Script/mmfy.js,type=http-response,pattern=http:\/\/miaow\.yiyongcad\.com\/api\/v4\/memprofile
# 微商助手(by @superuv)
wszs.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/nzw9314/QuantumultX/master/Script/wszs.js,type=http-response,pattern=https:\/\/api\.lennou\.com\/user\/info
# gk扫描仪(by @superuv)
smy.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/nzw9314/QuantumultX/master/Script/smy.js,type=http-response,pattern=^https:\/\/api\.gkocr\.com\/api\/userlogin1.php
# > Miao Miao
# > Bear熊掌记 (By Miao Miao)
// bear.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/nzw9314/QuantumultX/master/Script/bear.js,type=http-response,pattern=^https:\/\/buy\.itunes\.apple\.com\/verifyReceipt
# > 第一弹  (By Miao Miao)
# > 去广告+原画
Diyidan.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/nzw9314/QuantumultX/master/Script/Diyidan.js,type=http-response,pattern=^https:\/\/api\.diyidan\.net\/v0\.3\/(user\/personal_homepage|vip_user\/info|tv_series\/index\?appChanne)
# > syzzzf
# 轻颜相机 & ulike & 蒸汽波相机(vaporcam)三合一 解锁VIP(By @s y & Alex0510)
qyxj.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/nzw9314/QuantumultX/master/Script/qyxj.js,type=http-response,pattern=^https:\/\/commerce-.*api\.faceu\.mobi\/commerce\/v1\/subscription\/user_info
# CPU Dasher破解(需要ios13 恢复购买后禁用掉 By @s y)
// cupdasher.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/nzw9314/QuantumultX/master/Script/cupdasher.js,type=http-response,pattern=^https:\/\/p.+-buy\.itunes\.apple\.com\/WebObjects\/MZFinance.woa\/wa\/inAppRegrantPurchaseHistory
# 酷我换肤(已经有的皮肤需要先从本地皮肤删除再换 By@ s y)
themekuwo.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/nzw9314/QuantumultX/master/Script/themekuwo.js,type=http-response,pattern=^https?:\/\/vip1\.kuwo\.cn\/(vip\/v2\/theme)
# > Alex0510
# > 水印精灵 vip (By Alex0510)
syjl.js = requires-body=1,script-path=https://raw.githubusercontent.com/NobyDa/Script/master/Surge/JS/syjl.js,type=http-response,pattern=^https:\/\/api1\.dobenge\.cn\/api\/user\/getuserinfo
# > 有道云笔记 (By Alex0510)
ydybj.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/Alex0510/Eric/master/surge/Script/ydybj.js,type=http-response,pattern=https://note.youdao.com/yws/(mapi/payment|api/self)
# > 彩云小译 (By Alex0510)
cyxy.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/nzw9314/QuantumultX/master/Script/cyxy.js,type=http-response,pattern=^https:\/\/api\.interpreter\.caiyunai\.com\/v1\/user
# > 石墨文档 (By Alex0510)
shimo.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/nzw9314/QuantumultX/master/Script/shimo.js,type=http-response,pattern=https://api.shimo.im/users/
# 手机硬件管家 (By Alex0510)
sjyjgj.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/nzw9314/QuantumultX/master/Script/sjyjgj.js,type=http-response,pattern=http:\/\/api\.591master\.com\:8081\/(1.0|3.6.8)\/ui(forum|common)\/(downloadwallpaper|getuser)
# 花椒视频 (By Alex0510)
hjsp.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/nzw9314/QuantumultX/master/Script/hjsp.js,type=http-response,pattern=http://user.shywck.com/user/userinfo
# > 凉意
# 韩剧TV (By 凉意)
# 下载地址请看脚本内说明
hanjuTV.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/nzw9314/QuantumultX/master/Script/hanjuTV.js,type=http-response,pattern=https\:\/\/hjapi\.bjxkhc\.com\/v2d2\/users\/.*\/member
# 筋斗云tv (By 凉意)
jdyTV.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/nzw9314/QuantumultX/master/Script/jdyTV.js,type=http-response,pattern=^http\:\/\/jdytv\.cn\/login\/login\/veifys
# 闪电下载vip (By 凉意)
sdxz.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/nzw9314/QuantumultX/master/Script/sdxz.js,type=http-response,pattern=^http\:\/\/app\.flashdown365\.com\/ios\/login
# > JAV101无限观看 (By 凉意)
JAV101.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/nzw9314/QuantumultX/master/Script/JAV101.js,type=http-response,pattern=^https\:\/\/pwaapi\.gao1gps\.cn\/v1\/user\/info
# > 黑黑酱
# 小睡眠（by 黑黑酱）
xiaoshuimian.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/nzw9314/QuantumultX/master/Script/xiaoshuimian.js,type=http-response,pattern=^https:\/\/api\.psy-1\.com\/cosleep\/user\/info
# 蜗牛睡眠会员（by 黑黑酱）
wnsm.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/nzw9314/QuantumultX/master/Script/wnsm.js,type=http-response,pattern=^https:\/\/snailsleep\.net\/snail\/v1\/profile\/get
# 西窗烛 （By 黑黑酱）
xcz.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/nzw9314/QuantumultX/master/Script/xcz.js,type=http-response,pattern=^https:\/\/avoscloud\.com\/1\.1\/users\/
# > 美颜相机一次性解锁内购（by黑黑酱）
myxj.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/nzw9314/QuantumultX/master/Script/myxj.js,type=http-response,pattern=^https:\/\/api\.meiyan\.com\/iap\/verify\.json
# Fit健身会员 （by黑黑酱）
fit.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/nzw9314/QuantumultX/master/Script/fit.js,type=http-response,pattern=^https:\/\/bea\.sportq\.com\/SFitWeb\/sfit\/getUserBaseInfo
# > LTribe
# > 万里影视 无限时常（by LTribe）
Wanliyingshi.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/nzw9314/QuantumultX/master/Script/Wanliyingshi.js,type=http-response,pattern=^http?:\/\/.*\.arten.cn/login/login
# VideoStar Unlock（by LTribe）
VideoStar.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/nzw9314/QuantumultX/master/Script/VideoStar.js,type=http-response,pattern=^https?:\/\/.*\.videostarapp\.com\/scripts\/subsNew\.php
# 迅捷应用6合1 （by LTribe）
xunjie.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/nzw9314/QuantumultX/master/Script/xunjie.js,type=http-response,pattern=^https?:\/\/.*\.xunjie.*\.com\/api\/v\d\/*
# > 军哥哥
# > 洪恩双语绘本 (By 军哥哥)
hnsyhb.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/nzw9314/QuantumultX/master/Script/hnsyhb.js,type=http-response,pattern=https:\/\/bookapi\.ihuman\.com\/(v1\/get\_user\_info|v1\/get\_purchase\_list)
# > 中国体育直播unlock (By 军哥哥)
zgtyzb.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/nzw9314/QuantumultX/master/Script/zgtyzb.js,type=http-response,pattern=http:\/\/rest\.zhibo\.tv\/room\/get\-room\-info\-v430
# > sunshy
# > Fantastical 内购解锁 (By @sunshy)
fantastical.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/nzw9314/QuantumultX/master/Script/fantastical.js,type=http-response,pattern=^https:\/\/api\.flexibits\.com\/v1\/(auth|account)\/(device|details|appstore-receipt)\/$
# > SoloLearn Unlock PRO & Platinum Moderator (By @sunshy)
sololearn.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/nzw9314/QuantumultX/master/Script/sololearn.js,type=http-response,pattern=https:\/\/api\.sololearn\.com\/(authenticateDevice|challenge\/GetContestFeed|Profile\/GetProfile)$
# > CheeryTodo
# Pillow (By @CheeryTodo)
pillow.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/nzw9314/QuantumultX/master/Script/pillow.js,type=http-response,pattern=https:\/\/api\.revenuecat\.com\/v1\/(subscribers|receipts)
# 马卡龙 (By @CheeryTodo)
mkl.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/nzw9314/QuantumultX/master/Script/mkl.js,type=http-response,pattern=https://app.api.versa-ai.com/pay/order/iap/check
# 流利说.阅读 (by@火羽&@singee)
llyd.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/nzw9314/QuantumultX/master/Script/llyd.js,type=http-response,pattern=^https?:\/\/vira\.llsapp\.com\/api\/v2\/readings\/(accessible|limitation)
# 115离线 (请仔细阅读脚本内使用说明 By ikanam)
115lx.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/nzw9314/QuantumultX/master/Script/115lx.js,type=http-response,pattern=^http:\/\/115\.com\/lx.*$
# lake
lake.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/nzw9314/QuantumultX/master/Script/lake.js,type=http-response,pattern=^https:\/\/api\.lakecoloring\.com\/v1\/receipt
# > 人人视频 解锁AI原画 (by@george Jiang & R)
rrtv.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/nzw9314/QuantumultX/master/Script/rrtv.js,type=http-response,pattern=^https:\/\/api\.rr\.tv(\/user\/privilege\/list|\/ad\/getAll|\/rrtv-video\/v4plus\/season\/detail)
# 每日英语阅读/每日外刊 解锁课程  (By chamberlen)
mryy.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/nzw9314/QuantumultX/master/Script/mryy.js,type=http-response,pattern=^https:\/\/dict\.eudic\.net\/jingting\/GetThisChapterTaskStatus?
# > WPS (By eHpo1)
Wps.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/NobyDa/Script/master/Surge/JS/Wps.js,type=http-response,pattern=^https://account.wps.*/api/users/
# > 菜谱大全解锁vip (By @photonmang)
cpdq.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/nzw9314/QuantumultX/master/Script/cpdq.js,type=http-response,pattern=https?:\/\/api\.jiaonizuocai\.com
# > 头脑吃鸡 (By chavyleung)
tncj.min.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/chavyleung/scripts/master/tncj/tncj.min.js,type=http-response,pattern=^https://tncj.hortorgames.com/chicken/fight/(answer|findQuiz)
# > Pear雪梨 unlock vip
pear.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/nzw9314/QuantumultX/master/Script/pear.js,type=http-response,pattern=^https:\/\/(www\.baidu.com2\.club|ayk\.tmdidi\.com|m\.pearkin\.com|souhu\.mett\.me|bkcd\.b-cdn\.net)\/(api\/movie\/WatchMovie|api\/Account\/CheckVip|api\/account\/IndexDetail)
# > 克拉壁纸  解锁付费壁纸 (By @Dachaw)
clarity.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/nzw9314/QuantumultX/master/Script/clarity.js,type=http-response,pattern=^https:\/\/claritywallpaper\.com\/clarity\/api\/(userInfo|special\/queryByCatalogAll)
# > Peak 解锁Pro
peak.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/nzw9314/QuantumultX/master/Script/peak.js,type=http-response,pattern=^https:\/\/billing\.peakcloud\.org\/billing\/2\/user\/me?
# > IT之家 去新闻列表广告
ITHome.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/nzw9314/QuantumultX/master/Script/ITHome.js,type=http-response,pattern=^https?:\/\/api\.ithome\.com\/json\/slide\/index
ITHome.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/nzw9314/QuantumultX/master/Script/ITHome.js,type=http-response,pattern=^https?:\/\/api\.ithome\.com\/json\/(newslist|listpage)\/news
# > XMind思维导图
XMind.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/nzw9314/QuantumultX/master/Script/XMind.js,type=http-response,pattern=https:\/\/www\.xmind\.cn\/\_res\/devices
# > 奇热小说 解锁收费章节(By @@ios4521)
qrxs.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/nzw9314/QuantumultX/master/Script/qrxs.js,type=http-response,pattern=^https://api.weiqire.com/api3/(visitor/|user/unlockCharpter)
# > 可可英语会员
kkyy.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/nzw9314/QuantumultX/master/Script/kkyy.js,type=http-response,pattern=^https:\/\/mob2015\.kekenet\.com\/keke\/mobile\/index\.php
# > 飒漫画 (By @u18888)
Smh.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/nzw9314/QuantumultX/master/Script/Smh.js,type=http-response,pattern=^https:\/\/m\.samh\.xndm\.tech\/userapi\/info\/v1\/getuserinfo
# > 油猴转换器 (by Peng-YM)
Greasy Fork=type=http-response, pattern=^https:\/\/(greasyfork|openuserjs)\.org\/.*\/.*\.user\.js, script-path=https://raw.githubusercontent.com/Peng-YM/QuanX/master/Rewrites/GreasyFork/greasy-fork.js, requires-body=true

# > Langkhach越南老哥
# > all apps monkey
monkey.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/langkhach270389/Scripting/master/monkey.js,script-update-interval=0,type=http-response,pattern=^https:\/\/www\.api\.monkeyuni\.net\/api\/.+\/mobile\/account\/load-update
# > NOMO
nomo.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/langkhach270389/Scripting/master/nomo.js,script-update-interval=0,type=http-response,pattern=^https:\/\/nomo\.dafork\.com\/api\/v2\/iap\/ios_product_list
# > Faded
Faded.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/langkhach270389/Scripting/master/Faded.js,script-update-interval=0,type=http-response,pattern=^https:\/\/api\.madewithfaded\.com\/api\/.+\/subscription\/validate$
remove-nonematch.js = script-path=https://raw.githubusercontent.com/langkhach270389/Scripting/master/remove-nonematch.js,script-update-interval=0,type=http-request,pattern=^https:\/\/secure\.istreamer\.com\/backend$
# > playerxtreme
playerxtreme.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/langkhach270389/Scripting/master/playerxtreme.js,script-update-interval=0,type=http-response,pattern=^https:\/\/secure\.istreamer\.com\/backend$
# > grammarly
grammarly.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/langkhach270389/Scripting/master/grammarly.js,script-update-interval=0,type=http-response,pattern=^https:\/\/subscription\.grammarly\.com\/api\/v1$
# > nichi
nichi.js = requires-body=1,max-size=1048576,script-path=https://raw.githubusercontent.com/langkhach270389/Scripting/master/nichi.js,script-update-interval=0,type=http-response,pattern=https?:\/\/mp\.bybutter\.com\/mood\/(official-templates|privileges)
# > splice
splice.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/langkhach270389/Scripting/master/splice.js,script-update-interval=0,type=http-response,pattern=https:\/\/splice\.oracle\.\w+\.com\/devices\/me
# > planner5d
planner5d.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/langkhach270389/Scripting/master/planner5d.js,script-update-interval=0,type=http-response,pattern=^https:\/\/planner5d\.com\/api\/sets

# > Ulysses
http-request ^https:\/\/sk\.ulysses\.app\/api\/v1\/user_offers$ script-path=https://raw.githubusercontent.com/langkhach270389/Scripting/master/cleancacheulysses.js
http-response ^https:\/\/sk\.ulysses\.app\/api\/v1\/itunes_receipt_verify$ requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/langkhach270389/Scripting/master/ulysses.js

# > Dayone
# 1.启用本脚本与 pre 脚本
# 2.重启 Day One，稍等片刻等待高级版出现
# 3.禁用掉 pre 脚本，重启 Day One，确认高级版状况不变
# pre_dayone
// dayone-pre.js = debug=1,script-path=https://raw.githubusercontent.com/nzw9314/QuantumultX/master/Script/dayone-pre.js,type=http-request,pattern=^https:\/\/dayone\.me\/api\/users$
dayone.surge.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/langkhach270389/Scripting/master/dayone.surge.js,script-update-interval=0,type=http-response,pattern=^https:\/\/dayone\.me\/api\/(users|v2\/users\/(account-status|receipt))$
# > endel
endel.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/langkhach270389/Scripting/master/endel.js,script-update-interval=0,type=http-response,pattern=^https:\/\/api-production\.endel\.io\/.*\/user$
# > itranslate
itranslate.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/langkhach270389/Scripting/master/itranslate.js,script-update-interval=0,type=http-response,pattern=^https:\/\/ssl-api\.itranslateapp\.com\/.*\/subscriptions\/.*\/ios$
# > photoshop
photoshop.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/langkhach270389/Scripting/master/photoshop.js,script-update-interval=0,type=http-response,pattern=^https:\/\/lcs-mobile-cops\.adobe\.io\/mobile_profile
# > draft
draft.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/langkhach270389/Scripting/master/draft.js,script-update-interval=0,type=http-response,pattern=^https:\/\/backend\.getdrafts\.com\/api\/.*\/verification
# > workingcopy.js
workingcopy.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/langkhach270389/Scripting/master/workingcopy.js,script-update-interval=0,type=http-response,pattern=^https:\/\/education\.github\.com\/api\/user$
# > speak&translate
speak&translate.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/langkhach270389/Scripting/master/speak&translate.js,script-update-interval=0,type=http-response,pattern=^https:\/\/receipt-validator\.herewetest\.com\/apple\/verifyTransaction$
# > over
over.vip.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/langkhach270389/Scripting/master/over.vip.js,script-update-interval=0,type=http-response,pattern=^https:\/\/api\.overhq\.com\/(user\/token\/refresh$|subscription\/verifyReceipt$)
# > kinemaster
kinemaster.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/langkhach270389/Scripting/master/kinemaster.js,script-update-interval=0,type=http-response,pattern=^https:\/\/api-kinemaster-assetstore\.(nexstreaming|kinemasters)\.com\/.+\/product\/verifyReceipt$
# > musicalm
musicalm.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/langkhach270389/Scripting/master/musicalm.js,script-update-interval=0,type=http-response,pattern=^https:\/\/www\.peacefulsoundsapp\.com\/api\/v1\/init$
# > lingokids
lingokids.vip.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/langkhach270389/Scripting/master/lingokids.vip.js,script-update-interval=0,type=http-response,pattern=^https:\/\/api\.lingokids\.com\/v1\/renovate_session$
# > Bright
verify_receipt.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/langkhach270389/Scripting/master/verify_receipt.js,script-update-interval=0,type=http-response,pattern=^https:\/\/engbright\.com\/app-portal\/apple\/receipt$
# > #mojo&noto
revenuecat.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/langkhach270389/Scripting/master/revenuecat.js,script-update-interval=0,type=http-response,pattern=^https:\/\/api\.revenuecat\.com\/.+\/(receipts$|subscribers\/[a-zA-Z0-9_-]*$)
# > mimo
mimo.vip.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/langkhach270389/Scripting/master/mimo.vip.js,script-update-interval=0,type=http-response,pattern=^https:\/\/api\.getmimo\.com\/v1\/subscriptions$
# > boom
verify_receipt.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/langkhach270389/Scripting/master/verify_receipt.js,script-update-interval=0,type=http-response,pattern=^https:\/\/apimboom2\.globaldelight\.net\/itunesreceipt_v2\.php$
# > musixmatch
musixmatch.miao.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/langkhach270389/Scripting/master/musixmatch.miao.js,script-update-interval=0,type=http-response,pattern=^https:\/\/apic\.musixmatch\.com\/ws\/.*\/config\.get
# > productive&sleepzy
Productive = type=http-response,pattern=^https:\/\/subs\.platforms\.team\/.+\/apple\/verify$,requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/langkhach270389/Scripting/master/productive.js,script-update-interval=0
# > Pdfexpert
Pdfexpert.vip.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/langkhach270389/Scripting/master/Pdfexpert.vip.js,script-update-interval=0,type=http-response,pattern=^https:\/\/license\.pdfexpert\.com\/api\/.+\/subscription\/(refresh$|check$)
# > Lightroom
Lightroom.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/langkhach270389/Scripting/master/Lightroom.js,script-update-interval=0,type=http-response,pattern=^https:\/\/photos\.adobe\.io\/v2\/accounts
# > calm
calm.vip.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/langkhach270389/Scripting/master/calm.vip.js,script-update-interval=0,type=http-response,pattern=^https:\/\/api\.calm\.com\/(me$|receipt$)
# > zingtv
zingtvvipv1.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/langkhach270389/Scripting/master/zingtvvipv1.js,script-update-interval=0,type=http-response,pattern=^https?:\/\/api\.tv\.zing\.vn\/.+/user
# > camera360
camera360.vip.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/langkhach270389/Scripting/master/camera360.vip.js,script-update-interval=0,type=http-response,pattern=^https:\/\/bmall\.camera360\.com\/api\/(iap\/check-receipt$|mix\/getinfo$)
# > beautyplus
beautyplusvip.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/langkhach270389/Scripting/master/beautyplusvip.js,script-update-interval=0,type=http-response,pattern=^https:\/\/api-intl\.mr\.meitu\.com/.*/subs_offer_elg$
# > elevate
elevate.vip.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/langkhach270389/Scripting/master/elevate.vip.js,script-update-interval=0,type=http-response,pattern=^https:\/\/accounts\.elevateapp\.net\/api\/users\?user%5Bauthentication_token
# > busuu
busuu.vip.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/langkhach270389/Scripting/master/busuu.vip.js,script-update-interval=0,type=http-response,pattern=^https:\/\/api\.busuu\.com\/users\/me
# > mondly
mondly.vip.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/langkhach270389/Scripting/master/mondly.vip.js,script-update-interval=0,type=http-response,pattern=^https:\/\/api\.mondlylanguages\.com\/v1\/ios\/user\/sync$
# > drops
drops.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/langkhach270389/Scripting/master/drops.js,script-update-interval=0,type=http-response,pattern=^https:\/\/lambda\.us-east-1\.amazonaws\.com/.*/functions\/prod-4-syncPurchases\/invocations$
# > elsa
elsa-response.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/langkhach270389/Scripting/master/elsa-response.js,script-update-interval=0,type=http-response,pattern=^https:\/\/pool\.elsanow\.io\/user\/api\/v1\/purchase$
# > syn.me
syn.me.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/langkhach270389/Scripting/master/syn.me.js,script-update-interval=0,type=http-response,pattern=^https:\/\/api\.sync\.me\/api\/purchases\/(report_purchases|get_purchases)
# > memrise
memrise.vip.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/langkhach270389/Scripting/master/memrise.vip.js,script-update-interval=0,type=http-response,pattern=^https:\/\/api\.memrise\.com\/.+\/(me\/$|dashboard\/$|leaderboards\/following\/)
# > nhaccuatui
nhaccuatui.js = requires-body=1,max-size=0,debug=1,script-path=https://raw.githubusercontent.com/langkhach270389/Scripting/master/nhaccuatui.js,script-update-interval=0,type=http-response,pattern=^https:\/\/graph\.nhaccuatui\.com\/.*\/users\/info
# > Unfold
Unfold.vip.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/langkhach270389/Scripting/master/Unfold.vip.js,script-update-interval=0,type=http-response,pattern=^https:\/\/api\.unfold\.app\/v1\/ios\/receipts$
# > videoshow
videoshow.vip.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/langkhach270389/Scripting/master/videoshow.vip.js,script-update-interval=0,type=http-response,pattern=^https:\/\/owa\.videoshowiosglobalserver\.com\/zone\/.+\/iosPayClient\/(payVerify|imeiVerify)
# > Buyhack
verify_receipt.js = requires-body=1,max-size=262144,script-path=https://raw.githubusercontent.com/langkhach270389/Scripting/master/verify_receipt.js,script-update-interval=0,type=http-response,pattern=^https:\/\/buy\.itunes\.apple\.com\/verifyReceipt$
# > zingmp3
zingmp3.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/langkhach270389/Scripting/master/zingmp3.js,script-update-interval=0,type=http-response,pattern=^https:\/\/api\.global\.mp3\.zing\.vn\/.+\/getUserInfo\?data=
zingmp3.downloadsong.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/langkhach270389/Scripting/master/zingmp3.downloadsong.js,script-update-interval=0,type=http-response,pattern=^https:\/\/api\.global\.mp3\.zing\.vn\/1\.0\/getDownloadSongInfo\?data
zingmp3.getsong.js = requires-body=1,max-size=0,script-path=https://raw.githubusercontent.com/langkhach270389/Scripting/master/zingmp3.getsong.js,script-update-interval=0,type=http-response,pattern=^https:\/\/api\.global\.mp3\.zing\.vn\/1\.0\/getSongInfo\?data

[MITM]
hostname = %APPEND% greasyfork.org, openuserjs.org, 8.8.8.8, 1.1.1.1, *.googlevideo.com, trade-acs.m.taobao.com, bea.sportq.com, api.meiyan.com, pwaapi.gao1gps.cn, avoscloud.com, app.flashdown365.com, m.samh.xndm.tech, mob2015.kekenet.com, api.m.jd.com, ios.prod.ftl.netflix.com, vipapi.jxedt.com, api.interpreter.caiyunai.com, pocketlists.com, book.haitunwallet.com, mubu.com, app.xunjiepdf.com, miaow.yiyongcad.com, api.lennou.com, api.gkocr.com, vira.llsapp.com, commerce-.*api.faceu.mobi, commerce-api.faceu.mobi, pan.baidu.com, api.revenuecat.com, api.rr.tv, editorapi.115.com, api.lakecoloring.com, ctrl.playcvn.com, dict.eudic.net, m.client.10010.com, api.wakamoment.ga, *.bh3.com, api.diyidan.net, api.flexibits.com, api.jiaonizuocai.com, api.sololearn.com, tncj.hortorgames.com, bkcd.b-cdn.net, souhu.mett.me, ayk.tmdidi.com, m.pearkin.com, www.baidu.com2.club, claritywallpaper.com, bookapi.ihuman.com, rest.zhibo.tv, note.youdao.com, billing.peakcloud.org, api.ithome.com, www.xmind.cn, *.arten.cn, api.weiqire.com, api.shimo.im, pay.wecut.com, *.videostarapp.com, app.api.versa-ai.com, *.bjxkhc.com, api.591master.com, jdytv.cn, user.shywck.com, *.xunjie*.com, api.psy-1.com, snailsleep.net, api.weibo.cn, mapi.weibo.com, *.uve.weibo.com, mp.weixin.qq.com, www.zhihu.com, api.zhihu.com, link.zhihu.com, 118.89.204.198, app.bilibili.com, api.bilibili.com, api.live.bilibili.com, *.amemv.com, aweme*.snssdk.com, *.kuwo.cn, vip1.kuwo.cn, *.xiaoxiao*.com, *.tiktokv.com, *.musical.ly, p.du.163.com, getuserinfo.321mh.com, getuserinfo-globalapi.zymk.cn, ios.fuliapps.com, vsco.co, api.vnision.com, *.my10api.com, sp.kaola.com, r.inews.qq.com, apple.fuliapps.com, newdrugs.dxy.cn, app101.avictown.cc, api.hlo.xyz, api.ijo.xyz, www.luqijianggushi.com, account.wps.*, u.kanghuayun.com, api.gyrosco.pe, api1.dobenge.cn, api.mvmtv.com, mitaoapp.yeduapp.com, origin-prod-phoenix.jibjab.com, www.3ivf.com, pay.guoing.com, api.termius.com, api.bjxkhc.com, viva.v21xy.com, biz.caiyunapp.com, api.gotokeep.com, ap*.intsig.net, mp.bybutter.com, api.vuevideo.net, api.picsart.c*, api.meiease.c*, splice.oracle.*.com, api.gamer.com.tw, ios.xiangjiaoapps.com, apple.xiangjiaoapps.com, *.lagoapps.com, api.gamer.com.tw, *.xiangxiangapps.com, avatar-nct.nixcdn.com, spclient.wg.spotify.com, oa.zalo.me, origin-prod-phoenix.jibjab.com, api.meiease.c*, api.unfold.app, viva-asia1.vvbrd.com, graph.nhaccuatui.com, api.memrise.com , api.sync.me, pool.elsanow.io, lambda.us-east-1.amazonaws.com, api.mondlylanguages.com, api.busuu.com, owa.videoshowiosglobalserver.com:0, accounts.elevateapp.net, purchases.ws.pho.to, api-intl.mr.meitu.com, bmall.camera360.com, api.tv.zing.vn, api.calm.com, www.calm.com, api.global.mp3.zing.vn, apimboom2.globaldelight.net, photos.adobe.io, license.pdfexpert.com, subs.platforms.team, apic.musixmatch.com, api.getmimo.com, api.revenuecat.com, engbright.com, api.lingokids.com, www.peacefulsoundsapp.com, duolingo-leaderboards-prod.duolingo.com, mobile-api.adguard.com, api.blinkist.com, api-kinemaster-assetstore.*, api.pushover.net, ap*.intsig.net, api.overhq.com, receipt-validator.herewetest.com, lcs-mobile-cops.adobe.io, education.github.com, backend.getdrafts.com, ssl-api.itranslateapp.com, sk.ulysses.app, dayone.me, license.enpass.io, mp.bybutter.com, *.grammarly.com, splice.oracle.*.com, api.keepkeep.com, planner5d.com, secure.istreamer.com, www.api.monkeyuni.net, api.textnow.me, api.madewithfaded.com, nomo.dafork.com
