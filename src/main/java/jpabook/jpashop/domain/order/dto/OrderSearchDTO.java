package jpabook.jpashop.domain.order.dto;


import jpabook.jpashop.domain.order.vo.OrderStatus;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.Setter;

@Getter
@Setter
//@RequiredArgsConstructor
public class OrderSearchDTO {

    private String memberName;
    private OrderStatus orderStatus;

}
