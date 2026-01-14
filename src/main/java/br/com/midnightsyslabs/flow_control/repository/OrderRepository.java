package br.com.midnightsyslabs.flow_control.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import br.com.midnightsyslabs.flow_control.domain.entity.Order;

public interface OrderRepository extends JpaRepository<Order,Long>{
    List<Order> findAll();
}
