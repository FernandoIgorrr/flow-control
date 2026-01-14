package br.com.midnightsyslabs.flow_control.repository;

import java.util.List;
import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;

import br.com.midnightsyslabs.flow_control.domain.entity.Client;

public interface ClientRepository extends JpaRepository<Client,UUID>{
    
    List<Client> findAll();
}
