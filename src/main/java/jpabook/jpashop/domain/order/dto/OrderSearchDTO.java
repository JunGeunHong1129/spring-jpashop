package jpabook.jpashop.domain.order.dto;


import jpabook.jpashop.domain.order.vo.OrderStatus;
import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public class OrderSearchDTO {

    private final String memberName;
    private final OrderStatus orderStatus;

}
