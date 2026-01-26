package br.com.midnightsyslabs.flow_control.domain.entity.production;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.OffsetDateTime;
import java.util.List;

import br.com.midnightsyslabs.flow_control.domain.entity.product.MeasurementUnit;
import br.com.midnightsyslabs.flow_control.domain.entity.product.Product;

import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.OneToMany;
import jakarta.persistence.PrePersist;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Production {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @NotNull
    @ManyToOne
    @JoinColumn
    private Product product;

    @NotNull
    @Positive
    private BigDecimal grossQuantityProduced;

    @NotNull
    @ManyToOne
    @JoinColumn(nullable = false)
    private MeasurementUnit gqpMeasurementUnit;

    @NotNull
    @Positive
    private BigDecimal quantityProduced;

    @NotNull
    @OneToMany(mappedBy = "production", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<ProductionRawMaterialPurchase> productionRawMaterialsPurchase;

    @NotNull
    @Column(columnDefinition = "date")
    private LocalDate date;

    @NotNull
    private OffsetDateTime createdAt;

    private OffsetDateTime deletedAt;

    @NotNull
    private boolean isClosed;

    private OffsetDateTime closedAt;

    @PrePersist
    protected void onCreate() {
        this.createdAt = OffsetDateTime.now();
        this.isClosed = false;
    }
}
