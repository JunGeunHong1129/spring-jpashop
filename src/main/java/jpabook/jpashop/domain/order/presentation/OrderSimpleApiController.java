package jpabook.jpashop.domain.order.presentation;

import jpabook.jpashop.domain.order.command.domain.dto.OrderSearchDTO;
import jpabook.jpashop.domain.order.query.domain.dto.SimpleOrderDTO;
import jpabook.jpashop.domain.order.command.domain.entity.Order;
import jpabook.jpashop.domain.order.command.domain.repository.OrderRepository;
import jpabook.jpashop.domain.order.query.domain.repository.OrderSimpleQueryRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

import static java.util.stream.Collectors.*;

/**
 * xToOne(ManyToOne, OneToOne)
 * Order
 * Order -> Member
 * Order -> Delivery
 */
@Slf4j
@RestController
@RequiredArgsConstructor
public class OrderSimpleApiController {

    private final OrderRepository orderRepository;
    private final OrderSimpleQueryRepository orderSimpleQueryRepository;

    @GetMapping("/api/v1/simple-orders")
    public List<Order> ordersV1(){
        return orderRepository.findAllByString(new OrderSearchDTO());
    }

    @GetMapping("/api/v2/simple-orders")
    public List<SimpleOrderDTO> ordersV2(){
        List<Order> orders = orderRepository.findAllByString(new OrderSearchDTO());
        return orders.stream().map(SimpleOrderDTO::fromOrder).collect(toList());
    }

    @GetMapping("/api/v3/simple-orders")
    public List<SimpleOrderDTO> ordersV3(){
        List<Order> orders = orderRepository.findAllWithMemberDelivery();
        return orders.stream().map(SimpleOrderDTO::fromOrder).collect(toList());
    }

    @GetMapping("/api/v4/simple-orders")
    public List<SimpleOrderDTO> ordersV4(){
        return orderSimpleQueryRepository.findOrderDTOs();
    }


}
