- [English](README.md)
- [हिन्दी](README.hi.md)

# 代码结构

```
lib/
├── app.dart                 # 应用程序入口和全局配置
├── main.dart               # 主程序入口
├── firebase_options.dart   # Firebase 配置
├── common/                 # 公共组件和工具
├── data/                   # 数据模型和状态管理
├── firestore/             # Firestore 数据库相关操作
├── kits/                  # ZEGO UI Kits 集成
│   ├── call/             # 通话功能
│   │   ├── call_page.dart        # 通话页面
│   │   ├── call_invitation.dart  # 通话邀请
│   │   └── call_settings.dart    # 通话设置
│   ├── live_streaming/   # 直播功能
│   │   ├── live_page.dart       # 直播页面
│   │   ├── pk_page.dart         # PK 功能
│   │   └── live_settings.dart   # 直播设置
│   ├── audio_room/       # 语音聊天室
│   │   ├── audio_room_page.dart    # 语音聊天室页面
│   │   └── audio_room_settings.dart # 语音聊天室设置
│   ├── conference/       # 视频会议
│   │   ├── conference_page.dart    # 视频会议页面
│   │   └── conference_settings.dart # 视频会议设置
│   ├── chat/             # 即时通讯
│   │   ├── chat_page.dart      # 聊天页面
│   │   └── chat_settings.dart  # 聊天设置
│   ├── cache.dart        # 缓存管理
│   ├── room_list.dart    # 房间列表管理
│   ├── express_event_handler.dart # 事件处理
│   └── kits_page.dart    # Kits 页面管理
└── pages/                # 页面组件
    ├── splash.dart       # 启动页
    ├── loading.dart      # 加载页面
    ├── login.dart        # 登录页面
    ├── home.dart         # 主页
    ├── settings.dart     # 设置页面
    ├── about.dart        # 关于页面
    ├── contact.dart      # 联系人页面
    ├── feedback.dart     # 反馈页面
    ├── more_drawer.dart  # 更多抽屉菜单
    └── utils/            # 页面工具类
        └── ...          # 页面相关的工具函数和组件
```

# 简介

demo of zego-uikits

- [call](https://pub.dev/packages/zego_uikit_prebuilt_call)
- [live](https://pub.dev/packages/zego_uikit_prebuilt_live_streaming)
- [audio room](https://pub.dev/packages/zego_uikit_prebuilt_live_audio_room)
- [conference](https://pub.dev/packages/zego_uikit_prebuilt_video_conference)
- [chat](https://pub.dev/packages/zego_zimkit)

demo中介绍了五个kit的基本功能，通过firestore简单的将虚拟用户链接在一起

纯个人用爱发电项目
1. 没有版本计划，多多点赞鼓励
2. 没有技术支持，发现bug和功能需求请提issue

# Getting Started

在使用之前，你需要注册firestore和ZEGO AppID/AppSign

1. Firestore

   - 涉及功能: 通讯录、直播PK主播列表
   - 设置 Firebase 项目
     - 创建 Firebase 项目：
       访问 [Firebase 控制台](https://console.firebase.google.com/u/0/)，并创建一个新的项目。
     - 启用 Firestore：
       在项目中，导航到"Firestore Database"部分，选择创建数据库，然后选择开始使用。
       在规则页设置规则
       ```terminal
       rules_version = '2';

       service cloud.firestore {
           match /databases/{database}/documents {
               match /{document=**} {
               allow read, write: if true;
               }
           }
       }
       ```
   - 下载你自己的google services文件，然后分别替换./android/app/google-services.json和./ios/Runner/GoogleService-Info.plist
   - 按照[将Firebase添加到您的Flutter应用上](https://firebase.google.com/docs/flutter/setup?platform=ios)的说明进行操作。
2. AppID/AppSign of Zego
   Go to [ZEGOCLOUD Admin Console](https://console.zegocloud.com/) , get the appID and appSign of your project.
   然后在demo的系统设置界面中设置
3. 配置离线呼叫（可选）
   请跟着[Configure your project](https://www.zegocloud.com/docs/uikit/callkit-flutter/quick-start-(with-call-invitation)#configure-your-project)中的**1. Firebase Console and ZEGO Console Configuration**小节中的步骤进行配置

# 功能介绍

## splash
  简单介绍5个kit的基本功能
  <div style="overflow-x: auto; white-space: nowrap;">
        <img src="images/splash_1.png" alt="Splash 1" style="width: 200px; display: inline-block; margin-right: 10px;">
        <img src="images/splash_2.png" alt="Splash 2" style="width: 200px; display: inline-block; margin-right: 10px;">
        <img src="images/splash_3.png" alt="Splash 3" style="width: 200px; display: inline-block; margin-right: 10px;">
        <img src="images/splash_4.png" alt="Splash 4" style="width: 200px; display: inline-block; margin-right: 10px;">
        <img src="images/splash_5.png" alt="Splash 5" style="width: 200px; display: inline-block; margin-right: 10px;">
        <img src="images/splash_6.png" alt="Splash 6" style="width: 200px; display: inline-block; margin-right: 10px;">
    </div>

## global settings
  你需要在这里设置**ZEGO AppID/AppSign**, 也可以在这里**切换语言**
  <div style="overflow-x: auto; white-space: nowrap;">
        <img src="images/system_settings_1.png" alt="system settings" style="width: 200px; display: inline-block; margin-right: 10px;">
        <img src="images/system_settings_2.png" alt="system settings" style="width: 200px; display: inline-block; margin-right: 10px;">
    </div>

## call
  
- 设置
    <div style="overflow-x: auto; white-space: nowrap;">
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/call_7.png" alt="Call" style="width: 150px;">
            <div>点击右上角的设置按钮，进入设置界面，可以进行一些动态化配置</div>
        </div>
    </div>

- 呼叫邀请

  - 拨号呼叫
    <div style="overflow-x: auto; white-space: nowrap;">
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/call_1.png" alt="Call" style="width: 150px;">
            <div>通过直接拨号，呼叫对方</div>
        </div>
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/call_8.png" alt="Call" style="width: 150px;">
            <div>呼叫界面（呼叫方）</div>
        </div>
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/call_10.png" alt="Call" style="width: 150px;">
            <div>呼叫界面（被呼叫方）</div>
        </div>
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/call_11.png" alt="Call" style="width: 150px;">
            <div>呼叫界面（被呼叫方）</div>
        </div>
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/call_2.png" alt="Call 2" style="width: 150px;">
            <div>按"#"键，可以增加呼叫人数，进行多人呼叫</div>
        </div>
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/call_3.png" alt="Call" style="width: 150px;">
            <div>多人呼叫界面（呼叫方）</div>
        </div>
    </div>

  - 历史记录
  - 通讯录
    <div style="overflow-x: auto; white-space: nowrap;">
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/call_6.png" alt="Call" style="width: 150px;">
            <div>在通话记录中直接回拨对方</div>
        </div>
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/call_9.png" alt="Call" style="width: 150px;">
            <div>在顶部工具栏的通讯录中直接呼叫对方</div>
        </div>
    </div>

- 1v1/group
  - 预设通话房间列表
    在call设置页可以配置通话房间列表，进入相同通话的人，可以相互通话
    <div style="overflow-x: auto; white-space: nowrap;">
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/call_4.png" alt="Call" style="width: 150px;">
            <div>直接在预设通话列表进入预设通话（1v1）</div>
        </div>
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/call_5.png" alt="Call" style="width: 150px;">
            <div>直接在预设通话列表进入预设通话（多人）</div>
        </div>
    </div>


- live
  - 直播
    <div style="overflow-x: auto; white-space: nowrap;">
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/live_0.png" alt="live" style="width: 150px;">
            <div>预设直播列表</div>
        </div>
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/live_1.png" alt="live" style="width: 150px;">
            <div>主播预览页</div>
        </div>
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/live_2.png" alt="live" style="width: 150px;">
            <div>美颜</div>
        </div>
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/live_3.png" alt="live" style="width: 150px;">
            <div>co-host</div>
        </div>
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/live_3_2.png" alt="live" style="width: 150px;">
            <div>成员列表</div>
        </div>
    </div>
  - PK
    <div style="overflow-x: auto; white-space: nowrap;">
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/live_4.png" alt="live" style="width: 150px;">
            <div>在线空闲主播列表</div>
        </div>
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/live_5.png" alt="live" style="width: 150px;">
            <div>主播被邀请PK</div>
        </div>
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/live_6.png" alt="live" style="width: 150px;">
            <div>某主播状态显示PK被邀请中</div>
        </div>
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/live_7.png" alt="live" style="width: 150px;">
            <div>某主播状态显示PK中</div>
        </div>
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/live_8.png" alt="live" style="width: 150px;">
            <div>PK默认界面</div>
        </div> 
    </div>
  - 直播列表
    <div style="overflow-x: auto; white-space: nowrap;">
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/live_9.png" alt="live" style="width: 150px;">
        </div>
    </div>
  - 滑动切换
  - 多媒体分享
    <div style="overflow-x: auto; white-space: nowrap;">
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/live_10.png" alt="live" style="width: 150px;">
            <div>主播分享电影中</div>
        </div>
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/live_11.png" alt="live" style="width: 150px;">
            <div>观众观看主播讲解电影</div>
        </div>
    </div>


- audio room
  - 预设房间列表
    <div style="overflow-x: auto; white-space: nowrap;">
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/audio_room_1.png" alt="audio room" style="width: 150px;">
        </div>
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/audio_room_2.png" alt="audio room" style="width: 150px;">
        </div>
    </div>
  - 多媒体分享
    <div style="overflow-x: auto; white-space: nowrap;">
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/audio_room_5.png" alt="audio room" style="width: 150px;">
        </div>
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/audio_room_3.png" alt="audio room" style="width: 150px;">
            <div>host播放电影</div>
        </div>
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/audio_room_4.png" alt="audio room" style="width: 150px;">
            <div>其它用户</div>
        </div>
    </div>


- conference
  - 预设房间列表
    <div style="overflow-x: auto; white-space: nowrap;">
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/conference_0.png" alt="conference" style="width: 150px;">
        </div>
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/conference_1.png" alt="conference" style="width: 150px;">
        </div>
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/conference_2.png" alt="conference" style="width: 150px;">
            <div>聊天界面</div>
        </div>
    </div>
  - 屏幕分享
    <div style="overflow-x: auto; white-space: nowrap;">
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/conference_3.png" alt="conference" style="width: 150px;">
            <div>观看别人的屏幕分享</div>
        </div>
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/conference_4.png" alt="conference" style="width: 150px;">
            <div>正在共享屏幕</div>
        </div>
    </div>


- chat
    <div style="overflow-x: auto; white-space: nowrap;">
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/chat_1.png" alt="chat" style="width: 150px;">
            <div>从通讯录中选择联系人</div>
        </div>
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/chat_2.png" alt="chat" style="width: 150px;">
            <div>收到其它用户发来的消息</div>
        </div>
        <div style="display: inline-block; text-align: center; margin-right: 20px;">
            <img src="images/chat_3.png" alt="chat" style="width: 150px;">
            <div>消息列表</div>
        </div>
    </div>
