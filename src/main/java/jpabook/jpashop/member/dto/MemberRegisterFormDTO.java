package jpabook.jpashop.member.dto;

import lombok.Getter;
import lombok.Setter;

import javax.validation.constraints.NotEmpty;

@Getter @Setter
public class MemberRegisterFormDTO {

    @NotEmpty
    private String name;
    private String city;
    private String street;
    private String zipcode;

}