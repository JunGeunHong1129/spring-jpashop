package jpabook.jpashop.domain.dto;


import jpabook.jpashop.domain.entity.OrderStatus;
import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public class OrderSearchDTO {

    private final String memberName;
    private final OrderStatus orderStatus;

}
