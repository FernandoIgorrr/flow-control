package br.com.midnightsyslabs.flow_control.service;

import org.springframework.stereotype.Service;


@Service
public class OrderService {
   /* private final OrderRepository orderRepository;

    public OrderService(OrderRepository orderRepository) {
        this.orderRepository = orderRepository;
    }

    @Transactional
    public Order createOrder(Partner partner, LocalDateTime createAt, List<OrderProduct> products, Short discount) {

        Order order = new Order(partner, createAt, products, discount);
        calculateTotalAmount(order);
        calculateDiscoutedAmount(order);

        return orderRepository.save(order);
    }

    private BigDecimal calculateTotalAmount(Order order){
        var mapped = order.getProducts().stream().map(product -> product.getUnitPrice().multiply(product.getProductQuantity()));
        return mapped.reduce(BigDecimal.ZERO,BigDecimal::add);
    }

    private BigDecimal calculateDiscoutedAmount(Order order){
        BigDecimal total = calculateTotalAmount(order);

        BigDecimal discount =order.getDiscount();

        BigDecimal discountFactor = discount.divide(new BigDecimal("100"));
        
        BigDecimal discountValue = total.multiply(discountFactor);

        return total.subtract(discountValue);
    }*/

}
