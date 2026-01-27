package br.com.midnightsyslabs.flow_control.view;

import java.math.BigDecimal;

import org.hibernate.annotations.Immutable;

import br.com.midnightsyslabs.flow_control.domain.entity.production.ProductionRawMaterialsPurchaseId;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Getter
@Setter
@Immutable
@AllArgsConstructor
@NoArgsConstructor
@Table(name ="production_raw_material_purchase_full")
public class ProductionRawMaterialPurchaseView {

    @EmbeddedId
    private ProductionRawMaterialsPurchaseId id;

    private String rawMaterialName;

    private String rawMaterialDescription;

    private BigDecimal purchaseTotalPrice;

    private BigDecimal quantityTotal;

    private String measurementSymbol;
   
    private BigDecimal quantityUsed;
}
