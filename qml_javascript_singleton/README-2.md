# v3.0.0 - QML Singleton 統一介面版（故事四到九：過程重點紀錄）

## 🐛 故事四～九：每個故事的過程重點

---

### 故事四：看起來都對，但 ColorUtils is not defined 的神秘案例

- **行動**：在 color_utils.qml 中加上 `pragma Singleton`，並於 Main.qml 嘗試 `ColorUtils.randomColor()`。
- **問題**：執行時 QML 報錯 `ColorUtils is not defined`。
- **原因發現**：檢查 CMakeLists.txt，發現沒有為 color_utils.qml 設定 `QT_QML_SINGLETON_TYPE` 屬性。
- **修正方案**：加入 `set_source_files_properties(resources/qml_utils/color_utils.qml PROPERTIES QT_QML_SINGLETON_TYPE TRUE)`。
- **結果**：Singleton 可被 QML 系統辨識，但仍無法正常呼叫方法，出現 undefined 錯誤。

---

### 故事五：AI 建議的惡夢

- **行動**：依據 AI 建議更改 import 名稱（如 `import qml_interaction 1.0 as Utils`），並嘗試多種命名方式。
- **問題**：QML 報錯 `Type color_utils not declared as singleton in qmldir but using pragma Singleton [import]`。
- **原因發現**：AI 建議的模組名稱與 CMake 註冊不符，Singleton 型別未正確宣告於 qmldir。
- **修正方案**：瞭解自動 qmldir 生成機制，意識到必須讓 CMake 設定與型別命名一致。
- **結果**：問題未解決，AI 進一步建議手動建立 qmldir，導致流程變得混亂。

---

### 故事六：手動接管 qmldir 控制權

- **行動**：在 CMakeLists.txt 加上 `NO_GENERATE_QMLDIR`，手動撰寫 qmldir 檔案，明確指定 singleton 型別。
- **問題**：手動管理雖可行，但增加維護成本且易出錯；驗證過程中可正確載入 Singleton，但每次改動都需手動同步 qmldir。
- **原因發現**：Qt6 原本設計自動化管理，手動模式雖可解，但非長遠之計。
- **修正方案**：決定回歸自動模式，尋找正確自動化註冊方式。
- **結果**：瞭解 QML 模組註冊底層邏輯，建立正確知識基礎。

---

### 故事七：回歸自動模式的新崩潰

- **行動**：移除手動 qmldir，恢復自動生成，保持 CMakeLists.txt 的標準設定，使用社群建議的命名方式。
- **問題**：執行時 QML 報錯 `TypeError: Cannot call method 'randomColor' of undefined`，Singleton 型別仍未被正確註冊。
- **原因發現**：發現 CMake 設定中型別名稱 (`QT_QML_SOURCE_TYPENAME`) 與 QML 使用名稱不一致，導致 QML 找不到 Singleton。
- **修正方案**：統一命名規則，確保 CMake 註冊型別名稱與 QML 使用名稱一致。
- **結果**：Singleton 型別開始可被 QML 辨識，但仍有細節需調整。

---

### 故事八：AI 投降但工程師不放棄

- **行動**：AI 建議再次手動 qmldir，開發者拒絕並堅持自動化解法，持續檢查 CMake 與 QML 註冊細節。
- **問題**：qmldir 仍未自動出現 singleton 宣告，Singleton 型別偶爾未正確被 QML 辨識。
- **原因發現**：深入研究 CMake 屬性設定，發現需同時設置 `QT_QML_SINGLETON_TYPE` 與 `QT_QML_SOURCE_TYPENAME`。
- **修正方案**：在 CMakeLists.txt 中補上兩個屬性，並統一命名為 ColorUtils。
- **結果**：Singleton 型別自動註冊成功，QML 可正確呼叫所有方法。

---

### 故事九：救世主降臨，最終勝利

- **行動**：將 CMake 屬性設置完善、命名全部遵循社群標準，測試多種 QML import 寫法。
- **問題**：最後驗證所有呼叫方式皆可運作，Singleton 自動註冊無誤。
- **原因發現**：正確的 CMake 設定為 Singleton 型別自動註冊關鍵，命名一致性是成功要素。
- **修正方案**：最終 CMake 設定如下：
  ```cmake
  set_source_files_properties(resources/qml_utils/color_utils.qml
      PROPERTIES
          QT_QML_SINGLETON_TYPE TRUE
          QT_QML_SOURCE_TYPENAME "ColorUtils"
  )
  ```
- **結果**：QML 可直接用 `ColorUtils.randomColor()`，系統穩定、可維護、符合最佳實務，終於大功告成！

---

## 🎯 工程師思考脈絡總結

- 行動 → 問題 → 原因分析 → 修正 → 結果
- 每次修正都建立在上一次失敗的深度理解之上
- 最終獲得完整 Singleton 技術與自動化工具鏈的信心！

---

> 這份紀錄不只是技術文件，更是工程師精神的見證！  
> —— wishxavier, 2025-07-18
