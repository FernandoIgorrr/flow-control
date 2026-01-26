package br.com.midnightsyslabs.flow_control.service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import br.com.midnightsyslabs.flow_control.domain.entity.product.MeasurementUnit;
import br.com.midnightsyslabs.flow_control.domain.entity.product.Product;
import br.com.midnightsyslabs.flow_control.domain.entity.production.Production;
import br.com.midnightsyslabs.flow_control.domain.entity.production.ProductionRawMaterialPurchase;
import br.com.midnightsyslabs.flow_control.domain.entity.production.ProductionRawMaterialsPurchaseId;
import br.com.midnightsyslabs.flow_control.exception.PurchaseNotFoundException;
import br.com.midnightsyslabs.flow_control.ui.controller.form.PurchaseRow;
import br.com.midnightsyslabs.flow_control.repository.production.ProductionRepository;

import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;

import jakarta.transaction.Transactional;

@Service
public class ProductionService {
    @Autowired
    private PurchaseService purchaseService;
    @Autowired
    private ProductionRepository productionRepository;

    @Transactional
    public void saveProdction(
            List<PurchaseRow> purchasesRow,
            String grossProductQuantity,
            MeasurementUnit grossMeasurementUnit,
            Product product,
            String quantityProduced,
            LocalDate date
            ) {
        String quantityProducedPattern = UtilsService.solveComma(quantityProduced);

        var production = new Production();
        List<ProductionRawMaterialPurchase> productionRawMaterialsPurchase = new ArrayList<>();
        production.setDate(date);
        production.setProduct(product);
        production.setGqpMeasurementUnit(grossMeasurementUnit);

        try {
            production.setGrossQuantityProduced(new BigDecimal(grossProductQuantity));
            production.setQuantityProduced(new BigDecimal(quantityProducedPattern));

            for (var row : purchasesRow) {

                ProductionRawMaterialPurchase productionRawMaterialPurchase = new ProductionRawMaterialPurchase();
                productionRawMaterialPurchase.setId(new ProductionRawMaterialsPurchaseId());
                productionRawMaterialPurchase.setProduction(production);
               productionRawMaterialPurchase
                        .setQuantityUsed(new BigDecimal(UtilsService.solveComma(row.quantityField.getText())));

                purchaseService.getById(row.dto.getId()).ifPresentOrElse(purchase -> {
                    productionRawMaterialPurchase.setPurchase(purchase);
                }, PurchaseNotFoundException::new);

            productionRawMaterialsPurchase.add(productionRawMaterialPurchase);
            }

        } 
        catch (Exception e) {
            throw e;
        }
        production.setProductionRawMaterialsPurchase(productionRawMaterialsPurchase);
        productionRepository.save(production);
    }
}
