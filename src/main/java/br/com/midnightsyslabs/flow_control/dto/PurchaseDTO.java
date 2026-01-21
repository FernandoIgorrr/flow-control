package br.com.midnightsyslabs.flow_control.dto;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.OffsetDateTime;

import br.com.midnightsyslabs.flow_control.converter.PartnerCategoryConverter;
import jakarta.persistence.Convert;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "purchase_full")
public class PurchaseDTO {
    @Id
    private Integer id;

    private String partnerName;

    @Convert(converter = PartnerCategoryConverter.class)
    private PartnerCategory partnerCategory;

    private String rawMaterialName;

    private String rawMaterialDescription;

    private BigDecimal quantity;

    private String measurementUnitUnit;

    private String measurementUnitName;

    private String measurementUnitSymbol;

    private BigDecimal totalPrice;

    private LocalDate date;

    private String note;

    private OffsetDateTime createdAt;

    private OffsetDateTime deletedAt;

    private boolean isClosed;

}
