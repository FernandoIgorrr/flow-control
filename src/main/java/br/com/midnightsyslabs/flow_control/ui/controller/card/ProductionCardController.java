package br.com.midnightsyslabs.flow_control.ui.controller.card;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import br.com.midnightsyslabs.flow_control.service.ProductionService;

@Controller
public class ProductionCardController {
    @Autowired
    private ProductionService productionService;

    
}
