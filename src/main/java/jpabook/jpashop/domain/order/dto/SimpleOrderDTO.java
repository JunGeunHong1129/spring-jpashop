package jpabook.jpashop.domain.order.dto;

import jpabook.jpashop.common.vo.Address;
import jpabook.jpashop.domain.order.entity.Order;
import jpabook.jpashop.domain.order.vo.OrderStatus;
import lombok.Data;
import lombok.RequiredArgsConstructor;

import java.time.LocalDateTime;

@Data
@RequiredArgsConstructor
public class SimpleOrderDTO {
    private Long orderId;
    private String name;
    private LocalDateTime orderDate;
    private OrderStatus orderStatus;
    private Address address;

    public SimpleOrderDTO(Order order) {
        orderId = order.getId();
        name=order.getMember().getName();
        orderDate=order.getOrderDate();
        orderStatus=order.getOrderStatus();
        address=order.getDelivery().getAddress();
    }
}
