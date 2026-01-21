package br.com.midnightsyslabs.flow_control.dto;

import java.math.BigDecimal;
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
@Table(name = "product_full")
public class ProductDTO {
    @Id
    private Short id;
    private String name;
    private String description;
    private String category;
    private BigDecimal currentPrice;
    private BigDecimal quantity;
    private String measurementUnitUnit;
    private String measurementUnitName;
    private String measurementUnitSymbol;

}
