package jpabook.jpashop.order.query.domain.dto;

import jpabook.jpashop.common.vo.Address;
import jpabook.jpashop.order.command.domain.entity.Order;
import jpabook.jpashop.order.vo.OrderStatus;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Data
public class OrderQueryFlatDTO {
    private Long orderId;
    private String name;
    private LocalDateTime orderDate;
    private OrderStatus orderStatus;
    private Address address;

    private String itemName;
    private int orderPrice;
    private int count;

    private List<OrderItemQueryDTO> orderItems = new ArrayList<>();

    protected OrderQueryFlatDTO() {
    }
    // 제대로 쓸려면 원래는 아래 로직을 위에 넣는게 맞긴함
    public OrderQueryFlatDTO(Long orderId,
                         String name,
                         LocalDateTime orderDate,
                         OrderStatus orderStatus,
                         Address address,String itemName,
                                     int orderPrice,
                                     int count) {
        this.orderId = orderId;
        this.name = name;
        this.orderDate = orderDate;
        this.orderStatus = orderStatus;
        this.address = address;

        this.itemName=itemName;
        this.orderPrice=orderPrice;
        this.count=count;
    }

}
