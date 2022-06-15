package jpabook.jpashop.order.command.domain.dto;

import jpabook.jpashop.common.vo.Address;
import jpabook.jpashop.order.command.domain.entity.Order;
import jpabook.jpashop.order.vo.OrderStatus;
import lombok.AllArgsConstructor;
import lombok.Data;
import org.aspectj.weaver.ast.Or;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Data
public class OrderDTO {

    private Long orderId;
    private String name;
    private LocalDateTime orderDate;
    private OrderStatus orderStatus;
    private Address address;
    private List<OrderItemDTO> orderItems = new ArrayList<>();

    protected OrderDTO() {
    }
    // 제대로 쓸려면 원래는 아래 로직을 위에 넣는게 맞긴함
    public OrderDTO(Long orderId,
                    String name,
                    LocalDateTime orderDate,
                    OrderStatus orderStatus,
                    Address address, List<OrderItemDTO> orderItems) {

        this.orderId = orderId;
        this.name = name;
        this.orderDate = orderDate;
        this.orderStatus = orderStatus;
        this.address = address;
        this.orderItems = orderItems;
    }

    public static OrderDTO fromOrder(Order order) {


        return new OrderDTO(order.getId(),
                order.getMember().getName(),
                order.getOrderDate(),
                order.getOrderStatus(),
                order.getDelivery().getAddress(),
                order.getOrderItems().stream().map(OrderItemDTO::fromOrderItem).collect(Collectors.toList()));

    }

}
