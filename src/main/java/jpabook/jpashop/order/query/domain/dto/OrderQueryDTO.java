package jpabook.jpashop.order.query.domain.dto;

import jpabook.jpashop.common.vo.Address;
import jpabook.jpashop.order.command.domain.entity.Order;
import jpabook.jpashop.order.vo.OrderStatus;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Data
@EqualsAndHashCode(of = "orderId")
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

    public OrderQueryDTO(Long orderId,
                    String name,
                    LocalDateTime orderDate,
                    OrderStatus orderStatus,
                    Address address, List<OrderItemQueryDTO> orderItems) {
        this.orderId = orderId;
        this.name = name;
        this.orderDate = orderDate;
        this.orderStatus = orderStatus;
        this.address = address;
        this.orderItems = orderItems;
    }



    public static OrderQueryDTO fromOrder(Order order) {

        return new OrderQueryDTO(order.getId(),
                order.getMember().getName(),
                order.getOrderDate(),
                order.getOrderStatus(),
                order.getDelivery().getAddress(),new ArrayList<>());

    }

    public static OrderQueryDTO fromOrderQueryFlatDTO(OrderQueryFlatDTO orderQueryFlatDTO){
        return new OrderQueryDTO(orderQueryFlatDTO.getOrderId(),
                orderQueryFlatDTO.getName(),
                orderQueryFlatDTO.getOrderDate(),
                orderQueryFlatDTO.getOrderStatus(),
                orderQueryFlatDTO.getAddress(),new ArrayList<>());
    }

    public static OrderQueryDTO fromMapEntry(Map.Entry<OrderQueryDTO, List<OrderItemQueryDTO>> orderQueryDTOListMap){
        return new OrderQueryDTO(orderQueryDTOListMap.getKey().getOrderId(),
                orderQueryDTOListMap.getKey().getName(),
                orderQueryDTOListMap.getKey().getOrderDate(),
                orderQueryDTOListMap.getKey().getOrderStatus(),
                orderQueryDTOListMap.getKey().getAddress(),orderQueryDTOListMap.getValue());
    }
}

