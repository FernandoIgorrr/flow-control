package br.com.midnightsyslabs.flow_control.service;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

import org.springframework.stereotype.Service;

import br.com.midnightsyslabs.flow_control.domain.entity.Client;
import br.com.midnightsyslabs.flow_control.domain.entity.Order;
import br.com.midnightsyslabs.flow_control.domain.entity.OrderProduct;
import br.com.midnightsyslabs.flow_control.repository.OrderRepository;
import jakarta.transaction.Transactional;

@Service
public class OrderService {
    private final OrderRepository orderRepository;

    public OrderService(OrderRepository orderRepository) {
        this.orderRepository = orderRepository;
    }

    @Transactional
    public Order createOrder(Client client, LocalDateTime createAt, List<OrderProduct> products, Short discount) {

        Order order = new Order(client, createAt, products, discount);
        calculateTotalAmount(order);
        calculateDiscoutedAmount(order);

        return orderRepository.save(order);
    }

    private BigDecimal calculateTotalAmount(Order order){
        var mapped = order.getProducts().stream().map(product -> product.getUnitPrice().multiply(BigDecimal.valueOf(product.getProductQuantity())));
        return mapped.reduce(BigDecimal.ZERO,BigDecimal::add);
    }

    private void calculateDiscoutedAmount(Order order){
        BigDecimal total = order.getTotalAmount();

        BigDecimal discount = BigDecimal.valueOf( order.getDiscount());

        BigDecimal discountFactor = discount.divide(new BigDecimal("100"));
        
        BigDecimal discountValue = total.multiply(discountFactor);
    
        order.setTotalAmount(total.subtract(discountValue));
    }

}
