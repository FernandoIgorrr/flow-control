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
import br.com.midnightsyslabs.flow_control.dto.ProductionDTO;
import br.com.midnightsyslabs.flow_control.exception.PurchaseNotFoundException;
import br.com.midnightsyslabs.flow_control.ui.controller.form.PurchaseRow;
import br.com.midnightsyslabs.flow_control.view.ProductionRawMaterialPurchaseView;
import br.com.midnightsyslabs.flow_control.repository.production.ProductionRawMaterialPurchaseViewRepository;
import br.com.midnightsyslabs.flow_control.repository.production.ProductionRepository;
import br.com.midnightsyslabs.flow_control.repository.production.ProductionViewRepository;

import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;

import jakarta.transaction.Transactional;

@Service
public class ProductionService {
    @Autowired
    private PurchaseService purchaseService;

    @Autowired
    private ProductionRepository productionRepository;

    @Autowired
    private ProductionViewRepository productionViewRepository;

    @Autowired
    private ProductionRawMaterialPurchaseViewRepository prmpvRepository;

    @Transactional
    public void saveProdction(
            List<PurchaseRow> purchasesRow,
            String grossProductQuantity,
            MeasurementUnit grossMeasurementUnit,
            Product product,
            String quantityProduced,
            LocalDate date) {
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

        } catch (Exception e) {
            throw e;
        }
        production.setProductionRawMaterialsPurchase(productionRawMaterialsPurchase);
        productionRepository.save(production);
    }

    public List<ProductionDTO> getProductionsDTO() {
        var productionsView = productionViewRepository.findAll();

        var productionsDTO = productionsView.stream().map(ProductionDTO::new).toList();

        productionsDTO.forEach(pDTO -> {

            var prmpvs = prmpvRepository.findAllByProductionId(pDTO.getId());
            pDTO.setRawMaterialsPurchaseView(prmpvs);
        });

        return productionsDTO;
    }

    public BigDecimal totalExpensePerProduction(ProductionDTO pDTO){
        return pDTO.getRawMaterialsPurchaseView().stream().map(
            rmpv ->
                rmpv.getQuantityUsed().multiply(rmpv.getPurchaseTotalPrice().divide(rmpv.getQuantityTotal()))
            ).reduce(BigDecimal::add).orElseThrow();
    }

    public BigDecimal totalExpensePerUnit(ProductionDTO pDTO){
        return totalExpensePerProduction(pDTO).divide(pDTO.getQuantityProduced());
    }

      public BigDecimal gainsPerUnit(ProductionDTO pDTO){
        return  pDTO.getProductCurrentPrice().subtract(totalExpensePerUnit(pDTO));
    }

}
