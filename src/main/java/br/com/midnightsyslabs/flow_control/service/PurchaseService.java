package br.com.midnightsyslabs.flow_control.service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.OffsetDateTime;
import java.util.List;

import org.springframework.stereotype.Service;

import br.com.midnightsyslabs.flow_control.domain.entity.partner.Partner;
import br.com.midnightsyslabs.flow_control.domain.entity.product.MeasurementUnit;
import br.com.midnightsyslabs.flow_control.domain.entity.purchase.Purchase;
import br.com.midnightsyslabs.flow_control.domain.entity.raw_material.RawMaterial;
import br.com.midnightsyslabs.flow_control.dto.PurchaseDTO;
import br.com.midnightsyslabs.flow_control.repository.PurchaseRepository;
import br.com.midnightsyslabs.flow_control.repository.view.PurchaseFullRepository;
import jakarta.transaction.Transactional;

@Service
public class PurchaseService {

    private final PurchaseRepository purchaseRepository;

    private final PurchaseFullRepository purchaseFullRepository;

    public PurchaseService(PurchaseFullRepository purchaseFullRepository, PurchaseRepository purchaseRepository) {
        this.purchaseFullRepository = purchaseFullRepository;
        this.purchaseRepository = purchaseRepository;
    }

    @Transactional
    public void savePurchase(
            Partner partner,
            RawMaterial rawMaterial,
            String quantity,
            MeasurementUnit measurementUnit,
            String price,
            LocalDate date,
            String note) {

        price = solveComma(price);
        quantity = solveComma(quantity);

        var purchase = new Purchase();

        purchase.setPartner(partner);
        purchase.setRawMaterial(rawMaterial);

        try {
            purchase.setQuantity(new BigDecimal(quantity));
            purchase.setTotalPrice(new BigDecimal(price));
        } catch (NumberFormatException e) {
            throw new NumberFormatException("Tem algo errado com formato do preço ou com a quantidade!");
        }

        purchase.setMeasurementUnit(measurementUnit);
        purchase.setDate(date);
        purchase.setCreatedAt(OffsetDateTime.now());
        purchase.setNote(note);

        purchaseRepository.save(purchase);
    }

    public List<Purchase> getPurchases() {
        return purchaseRepository.findAll();
    }

    public List<PurchaseDTO> getPurchaseDTOs() {
        return purchaseFullRepository.findAll();
    }

    // Como nós brasileiros usamos a virgula (,) para separar a parte decimal dos
    // número
    // e aqui no Java o BigDecimal o ponto (.) esse method resolve isso!
    String solveComma(String bigDecimanStr) {
        return bigDecimanStr.replace(",", ".");
    }
}
