# Qt6 QML 模組開發演化記錄 - v2.0.0 完整版

## 📋 專案資訊
- **專案名稱**: QML JavaScript 模組化學習專案
- **開發者**: wishxavier
- **版本**: v2.0.0 - JavaScript 模組化重構版
- **開發日期**: 2025-07-12
- **Qt 版本**: Qt 6.8
- **專案類型**: JavaScript 模組化探索與踩坑之旅

## 🎯 v2.0.0 版本目標
將 v1.0.0 的 inline JavaScript 重構為獨立的模組檔案，學習 QML 中 JavaScript 模組的 import 機制和最佳實務。

## 💻 v2.0.0 技術架構

### 檔案結構
```
qml_javascript_import_module/
├── CMakeLists.txt
├── main.cpp
├── Main.qml
└── resources/
    └── javascripts/
        └── color_utils.js
```

### 最終正確實作

**CMakeLists.txt:**
```cmake
cmake_minimum_required(VERSION 3.16)

project(qml_javascript_import_module VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.8)

qt_add_executable(appqml_javascript_import_module
    main.cpp
)

qt_add_qml_module(appqml_javascript_import_module
    URI qml_javascript_import_module
    VERSION 1.0
    QML_FILES Main.qml
    RESOURCES resources/javascripts/color_utils.js
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appqml_javascript_import_module PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appqml_javascript_import_module
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appqml_javascript_import_module
    PRIVATE Qt6::Quick
)
```

**color_utils.js (JavaScript 模組):**
```javascript
.pragma library

function getLuminance(rgba) {
    const RsRGB = rgba.r
    const GsRGB = rgba.g
    const BsRGB = rgba.b

    function channelLum(c) {
        return c <= 0.03928
            ? c / 12.92
            : Math.pow((c + 0.055) / 1.055, 2.4)
    }

    const R = channelLum(RsRGB)
    const G = channelLum(GsRGB)
    const B = channelLum(BsRGB)
    return 0.2126 * R + 0.7152 * G + 0.0722 * B
}

function getTextColorByLuminance(rgba) {
    const luminance = getLuminance(rgba)
    return luminance > 0.5 ? "black" : "white"
}

function randomColor() {
    return Qt.rgba(Math.random(), Math.random(), Math.random(), 1.0)
}
```

**Main.qml (使用模組):**
```qml
import QtQuick
import qml_javascript_import_module
import "../resources/javascripts/color_utils.js" as ColorUtils

ApplicationWindow {
    id: window

    width: 640
    height: 480
    visible: true
    title: qsTr("QML JavaScript Import Module")

    Rectangle {
        id: textContainer
        anchors.centerIn: parent
        width: 200
        height: 100
        color: "lightblue"
        border.color: "black"
        border.width: 2

        Text {
            id: textChangeColor
            anchors.centerIn: parent
            text: "Click to change color"
            color: ColorUtils.getTextColorByLuminance(parent.color)
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                textContainer.color = ColorUtils.randomColor()
                textChangeColor.color = ColorUtils.getTextColorByLuminance(textContainer.color)
            }
        }
    }
}
```

## 🐛 v2.0.0 開發歷程：三個踩坑故事

### 故事一：傳統 .qrc 的滑鐵盧 - 路徑不符的崩潰

**時間**: 2025-07-12 14:23:15 UTC  
**開發者**: wishxavier

#### 問題背景
開發者嘗試使用傳統的 .qrc 檔案來管理 JavaScript 資源，按照常見的教學方式進行設定。

#### 初始嘗試

**resources.qrc 檔案:**
```xml
<RCC>
    <qresource prefix="/js">
        <file>resources/javascripts/color_utils.js</file>
    </qresource>
</RCC>
```

**Main.qml 中的 import 嘗試:**
```qml
import "qrc:/js/resources/javascripts/color_utils.js" as ColorUtils
```

#### 💥 崩潰結果
```
qrc:/qt/qml/qml_javascript_import_module/Main.qml:3:1: 
module "qrc:/js/resources/javascripts/color_utils.js" is not installed
```

#### 🔍 問題分析
- .qrc 檔案的路徑結構與 import 語句不匹配
- Qt6 的資源系統與 QML 模組系統的整合複雜性
- 傳統 .qrc 方法在現代 Qt6 專案中的局限性

#### 📚 學習收穫
1. **Qt6 資源管理的變化**: 從 .qrc 向 qt_add_qml_module 的轉移
2. **路徑複雜性**: 資源路徑與 import 路徑的對應關係
3. **現代化趨勢**: Qt6 推薦的新式資源管理方式

---

### 故事二：相對路徑的意外成功 - 驚喜的「雖然可以但不推薦」

**時間**: 2025-07-12 14:45:32 UTC

#### 問題背景
在 .qrc 方法失敗後，開發者嘗試了相對路徑的 import 方式，意外地獲得了成功。

#### 意外的解決方案

**Main.qml 中的相對路徑 import:**
```qml
import "../resources/javascripts/color_utils.js" as ColorUtils
```

#### ✅ 意外成功
程式竟然可以正常運行！顏色變化功能完全正常，JavaScript 函數都能正確調用。

#### 🤔 困惑的成功
> "為什麼相對路徑可以工作？這符合最佳實務嗎？"

#### 📊 相對路徑的優缺點分析

**優點:**
- ✅ 簡單直接，容易理解
- ✅ 不需要複雜的資源配置
- ✅ 在開發階段快速可用

**缺點:**
- ❌ 不符合 Qt6 的現代化資源管理
- ❌ 在打包和部署時可能出現問題
- ❌ 路徑依賴於檔案結構，重構時脆弱

#### 🎓 學習收穫
1. **Qt6 的彈性**: 支援多種 import 方式
2. **最佳實務 vs 可行解**: 能工作不代表是最好的方法
3. **開發 vs 生產**: 開發階段的便利性 vs 生產環境的穩定性

---

### 故事三：AI 研究員的路徑大發現 - 標準化的勝利

**時間**: 2025-07-12 15:12:47 UTC

#### 問題背景
對於故事二中相對路徑的成功感到困惑，開發者決定深入研究 Qt6 的標準做法。

#### AI 的深度研究成果

**標準 qrc 路徑規則發現:**
> AI 發現了 Qt6 中標準的資源路徑規則：當使用 `qt_add_qml_module` 時，資源會被自動註冊到特定的 qrc 路徑下。

**路徑規則:**
```
qrc:/qt/qml/<模組URI>/<資源相對路徑>
```

**具體到本專案:**
```
qrc:/qt/qml/qml_javascript_import_module/resources/javascripts/color_utils.js
```

#### 🎯 標準化解決方案

**正確的 Main.qml import:**
```qml
import "qrc:/qt/qml/qml_javascript_import_module/resources/javascripts/color_utils.js" as ColorUtils
```

#### ✅ 完美運行
使用標準路徑後，程式不僅能正常運行，更重要的是符合了 Qt6 的最佳實務。

#### 📚 深度學習成果

**Qt6 資源系統的完整理解:**

1. **自動註冊機制**
   ```cmake
   qt_add_qml_module(appqml_javascript_import_module
       URI qml_javascript_import_module  # 這決定了 qrc 路徑
       RESOURCES resources/javascripts/color_utils.js  # 自動註冊
   )
   ```

2. **路徑映射規則**
   ```
   CMake: RESOURCES resources/javascripts/color_utils.js
   ↓
   QRC: qrc:/qt/qml/qml_javascript_import_module/resources/javascripts/color_utils.js
   ```

3. **最佳實務確立**
   - 使用 `qt_add_qml_module` 管理資源
   - 遵循標準 qrc 路徑規則
   - 避免相對路徑的脆弱性

#### 🎓 故事三的核心價值
1. **標準化的重要性**: 符合框架設計意圖的做法更穩定
2. **深入理解機制**: 知其然知其所以然的學習態度
3. **最佳實務的價值**: 長期維護和團隊協作的考量

## 📊 v2.0.0 完整學習總結

### 三種 Import 方法對比

| 方法 | 語法 | 可行性 | 推薦度 | 適用場景 |
|------|------|--------|--------|----------|
| .qrc 傳統 | `qrc:/js/...` | ❌ 失敗 | ❌ 不推薦 | 舊版 Qt |
| 相對路徑 | `../resources/...` | ✅ 可行 | ⚠️ 不推薦 | 快速原型 |
| 標準 qrc | `qrc:/qt/qml/URI/...` | ✅ 完美 | ✅ 強烈推薦 | 生產環境 |

### 技術演化軌跡

```
v1.0.0 (Inline JS) 
    ↓
嘗試 .qrc 傳統方法 (失敗)
    ↓  
發現相對路徑可行 (意外成功)
    ↓
研究標準做法 (完美解決)
    ↓
v2.0.0 (Modularized JS) 完成
```

### 核心學習價值

1. **Qt6 現代化資源管理**
   - `qt_add_qml_module` 是核心工具
   - 自動 qrc 註冊機制
   - URI 與路徑的對應關係

2. **問題解決方法論**
   - 從失敗中學習
   - 不滿足於「能用」的解決方案
   - 追求標準化和最佳實務

3. **技術債務意識**
   - 短期可行 vs 長期維護
   - 個人項目 vs 團隊協作
   - 開發便利 vs 生產穩定

## 🏆 v2.0.0 最終成就

**🎯 技術成就:**
- ✅ 掌握 Qt6 JavaScript 模組化機制
- ✅ 理解現代資源管理系統
- ✅ 建立標準化開發流程

**🎖️ 學習成就:**
- ✅ 從多次失敗中汲取經驗
- ✅ 不滿足於表面解決方案
- ✅ 建立深度學習的方法論

**📈 為 v3.0.0 奠定基礎:**
- JavaScript 模組化經驗
- Qt6 資源系統理解
- CMake 配置基礎知識

## 📝 v2.0.0 紀念碑文

> "從 .qrc 的滑鐵盧，到相對路徑的意外成功，再到標準路徑的完美解決，  
> v2.0.0 的學習之旅展現了真正的工程師精神：  
> 不僅要讓程式能跑，更要讓程式跑得正確、優雅、可維護。"  
> —— wishxavier, 2025-07-12 15:12:47 UTC

---

**🎊 v2.0.0 完成時間**: 2025-07-12 15:12:47 UTC  
**專案狀態**: 圓滿完成，為 v3.0.0 QML Singleton 之旅奠定堅實基礎  
**技術債務**: 無  
**學習價值**: 為後續版本的複雜挑戰做好準備

**下一章預告**: v3.0.0 將帶來更大的挑戰 - QML Singleton 的史詩級學習之旅即將開始...