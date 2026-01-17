package br.com.midnightsyslabs.flow_control.config;

public interface Constants {
    Short PARTNER_ROLE_CLIENT = 1;
    Short PARTNER_ROLE_SUPPLIER = 2;

    Short ORDER_CATEGORY_PERSONAL = 1;
    Short ORDER_CATEGORY_COMPANIE = 2;

    String PESSOA_FISICA = "Pessoa Física";
    String COMPANIA = "Compania";

    String[] PARTNER_ROLES = {PESSOA_FISICA, COMPANIA};
}
