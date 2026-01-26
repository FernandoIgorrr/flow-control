package br.com.midnightsyslabs.flow_control.dto;

import java.time.LocalDate;
import java.time.OffsetDateTime;
import java.util.List;

import br.com.midnightsyslabs.flow_control.view.ProductionRawMaterialPurchaseView;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ProductionDTO {
    private Integer id;

    private List<ProductionRawMaterialPurchaseView> rawMaterialsPurchaseDTO;

    private LocalDate date;

    private OffsetDateTime createdAt;

    private OffsetDateTime deletesAt;

    private boolean isClosed;
}
