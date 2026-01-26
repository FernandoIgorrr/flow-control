package br.com.midnightsyslabs.flow_control.view;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.OffsetDateTime;
import org.hibernate.annotations.Immutable;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
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
@Table(name = "production_full")
public class ProductionView {
    @Id
    private Integer id;

    private BigDecimal grossQuantityProduced;

    private String grossQuantityMeasurementUnitUnit;

    private String grossQuantityMeasurementUnitName;

    private String grossQuantityMeasurementUnitPluralName;

    private String grossQuantityMeasurementUnitSymbol;

    private String productName;

    private String productDescription;

    private BigDecimal quantityProduced;

    private LocalDate date;

    private OffsetDateTime createdAt;

    private OffsetDateTime deletedAt;

    private boolean isClosed;

}
