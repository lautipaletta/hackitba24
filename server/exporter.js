import PDFDocument from "pdfkit"
import fs from "fs"

function generate_report(user_name, user_id, user_summary, report_period, sessions){
    const doc = new PDFDocument();

    doc.pipe(fs.createWriteStream(`reports/${user_id}.pdf`));
    
    doc.font('fonts/Poppins-Bold.ttf')
        .fontSize(32)
        .text('Reporte para fines psicoanalíticos');
    
    doc.moveDown()
        .font('fonts/Poppins-Medium.ttf')
        .fontSize(16)
        .text('Nombre: ' + user_name)
        .moveDown()
        .fontSize(12)
        .text('Periodo de análisis: ' + report_period);

    doc.moveDown(2)
        .font('fonts/Poppins-Bold.ttf')
        .fontSize(12)
        .text('Resumen General: ' + user_summary, {align: "justify"});
    
    sessions.forEach((session, index) => {
        doc.addPage()
            .font('fonts/Poppins-Bold.ttf')
            .fontSize(24)
            .text('Session #' + index)
            .moveDown()
            .font('fonts/Poppins-Medium.ttf')
            .fontSize(16)
            .text("Fecha: " + session.period)
            .moveDown(2)
            .fontSize(12)
            .font('fonts/Poppins-Regular.ttf')
            .text(session.content);
    });
    
    doc.end();
}

export { generate_report };