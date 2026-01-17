package br.com.midnightsyslabs.flow_control.repository.view;

import java.util.List;
import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import br.com.midnightsyslabs.flow_control.dto.ClientDTO;

@Repository
public interface ClientRepository extends JpaRepository<ClientDTO, UUID> {
    @Override
    List<ClientDTO> findAll();
}
