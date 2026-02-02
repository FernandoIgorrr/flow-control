package br.com.midnightsyslabs.flow_control.ui.controller.card;

import java.time.format.DateTimeFormatter;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import br.com.midnightsyslabs.flow_control.domain.entity.employee.EmployeePayment;
import br.com.midnightsyslabs.flow_control.service.EmojiService;
import br.com.midnightsyslabs.flow_control.service.UtilsService;
import javafx.fxml.FXML;
import javafx.scene.control.Label;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;

@Controller
public class EmployeePaymentCardController {

        @Autowired
        private EmojiService emojiService;

        @FXML
        private Label lblSpentCategory;

        @FXML
        private Label lblEmployeeName;

        @FXML
        private Label lblTotalPaid;

        @FXML
        private Label lblDate;

        @FXML
        private ImageView imgType;

        public void setEmployeePayment(EmployeePayment employeePayment) {

                lblSpentCategory.setText(emojiService.getEmoji(employeePayment.getSpentCategory().getId()) + " "
                                + employeePayment.getSpentCategory().getName());

                imgType.setImage(new Image(
                                getClass().getResourceAsStream("/images/lucide--calendar.png")));
                imgType.getStyleClass().add("grey-icon");
                lblEmployeeName.setText(employeePayment.getEmployee().getName());

                DateTimeFormatter formatter = DateTimeFormatter.ofPattern(
                                "dd 'de' MMMM 'de' yyyy",
                                Locale.forLanguageTag("pt-BR"));

                lblDate.setText(employeePayment.getDate().format(formatter));
                lblTotalPaid.setText(UtilsService.formatPrice(employeePayment.getExpense()));

                /*
                 * lblPurchaseId.setText("#" + purchaseView.getId().toString());
                 * lblPurchaseId.setEditable(false);
                 * lblPurchaseId.setFocusTraversable(false);
                 * 
                 * lblTotalPrice.setText(UtilsService.formatPrice( purchaseView.getExpense()));
                 * lblQuantityTitle.setText(purchaseView.getMeasurementUnitUnit());
                 * lblSupplierName.setText(purchaseView.getPartnerName());
                 * lblPricePerUnitTitle.setText("Preço por " +
                 * purchaseView.getMeasurementUnitName() + " ("
                 * + purchaseView.getMeasurementUnitSymbol() + ")");
                 * lblQuantity.setText(UtilsService.formatQuantity(purchaseView.getQuantity())
                 * + " " + purchaseView.getMeasurementUnitPluralName() + " ("
                 * + purchaseView.getMeasurementUnitSymbol() + ")");
                 * lblUnitPrice.setText(UtilsService.formatPrice(purchaseView.getPricePerUnit())
                 * );
                 * DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
                 * lblDate.setText(purchaseView.getDate().format(formatter));
                 * lblNote.setText(purchaseView.getNote().isBlank() ? "-" :
                 * purchaseView.getNote());
                 */
        }
}
