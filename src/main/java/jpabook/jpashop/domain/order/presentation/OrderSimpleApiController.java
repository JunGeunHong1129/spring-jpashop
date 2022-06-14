package jpabook.jpashop.domain.order.presentation;

import jpabook.jpashop.domain.order.dto.OrderSearchDTO;
import jpabook.jpashop.domain.order.dto.SimpleOrderDTO;
import jpabook.jpashop.domain.order.entity.Order;
import jpabook.jpashop.domain.order.repository.OrderRepository;
import jpabook.jpashop.domain.order.service.OrderService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.stream.Collectors;

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




    @GetMapping("/api/v1/simple-orders")
    public List<Order> ordersV1(){
        return orderRepository.findAllByString(new OrderSearchDTO());
    }

    @GetMapping("/api/v2/simple-orders")
    public List<SimpleOrderDTO> ordersV2(){
        List<Order> orders = orderRepository.findAllByString(new OrderSearchDTO());
        return orders.stream().map(SimpleOrderDTO::new).collect(toList());
    }


}
