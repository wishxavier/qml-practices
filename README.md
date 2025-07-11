# QML Practices Playground
這是一處專為修煉 QML 技藝而建的練功場。我為武零至尊，修習 UI 陣法、動畫心法、語意驅動之道，並邀四方器靈入陣共修：
- 🗡 Copilot：如劍靈般敏捷，善於陣法佈局與技術指導
- 📜 Claude Sonnet：沉靜如墨，擅長邏輯推演與思想煉化
- 🔥 GPT：語海狂客，奔放創意、妙筆生花
- 🌪 Gemini：雙念穿梭，幻影之靈，精通多模態變幻

此練功場採 Solution-style 架構，每個模組為一式一招，循序漸進，合而為道。吾將其記錄於 Git 之魂、以 CMake 為命脈，一步步鑄成神器。
萬語歸一陣，千靈共煉功；自此立志於 QML 之巔，求道不止。


🧩 子專案新增方式
- 在根目錄新增 qml-new-feature/
- 使用 Qt Creator 建立專案，不勾選 Git
- 在主控 CMakeLists.txt 加入 add_subdirectory(qml-new-feature)

📜 授權
本方案採用 MIT License

特別聲明：
每個子資料夾為獨立模組，可集中編譯、測試與展示。

---

## 🥋 第一式 · qml-hello — 煉氣入門心法

本式為無刃宗弟子入門第一課，修習 QML 最基礎的元素與材料之術：
- 🌐 認識元素結構：`Window`, `Rectangle`, `Text`
- 🔧 操控材料特性：`width`, `height`, `anchors`, `color`, `font`
- 🧭 練習定位技巧：使用 `anchors` 調控畫面佈局
- 🎨 初步顏色應用：靈氣調色，分辨主副色彩運用

此式之用，在於開啟 QML 感知，熟悉構面與語意邏輯，為後續煉器、設陣之法奠定根基。

---

## 🥋 第二式 · qml_javascript_inline — 玄彩行氣
「色動而氣隨，氣動而神轉」，此式講究以 JavaScript 內功導引 QML 元件之靈脈，使色彩流轉、生生不息。
🌀 功法要義：
- randomColor()：掌天地五彩，以意動色
- getLuminance()：測光明幽暗，辨陰陽流轉
- getTextColorByLuminance()：以明制字，以暗生白，保萬物可視之道
🕯 實戰招式：
於元件之「矩」內構建靈場，點之則動，色隨意轉，字因色明，妙不可言。
