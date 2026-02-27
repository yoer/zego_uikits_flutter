# Zego UIKit Monorepo

本文件为整个 zego_uikits monorepo 提供全局指导，涵盖所有库之间的依赖关系和架构决策。

## 整体架构

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                              zego_uikits (根目录)                            │
│                         低代码 Flutter 解决方案仓库                            │
└─────────────────────────────────────────────────────────────────────────────┘
                                      │
          ┌───────────────────────────┼───────────────────────────┐
          │                           │                           │
          ▼                           ▼                           ▼
┌─────────────────────┐   ┌─────────────────────┐   ┌─────────────────────┐
│   Core Layer        │   │   Plugin Layer     │   │   Prebuilt Layer   │
│   (基础层)           │   │   (插件层)           │   │   (业务组件层)       │
├─────────────────────┤   ├─────────────────────┤   ├─────────────────────┤
│ zego_uikit          │   │ signaling_plugin   │   │ prebuilt_call       │
│ zego_plugin_adapter │   │ beauty_plugin       │   │ prebuilt_live_*    │
│                     │   │                     │   │ prebuilt_video_*    │
│                     │   │                     │   │ zimkit              │
└─────────────────────┘   └─────────────────────┘   └─────────────────────┘
```

## 库依赖关系

### 依赖链（被依赖 → 依赖）

```
zego_uikit
    ├── zego_plugin_adapter
    │
    ├── zego_uikit_signaling_plugin
    │       ├── zego_plugin_adapter
    │       ├── zego_zim
    │       ├── zego_zpns
    │       └── zego_callkit
    │
    ├── zego_uikit_beauty_plugin
    │       ├── zego_plugin_adapter
    │       └── zego_effects_plugin
    │
    ├── zego_uikit_prebuilt_call ────────────► zego_uikit + signaling_plugin
    ├── zego_uikit_prebuilt_live_streaming ──► zego_uikit (+ signaling_plugin 可选)
    ├── zego_uikit_prebuilt_live_audio_room ─► zego_uikit + signaling_plugin
    ├── zego_uikit_prebuilt_video_conference ► zego_uikit
    └── zego_zimkit ─────────────────────────► signaling_plugin + zego_uikit
```

### 修改原则

1. **修改 Core 层 (zego_uikit) 影响最大**
   - 所有 Prebuilt 库都依赖它
   - 修改公共 API 需要考虑向后兼容性
   - Service mixin 的改动会影响所有使用者

2. **修改 Plugin 层需要谨慎**
   - signaling_plugin 被多个库共用
   - 改动会级联到 prebuilt_call, prebuilt_live_audio_room, zimkit

3. **修改单个 Prebuilt 库影响较小**
   - 各 Prebuilt 库相互独立
   - 但要注意不要意外依赖其他 Prebuilt 库的实现细节

## 各库职责边界

### Core 层

| 库 | 职责 | 入口文件 |
|---|------|---------|
| `zego_uikit` | 底层音视频 UI 组件、服务 mixins | `lib/zego_uikit.dart` |
| `zego_plugin_adapter` | 插件统一接口适配 | SDK 内部使用 |

### Plugin 层

| 库 | 职责 | 入口文件 |
|---|------|---------|
| `zego_uikit_signaling_plugin` | 信令、呼叫邀请、IM 消息 | `lib/zego_uikit_signaling_plugin.dart` |
| `zego_uikit_beauty_plugin` | 美颜特效 | `lib/zego_uikit_beauty_plugin.dart` |

### Prebuilt 层

| 库 | 场景 | 入口文件 |
|---|------|---------|
| `zego_uikit_prebuilt_call` | 1v1/群组通话 | `lib/zego_uikit_prebuilt_call.dart` |
| `zego_uikit_prebuilt_live_streaming` | 直播 | `lib/zego_uikit_prebuilt_live_streaming.dart` |
| `zego_uikit_prebuilt_live_audio_room` | 语聊房 | `lib/zego_uikit_prebuilt_live_audio_room.dart` |
| `zego_uikit_prebuilt_video_conference` | 视频会议 | `lib/zego_uikit_prebuilt_video_conference.dart` |
| `zego_zimkit` | 即时通讯 | `lib/zego_zimkit.dart` |

## 通用设计模式

所有库遵循统一的设计模式：

### 1. Singleton + Mixin 模式

```dart
// 核心单例 (所有库通用)
class ZegoUIKit with ZegoAudioVideoService, ZegoRoomService, ... {
  factory ZegoUIKit() => instance;
}

// Prebuilt 库使用 Controller 单例
class ZegoUIKitPrebuiltCallController
    with ZegoCallControllerAudioVideo,
         ZegoCallControllerMinimizing,
         ...
```

### 2. Config Builder 模式

```dart
// 预置配置
var config = ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall();

// 自定义配置
var config = ZegoUIKitPrebuiltCallConfig.groupVideoCall()
  ..turnOnCameraWhenJoining = true
  ..topMenuBar.showMicrophoneStateButton = false;
```

### 3. Event Callback 模式

```dart
var events = ZegoUIKitPrebuiltCallEvents(
  onCallEnd: (context) { ... },
  user: ZegoCallUserEvents(
    onJoined: (user) { ... },
    onLeft: (user) { ... },
  ),
);
```

### 4. Builder 回调模式

```dart
var config = ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
  ..avatarBuilder = (context, size, user, extraInfo) {
    return CircleAvatar(backgroundImage: NetworkImage(user.avatarURL));
  }
  ..foregroundBuilder = (context, size, user, extraInfo) {
    return Badge(text: user.name);
  };
```

## 常见任务指南

### 添加新功能到某个 Prebuilt 库

1. **UI 组件** → `lib/src/components/`
2. **业务逻辑** → `lib/src/core/` 或 `lib/src/controller/`
3. **配置项** → `lib/src/config.dart` 添加配置类
4. **事件回调** → `lib/src/events.dart` 添加事件类
5. **导出 API** → `lib/zego_uikit_prebuilt_xxx.dart`

### 修复 bug

1. **UI 显示问题** → 检查 `components/` 目录
2. **状态管理问题** → 检查 `controller/` 目录
3. **事件传递问题** → 检查 `events.dart` 或 `internal/`
4. **平台通道问题** → 检查 `channel/` 目录

### 修改 Core 库 (zego_uikit)

1. **Service mixin** → `lib/src/services/`
2. **UI 组件** → `lib/src/components/`
3. **插件接口** → `lib/src/plugins/`
4. **数据类型** → `lib/src/services/defines/`

## 代码规范

所有库统一使用以下规范：

- **`public_member_api_docs: true`** - 所有公共 API 必须有文档注释
- **import_sorter** - 使用 `flutter pub run import_sorter:main` 排序导入
- **@category 注解** - API 按功能分组（见各库的 `dartdoc_options.yaml`）
- **ValueNotifier** - 使用 ValueNotifier 进行响应式状态更新
- **Stream** - 使用 Stream 进行事件通知

## 常用命令

```bash
# 在根目录查看所有库
ls -la

# 进入某个库
cd zego_uikit_prebuilt_call

# 安装依赖
flutter pub get

# 代码分析
flutter analyze

# 排序导入
flutter pub run import_sorter:main

# 运行示例
cd example && flutter run
```

## 相关文档

- [PROJECT_STRUCTURE.md](./PROJECT_STRUCTURE.md) - 详细的项目结构说明
- 各库内的 `CLAUDE.md` - 库-specific 的开发指南
- 各库内的 `doc/` 目录 - API 文档
