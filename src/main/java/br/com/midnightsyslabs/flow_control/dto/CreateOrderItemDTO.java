package br.com.midnightsyslabs.flow_control.dto;

public record CreateOrderItemDTO (
    Long productId,
    Integer quantity
){}
