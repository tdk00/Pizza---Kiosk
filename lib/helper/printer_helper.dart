import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';

class PrinterHelper{
  void generatePrintContent(NetworkPrinter printer, orderNumber, orderId) {
    printer.text('KingsPizza',
        styles: PosStyles(
          height: PosTextSize.size3,
          width: PosTextSize.size3,
          align: PosAlign.center
        ));
    printer.text('________________________________________________                          ',
        styles: PosStyles(
          height: PosTextSize.size1,
          width: PosTextSize.size1,
        ));
    printer.text(orderNumber,
        styles: PosStyles(
          height: PosTextSize.size5,
          width: PosTextSize.size5,
          align: PosAlign.center,
          bold: true
        ));
    printer.text('________________________________________________                                ',
        styles: PosStyles(
          height: PosTextSize.size1,
          width: PosTextSize.size1,
        ));

    printer.text('KOD',
        styles: PosStyles(
            height: PosTextSize.size2,
            width: PosTextSize.size2,
            align: PosAlign.center
        ));
    printer.text('KPIZ' + orderId,
        styles: PosStyles(
            height: PosTextSize.size1,
            width: PosTextSize.size1,
            align: PosAlign.center
        ));


    printer.feed(2);
    printer.cut();
  }
}