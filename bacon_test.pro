# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
include(./Bacon2D/src/Bacon2D-static.pri)

TARGET = bacon_test

CONFIG += sailfishapp

SOURCES += src/bacon_test.cpp

OTHER_FILES += qml/bacon_test.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    qml/pages/SecondPage.qml \
    rpm/bacon_test.changes.in \
    rpm/bacon_test.spec \
    rpm/bacon_test.yaml \
    translations/*.ts \
    bacon_test.desktop \
    qml/pages/components/*.qml

SAILFISHAPP_ICONS = 86x86 108x108 128x128 256x256

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
TRANSLATIONS += translations/bacon_test-de.ts

DISTFILES += \
    qml/pages/components/Ball.qml \
    qml/pages/components/PBody_test.qml \
    qml/pages/components/Bowl.qml \
    ../../Desktop/wp120dbcda_06.png \
    qml/pages/wp120dbcda_06.png \
    qml/pages/clouds-png-5.png \
    qml/pages/right.png
