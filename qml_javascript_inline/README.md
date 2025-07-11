# Qt6 QML 模組開發演化記錄

## 📋 專案資訊
- **專案名稱**: QML JavaScript Inline 學習專案
- **開發者**: wishxavier
- **開始時間**: 2025-07-11
- **Qt 版本**: Qt 6.8
- **專案類型**: 學習型專案 - QML JavaScript 功能探索

## 🎯 專案目標
學習和探索 Qt6 QML 中 JavaScript 的使用方式，從最基礎的 inline 函數開始，逐步演化到更複雜的模組化架構。

## 🔄 版本演化記錄

### v1.0.0 - JavaScript Inline 學習版 (2025-07-11)

#### 📝 版本描述
這是學習 QML JavaScript 的第一版，採用最直觀、暴力的 hardcode 方式，所有邏輯都以 inline（內嵌函數）的形式直接寫在 QML 檔案中。

#### 🎨 功能特性
- **顏色計算功能**: 實作 RGB 亮度計算
- **自適應文字顏色**: 根據背景亮度自動選擇黑色或白色文字
- **隨機顏色生成**: 點擊時隨機變更背景顏色
- **響應式 UI**: 文字容器會根據內容自動調整大小

#### 💻 技術實作細節

**Main.qml 核心程式碼:**
```qml
// inline 亮度計算函數 - 使用 WCAG 標準
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

// inline 文字顏色選擇函數
function getTextColorByLuminance(rgba) {
    const luminance = getLuminance(rgba)
    return luminance > 0.5 ? "black" : "white"
}

// inline 隨機顏色生成函數
function randomColor() {
    return Qt.rgba(Math.random(), Math.random(), Math.random(), 1.0)
}
```

#### 🎓 學習重點
1. **QML 中的 inline JavaScript 函數定義**
   - 直接在 Window 中定義函數
   - 函數可以被同一檔案中的其他元件調用

2. **Qt.rgba() 的使用**
   - 理解 Qt 的顏色系統
   - Math.random() 在 QML 中的應用

3. **WCAG 亮度計算標準**
   - 學習無障礙設計的顏色對比計算
   - Gamma 校正的實作

4. **inline 函數的作用域**
   - 理解 QML 中函數的可見性範圍
   - 父子元件間的函數調用方式

#### ✅ 優點
- **學習友善**: 所有邏輯都在一個檔案中，容易理解
- **即時反饋**: 不需要編譯 C++ 程式碼，修改後立即看到效果
- **功能完整**: 雖然簡單但實作了完整的功能流程
- **標準遵循**: 使用了 WCAG 無障礙標準的亮度計算
- **開發快速**: inline 方式讓原型開發非常迅速

#### ⚠️ 待改進點
- **程式碼組織**: 所有邏輯都在 Main.qml 中，缺乏模組化
- **可重用性**: inline 函數無法被其他 QML 檔案使用
- **測試困難**: 難以為 inline 函數編寫單元測試
- **效能考量**: 每次點擊都重新計算，可能有最佳化空間
- **維護性**: 隨著功能增加，單一檔案會變得複雜

#### 🚀 下一版本計畫
1. **模組化重構**: 將 JavaScript 邏輯提取到獨立的 .js 檔案
2. **元件化**: 創建可重用的顏色選擇元件
3. **加入動畫**: 顏色變化時加入過渡效果
4. **擴展功能**: 加入更多顏色操作功能

#### 📸 執行畫面
```
┌─────────────────────────────────────┐
│  QML Javascript inline             │
├─────────────────────────────────────┤
│                                     │
│          ┌──────────────┐           │
│          │ 點擊變顏色    │ ← 金色邊框  │
│          │              │           │
│          └──────────────┘           │
│                                     │
│     (背景色隨機，文字色自適應)         │
└─────────────────────────────────────┘
```

#### 🔍 程式碼分析
- **檔案結構**: 單一 QML 檔案包含所有邏輯
- **函數位置**: inline 方式直接定義在 Window 元件中
- **作用域**: 函數可被同檔案中所有子元件存取
- **呼叫方式**: `mainWindow.functionName()` 格式

#### 💡 Inline 函數的優缺點總結

**優點:**
- 開發速度快，適合原型設計
- 邏輯集中，易於理解和除錯
- 不需要額外的檔案管理
- 適合簡單的、單次使用的功能

**缺點:**
- 程式碼重用性差
- 檔案容易變得龐大
- 測試困難
- 不利於團隊協作

---

**記錄時間**: 2025-07-11 16:49:52  
**下次更新**: 準備模組化重構，將 inline 函數分離成獨立模組