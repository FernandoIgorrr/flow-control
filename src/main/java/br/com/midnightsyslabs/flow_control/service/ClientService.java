package br.com.midnightsyslabs.flow_control.service;

import org.springframework.stereotype.Service;

import br.com.midnightsyslabs.flow_control.config.Constants;
import br.com.midnightsyslabs.flow_control.domain.entity.partner.City;
import br.com.midnightsyslabs.flow_control.domain.entity.partner.CompanyPartner;
import br.com.midnightsyslabs.flow_control.domain.entity.partner.PartnerRole;
import br.com.midnightsyslabs.flow_control.domain.entity.partner.PersonalPartner;
import br.com.midnightsyslabs.flow_control.exception.IllegalEmailArgumentException;
import br.com.midnightsyslabs.flow_control.exception.InvalidCNPJException;
import br.com.midnightsyslabs.flow_control.exception.InvalidCPFException;
import br.com.midnightsyslabs.flow_control.repository.partner.CompanyPartnerRepository;
import br.com.midnightsyslabs.flow_control.repository.partner.PersonalPartnerRepository;

@Service
public class ClientService {

    private final PersonalPartnerRepository personalPartnerRepository;
    private final CompanyPartnerRepository companyPartnerRepository;

    public ClientService(

            CompanyPartnerRepository companyPartnerRepository,
            PersonalPartnerRepository personalPartnerRepository) {

        this.companyPartnerRepository = companyPartnerRepository;
        this.personalPartnerRepository = personalPartnerRepository;

    }

    public void saveClient(String name,
            String document,
            String phone,
            String email,
            City city,
            String partnerRole) {

        if (email != null && !email.isBlank() && !isValidEmail(email)) {
            throw new IllegalEmailArgumentException();
        }
        
        document = document.replaceAll("\\D", "");
        phone = phone.replaceAll("\\D", "");

        

        if (partnerRole.equals(Constants.PESSOA_FISICA)) {

            if(!cPFValidator(document)) {
                throw new InvalidCPFException();
            }

            var client = new PersonalPartner(name,
                    document.isBlank() ? null : document,
                    phone,
                    email,
                    city,
                    new PartnerRole(Constants.PARTNER_ROLE_CLIENT, null));
            personalPartnerRepository.save(client);

        } else {
               if(!cNPJValidator(document)) {
                throw new InvalidCNPJException();
            }
            var client = new CompanyPartner(name,
                    document.isBlank() ? null : document,
                    phone,
                    email,
                    city,
                    new PartnerRole(Constants.PARTNER_ROLE_CLIENT, null));
            companyPartnerRepository.save(client);

        }
    }

    private boolean isValidEmail(String email) {
        return email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$");
    }

    public static boolean cPFValidator(String cpf) {
        if(cpf == null || cpf.isBlank()) {
            return true;
        }

        // Deve ter 11 dígitos
        if (cpf.length() != 11) {
            return false;
        }

        // Não pode ser todos os dígitos iguais
        if (cpf.chars().distinct().count() == 1) {
            return false;
        }

        try {
            int sum = 0;

            // Primeiro dígito verificador
            for (int i = 0; i < 9; i++) {
                int digit = cpf.charAt(i) - '0';
                sum += digit * (10 - i);
            }

            int firstCheck = (sum * 10) % 11;
            if (firstCheck == 10)
                firstCheck = 0;

            if (firstCheck != (cpf.charAt(9) - '0')) {
                return false;
            }

            // Segundo dígito verificador
            sum = 0;
            for (int i = 0; i < 10; i++) {
                int digit = cpf.charAt(i) - '0';
                sum += digit * (11 - i);
            }

            int secondCheck = (sum * 10) % 11;
            if (secondCheck == 10)
                secondCheck = 0;

            return secondCheck == (cpf.charAt(10) - '0');

        } catch (NumberFormatException e) {
            return false;
        }
    }

    public boolean cNPJValidator(String cnpj) {
        if(cnpj == null || cnpj.isBlank()) {
            return true;
        }
        // Remove tudo que não for dígito
        cnpj = cnpj.replaceAll("\\D", "");

        // Deve ter 14 dígitos
        if (cnpj.length() != 14) {
            return false;
        }

        // Não pode ser todos os dígitos iguais
        if (cnpj.chars().distinct().count() == 1) {
            return false;
        }

        int[] weight1 = { 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2 };
        int[] weight2 = { 6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2 };

        try {
            int sum = 0;

            // Primeiro dígito verificador
            for (int i = 0; i < 12; i++) {
                sum += (cnpj.charAt(i) - '0') * weight1[i];
            }

            int firstCheck = sum % 11;
            firstCheck = (firstCheck < 2) ? 0 : 11 - firstCheck;

            if (firstCheck != (cnpj.charAt(12) - '0')) {
                return false;
            }

            sum = 0;

            // Segundo dígito verificador
            for (int i = 0; i < 13; i++) {
                sum += (cnpj.charAt(i) - '0') * weight2[i];
            }

            int secondCheck = sum % 11;
            secondCheck = (secondCheck < 2) ? 0 : 11 - secondCheck;

            return secondCheck == (cnpj.charAt(13) - '0');

        } catch (NumberFormatException e) {
            return false;
        }
    }

}
