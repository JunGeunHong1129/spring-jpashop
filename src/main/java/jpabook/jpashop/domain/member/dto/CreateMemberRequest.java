package jpabook.jpashop.domain.member.dto;

import lombok.Data;

import javax.validation.constraints.NotEmpty;

@Data
public class CreateMemberRequest{
    @NotEmpty
    private String name;
}
