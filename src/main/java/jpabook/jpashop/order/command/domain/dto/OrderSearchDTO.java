package jpabook.jpashop.order.command.domain.dto;


import jpabook.jpashop.order.vo.OrderStatus;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
//@RequiredArgsConstructor
public class OrderSearchDTO {

    private String memberName;
    private OrderStatus orderStatus;

}
