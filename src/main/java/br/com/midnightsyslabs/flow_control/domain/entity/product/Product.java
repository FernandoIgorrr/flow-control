package br.com.midnightsyslabs.flow_control.domain.entity.product;

import java.math.BigDecimal;
import java.time.OffsetDateTime;
import java.util.List;

import lombok.Setter;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import jakarta.persistence.Id;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.PrePersist;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.CascadeType;
import jakarta.persistence.GenerationType;
import jakarta.persistence.GeneratedValue;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;

@Entity
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Short id;

    @NotNull
    private String name;

    @NotNull
    private String description;

    @NotNull
    @ManyToOne
    @JoinColumn(nullable = false)
    private ProductCategory category;

    @NotNull
    @OneToMany(mappedBy = "product", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<ProductPrice> productPriceHistory;

    @Positive
    @NotNull
    private BigDecimal quantity;

    @NotNull
    @ManyToOne
    @JoinColumn(nullable = false)
    private MeasurementUnit measurementUnit;

    @NotNull
    @Column(nullable = false)
    private OffsetDateTime createdAt;

    private OffsetDateTime deletedAt;

    @PrePersist
    protected void onCreate() {
        this.createdAt = OffsetDateTime.now();
    }
}
