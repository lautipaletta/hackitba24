import PDFDocument from "pdfkit"
import fs from "fs"

generate_report("juan", "1234", "summary", "10/08", [{content:"wasup", date:"today"}]);

function generate_report(user_name, user_id, user_summary, report_period, sessions){
    const doc = new PDFDocument();

    doc.pipe(fs.createWriteStream(`reports/${user_id}.pdf`));
    
    doc.image('pngs/alicia_fab.png', 450, 50, {width:100});

    doc.font('fonts/Poppins-Bold.ttf')
        .fontSize(32)
        .fillColor("#2D1952")
        .text('Reporte para fines psicoanalíticos');
    
    doc.moveDown()
        .font('fonts/Poppins-Medium.ttf')
        .fontSize(16)
        .fillColor("black")
        .text('Nombre: ' + user_name)
        .moveDown()
        .fontSize(12)
        .text('Periodo de análisis: ' + report_period);

    doc.moveDown(2)
        .font('fonts/Poppins-Bold.ttf')
        .fontSize(12)
        .fillColor("#2D1952")
        .text('Resumen General: ')
        .font('fonts/Poppins-Regular.ttf')
        .fillColor("black")
        .text(user_summary, {align: "justify"});
    
    let index = 0;
    sessions.forEach((session) => {
        if(session.content){
            doc.addPage()
                .image('pngs/alicia_fab.png', 450, 50, {width:100})
                .font('fonts/Poppins-Bold.ttf')
                .fontSize(24)
                .fillColor("#2D1952")
                .text('Sesión #' + index)
                .moveDown()
                .font('fonts/Poppins-Medium.ttf')
                .fontSize(16)
                .fillColor("black")
                .text("Fecha: " + session.date)
                .moveDown()
                .font('fonts/Poppins-Bold.ttf')
                .fontSize(12)
                .fillColor("#2D1952")
                .text('Resumen Sesión: ')
                .fontSize(12)
                .font('fonts/Poppins-Regular.ttf')
                .fillColor("black")
                .text(session.content);

            index++;
        }
    });
    
    doc.end();
}

export { generate_report };
