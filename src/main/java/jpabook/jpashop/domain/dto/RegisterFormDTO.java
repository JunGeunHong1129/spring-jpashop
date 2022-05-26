package jpabook.jpashop.domain.dto;

import lombok.Getter;
import lombok.Setter;

import javax.validation.constraints.NotEmpty;

@Getter @Setter
public class RegisterFormDTO {

    @NotEmpty
    private String name;
    private String city;
    private String street;
    private String zipcode;

}
