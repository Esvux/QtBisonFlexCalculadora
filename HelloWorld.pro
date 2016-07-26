#-------------------------------------------------
#
# Project created by QtCreator 2016-07-24T17:00:01
#
#-------------------------------------------------

QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = HelloWorld
TEMPLATE = app


SOURCES += main.cpp\
        mainwindow.cpp \
    scanner.cpp \
    parser.cpp

HEADERS  += mainwindow.h \
    scanner.h \
    parser.h \
    scanner.l \
    parser.y

FORMS    += mainwindow.ui
