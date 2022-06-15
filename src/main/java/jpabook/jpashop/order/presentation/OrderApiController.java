package jpabook.jpashop.order.presentation;

import jpabook.jpashop.order.command.domain.dto.OrderSearchDTO;
import jpabook.jpashop.order.command.domain.entity.Order;
import jpabook.jpashop.order.command.domain.entity.OrderItem;
import jpabook.jpashop.order.command.domain.repository.OrderRepository;
import jpabook.jpashop.order.command.service.OrderService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.sql.DriverManager;
import java.util.List;

@RestController
@RequiredArgsConstructor
@Slf4j
public class OrderApiController {

    private final OrderRepository orderRepository;
    private final OrderService orderService;

    @GetMapping("/api/v1/orders")
    public List<Order> ordersV1(){
        List<Order> orders = orderRepository.findAllByString(new OrderSearchDTO());
        // 엔티티 내부 연관 엔티티 강제 영속화
        // 당연히 N+1이 왕왕 발생중이다.
        for (Order order : orders) {
            order.getMember().getName();
            order.getDelivery().getAddress();
            List<OrderItem> orderItems = order.getOrderItems();
            // 엔티티 내부 연관 엔티티 강제 영속화
            // 이경우엔... 이 리스트의 길이가 길수록 말도 안되게 쿼리가 반복해서 요청된다...
            // 당연히 N+1이 왕왕 발생중이다.
            for (OrderItem orderItem : orderItems) {
                orderItem.getItem().getName();
            }
        }
        return orders;
    }

}
