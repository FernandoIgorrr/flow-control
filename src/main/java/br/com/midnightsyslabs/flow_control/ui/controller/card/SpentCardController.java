package br.com.midnightsyslabs.flow_control.ui.controller.card;

import java.time.format.DateTimeFormatter;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import br.com.midnightsyslabs.flow_control.domain.entity.spent.Spent;
import br.com.midnightsyslabs.flow_control.service.EmojiService;
import br.com.midnightsyslabs.flow_control.service.UtilsService;
import javafx.fxml.FXML;
import javafx.scene.control.Label;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;

@Controller
@Scope("prototype")
public class SpentCardController {
    @Autowired
    private EmojiService emojiService;

    @FXML
    private Label lblSpentCategory;

    @FXML
    private Label lblSpentDescription;

    @FXML
    private Label lblDate;

    @FXML
    private ImageView imgType;

    @FXML
    private Label lblTotalPaid;

    public void setSpent(Spent spent) {

        imgType.setImage(new Image(
                getClass().getResourceAsStream("/images/lucide--calendar.png")));
        imgType.getStyleClass().add("grey-icon");

        lblSpentCategory.setText(emojiService.getEmoji(spent.getSpentCategory().getId()) + " "
                + spent.getSpentCategory().getName());

        lblSpentCategory.getStyleClass().add("category-box-"+spent.getSpentCategory().getId());
        
        lblSpentDescription.setText(spent.getDescription());

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern(
                "dd 'de' MMMM 'de' yyyy",
                Locale.forLanguageTag("pt-BR"));

        lblDate.setText(spent.getDate().format(formatter));

        lblTotalPaid.setText(UtilsService.formatPrice(spent.getExpense()));
    }
}
