package br.com.midnightsyslabs.flow_control.domain.entity;

import java.math.BigDecimal;

import jakarta.persistence.*;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;

@Entity
@Table(name = "order_products")
public class OrderProduct {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="order_products_id")
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "order_id") 
    private Order order;

    @ManyToOne
    @NotNull
    @JoinColumn(name = "product_id", nullable = false)
    private Product product;

    @Column(name = "product_quantity", nullable = false)
    @NotNull
    @Min(1)
    private Integer productQuantity;

    @Column(name = "unit_price", nullable = false)
    @NotNull
    @Min(0)
    private BigDecimal unitPrice;

   public Integer getProductQuantity() {
       return productQuantity;
   }
    public BigDecimal getUnitPrice() {
        return unitPrice;
    }
}
