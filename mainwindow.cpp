#include "mainwindow.h"
#include "ui_mainwindow.h"
#include "parser.h"
#include "scanner.h"
#include <QMessageBox>
extern int yyparse();
extern QString resultado;


MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::on_pushButton_clicked()
{
    QString str = ui->lineEdit->text();
    if(str.length()==0){
        QMessageBox::critical(this,"Error en la entrada",
              "No se permite analizar una cadena vacia.");
        return;
    }

    YY_BUFFER_STATE bufferState = yy_scan_string(str.toUtf8().constData());

    if(yyparse()==0){
        ui->label_2->setText("Analisis realizado con exito.");
        ui->label->setText(resultado);
    }else{
        ui->label_2->setText("Errores sintacticos en la entrada.");
        ui->label->setText("");
    }

    yy_delete_buffer(bufferState);
}




















