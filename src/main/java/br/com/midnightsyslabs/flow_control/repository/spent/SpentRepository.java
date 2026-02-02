package br.com.midnightsyslabs.flow_control.repository.spent;

import org.springframework.data.jpa.repository.JpaRepository;

import br.com.midnightsyslabs.flow_control.domain.entity.spent.Spent;

public interface SpentRepository extends JpaRepository<Spent,Integer>{
    
}
