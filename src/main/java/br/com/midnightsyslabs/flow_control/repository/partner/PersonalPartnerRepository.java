package br.com.midnightsyslabs.flow_control.repository.partner;

import java.util.List;
import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import br.com.midnightsyslabs.flow_control.domain.entity.partner.PersonalPartner;

@Repository
public interface PersonalPartnerRepository extends JpaRepository<PersonalPartner, UUID> {
    @Override
    List<PersonalPartner> findAll();
}
