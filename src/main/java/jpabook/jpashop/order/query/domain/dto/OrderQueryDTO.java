package jpabook.jpashop.order.query.domain.dto;

import jpabook.jpashop.common.vo.Address;
import jpabook.jpashop.order.command.domain.entity.Order;
import jpabook.jpashop.order.vo.OrderStatus;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Data
public class OrderQueryDTO {

    private Long orderId;
    private String name;
    private LocalDateTime orderDate;
    private OrderStatus orderStatus;
    private Address address;
    private List<OrderItemQueryDTO> orderItems = new ArrayList<>();

    protected OrderQueryDTO() {
    }
    // 제대로 쓸려면 원래는 아래 로직을 위에 넣는게 맞긴함
    public OrderQueryDTO(Long orderId,
                    String name,
                    LocalDateTime orderDate,
                    OrderStatus orderStatus,
                    Address address) {
        this.orderId = orderId;
        this.name = name;
        this.orderDate = orderDate;
        this.orderStatus = orderStatus;
        this.address = address;
    }

    public static OrderQueryDTO fromOrder(Order order) {

        return new OrderQueryDTO(order.getId(),
                order.getMember().getName(),
                order.getOrderDate(),
                order.getOrderStatus(),
                order.getDelivery().getAddress());

    }
}
