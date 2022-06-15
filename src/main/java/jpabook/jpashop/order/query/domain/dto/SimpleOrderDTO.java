package jpabook.jpashop.order.query.domain.dto;

import jpabook.jpashop.common.vo.Address;
import jpabook.jpashop.order.command.domain.entity.Order;
import jpabook.jpashop.order.vo.OrderStatus;
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

    public static SimpleOrderDTO fromOrder(Order order) {
        return new SimpleOrderDTO(order.getId(), order.getOrderDate(), order.getMember().getName(), order.getOrderStatus(), order.getDelivery().getAddress());
    }

    public SimpleOrderDTO(Long orderId, LocalDateTime orderDate, String name, OrderStatus orderStatus, Address address) {
        this.orderId = orderId;
        this.name = name;
        this.orderDate = orderDate;
        this.orderStatus = orderStatus;
        this.address = address;
    }
}
