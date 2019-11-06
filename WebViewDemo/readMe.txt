1. 导入sdkUtils中所有类

2. 在NetworkManager.m中修改如下宏定义：

APP_ID 填写LeanCloud的APP_ID
APP_KET 填写LeanCloud的APP_KET
MASTER_KEY 填写LeanCloud的MASTER_KEY
HOST_URL 接口服务器地址

3. AppDelegate.h 和 AppDelegate.m 按照Demo中的代码修改

4. 如果需要用Http请求，请在info.plist中加入如下权限

<key>NSAppTransportSecurity</key>
<dict>
	<key>NSAllowsArbitraryLoads</key>
	<true/>
</dict>



另外，在在NetworkManager中有如下两个方法：

请求网址的接口
+ (void)getVersionUpdata: (resultRecived)block;

该接口的返回字段释义如下：
isversion字段表示后台是否开启接口
desc字段如果为空，浏览器将隐藏工具栏，如果为任意字符串，则开启工具栏
url浏览器将访问的网址
version，在后台为字符串，固定写1.0 、2.0或3.0，这里会转换为整形1，2，3
1表示仅竖屏显示
2表示仅横屏显示
1和2以外的其它值为既能横屏又能竖屏显示

初始化推送的接口，需要传入deviceToken
+ (void)pushServiceWithDeviceToken:(NSString*)deviceToken callback:(callback)block;