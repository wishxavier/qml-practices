#ifndef COLOR_UTILS_HPP
#define COLOR_UTILS_HPP

#include <QObject>
#include <QQmlEngine>
#include <QColor>
#include <QString>
#include <QtMath>
#include <QRandomGenerator>

class ColorUtils : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON

public:
    explicit ColorUtils(QObject *parent = nullptr) : QObject(parent) {}

    // Qt 6.8 Singleton creation method
    static ColorUtils *create(QQmlEngine *qmlEngine, QJSEngine *jsEngine) {
        Q_UNUSED(qmlEngine)
        Q_UNUSED(jsEngine)
        return new ColorUtils();
    }

    Q_INVOKABLE static inline QColor randomColor() {
        auto* generator = QRandomGenerator::global();
        return QColor::fromRgbF(
            generator->generateDouble(),
            generator->generateDouble(),
            generator->generateDouble(),
            1.0
        );
    }

    Q_INVOKABLE static inline QString getTextColorByLuminance(const QColor& rgba) {
        return isLight(rgba) ? "black" : "white";
    }

private:
    Q_INVOKABLE static inline bool isLight(const QColor& color) {
        return getLuminance(color) > 0.5;
    }

    Q_INVOKABLE static inline double getLuminance(const QColor& rgba) {
        auto channelLum = [](double c) -> double {
            return c <= 0.03928 ? c / 12.92 : qPow((c + 0.055) / 1.055, 2.4);
        };

        const double R = channelLum(rgba.redF());
        const double G = channelLum(rgba.greenF());
        const double B = channelLum(rgba.blueF());

        return 0.2126 * R + 0.7152 * G + 0.0722 * B;
    }
};

#endif // COLOR_UTILS_HPP