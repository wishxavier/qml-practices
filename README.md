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

---

## 🥋 第三式 · qml_javascript_import — 模組聚氣
「散功不及密法，心法不若門派。」此式講究邏輯封裝與模組導入，將散落於元件的意識引導，聚合為一脈內功之源。

📖 修煉緣起
由第二式 inline JS 演化而來，為追求模組解耦與邏輯再利用之道，本式將 JavaScript 心法獨立成工具模組，使元件只專注於靈氣運作，不涉運算之術。

📦 模組引用正確法門
qt_add_qml_module 運用 RESOURCES resources/javascripts/color_utils.js 管理資源，確保模組隨應用打包
import "qrc:/qt/qml/qml_javascript_import/resources/javascripts/color_utils.js" as ColorUtils
- 🧭 路徑心法 qrc:/qt/qml/<Module>/<ResourcePath>
- 🐚 命名心法 as ColorUtils 清楚命名，引導調用心法，不雜不亂
- 💡 修煉秘訣：資源置於 resources/javascripts/ 乃結構分明之道，有助於日後 Singleton 模組、C++ 封裝等進階功法的融合與拓展。

🎯 功法演練 · 實戰招式
於元件呼吸之時，引導色彩靈氣交融：
textContainer.color = ColorUtils.randomColor()
textChangeColor.color = ColorUtils.getTextColorByLuminance(textContainer.color)
此二式互為陰陽，合為「色·氣·明」三元運轉，形成 UI 的流動之道。

🧠 命名心法 · ColorUtils 之道
命名如功法，需：
- 📣 意圖明確：見名知義，不藏技術於字
- 🔧 功能可擴：未來可加入 hexToRgb(), blendColor() 等心法
- ✨ 模組定位清晰：ColorUtils 為「色之器靈」，與主體分工明確

---

## 🥋 第四式 · qml_javascript_singleton — 封靈注型心法

此式為第三式模組封裝進階延伸，將 JavaScript 工具封裝為 QML Singleton 容器，以達元件不重複、調用統一之效。

📖 修煉概念  
- 單例封裝：透過 QML Module 註冊 Singleton 型別
- JS 導氣：使用 `color_utils.js` 作為邏輯支撐
- UI 調用：在 QML 中呼叫 `ColorUtils` 如同本地函式，乾淨易用

🌀 精妙設計  
- `color_utils.qml` 為唯一顯化之器靈，內部 `import js` 暗合陰陽  
- `Main.qml` 與 Singleton 無需 contextProperty，直接取用，減少耦合

🔧 建議檢視方向  
- 未來可擴充 `ColorUtils` 為 MVVM 中共享工具  
- 亦可轉為 Singleton C++ 型別，達成更強效封裝

✨ 本式雖精簡，氣脈已通，為無刃宗邁向邏輯抽象與資料同步之關鍵轉捩。

---

## 🥋 第五式 · qml_singleton_element — 器靈顯化心法

C++ 為骨，QML 為靈；封入元界，一氣通真。

🧭 式緣溯源 · 封靈轉骨
此式承接第四式的 JavaScript 封靈之道，將原本的色彩腕法煉入 C++ 靈骨──以 QML_ELEMENT 明其顯化，以 QML_SINGLETON 定其唯一，合為元界常駐色靈器具。
JS 腕法猶如氣勁揮動，而 C++ 顯化則是靈骨鑄型──此式正式步入兵器堂之道。

⚙ 鍛器之法 · 色靈封裝
🔹 類別：ColorUtils，位於 shared_utils/color_utils/color_utils.hpp
🔮 標記：
Q_OBJECT 為 Qt 元靈啟動之符
QML_ELEMENT 為 QML 元界登錄之證
QML_SINGLETON 為唯一器靈之封印
🔮 方法：
randomColor()：調五彩之靈氣
getTextColorByLuminance()：定字色明暗，保視覺通天

🧙‍ 式義總結 · 鍛器堂序
本式不僅技術上轉為 C++ 顯化，更結構上正式納入 shared_utils 分堂，為 Solution-style 模組化修煉奠定兵器堂基石。
若未來需擴展色彩配置、動態主題、明暗模式調節，皆可在此骨架之上加掛器件──色靈之堂，由此鑄成。
