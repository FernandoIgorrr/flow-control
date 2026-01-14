package br.com.midnightsyslabs.flow_control.domain.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "orders")
@NoArgsConstructor
public class Order {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="order_id")
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "client_id", nullable = false)
    private Client client;

    @Column(name = "created_at", nullable = false, columnDefinition = "date")
    @NotNull
    private LocalDateTime createdAt;

    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL)
    private List<OrderProduct> products;

    @Column(name="discount", nullable = false)
    @NotNull
    @Min(0)
    @Max(100)
    private Short discount; 

    @Column(name = "total_amount", nullable = false)
    private BigDecimal totalAmount;
    

    public Order(Client client,LocalDateTime createdAt,List<OrderProduct> products, Short discount){
        this.client = client;
        this.createdAt = createdAt;
        this.products = products;
        this.discount = discount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public List<OrderProduct> getProducts(){
        return products;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public Short getDiscount() {
        return discount;
    }
}
