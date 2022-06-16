package jpabook.jpashop.order.presentation;

import jpabook.jpashop.common.dto.Result;
import jpabook.jpashop.order.command.domain.dto.OrderDTO;
import jpabook.jpashop.order.command.domain.dto.OrderSearchDTO;
import jpabook.jpashop.order.command.domain.entity.Order;
import jpabook.jpashop.order.command.domain.entity.OrderItem;
import jpabook.jpashop.order.command.domain.repository.OrderRepository;
import jpabook.jpashop.order.query.domain.dto.OrderItemQueryDTO;
import jpabook.jpashop.order.query.domain.dto.OrderQueryDTO;
import jpabook.jpashop.order.query.domain.dto.OrderQueryFlatDTO;
import jpabook.jpashop.order.query.domain.repository.OrderQueryRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.sql.DriverManager;
import java.util.List;
import java.util.stream.Collectors;


@RestController
@RequiredArgsConstructor
@Slf4j
public class OrderApiController {

    private final OrderRepository orderRepository;
    private final OrderQueryRepository orderQueryRepository;

    @GetMapping("/api/v1/orders")
    public List<Order> ordersV1() {
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

    @GetMapping("/api/v3/orders")
    public List<OrderDTO> ordersV3() {
        List<Order> orders = orderRepository.findAllWithItem();

        return orders.stream().map(OrderDTO::fromOrder).collect(Collectors.toList());
    }

    @GetMapping("/api/v3.1/orders")
    public List<OrderDTO> ordersV3_page(
            @RequestParam(value = "offset", defaultValue = "0") int offset,
            @RequestParam(value = "limit", defaultValue = "100") int limit) {
        List<Order> orders = orderRepository.findAllWithMemberDeliveryLimit(offset, limit);

        return orders.stream().map(OrderDTO::fromOrder).collect(Collectors.toList());
    }

    @GetMapping("/api/v4/orders")
    public Result<List<OrderQueryDTO>> ordersV4_page() {
        return new Result<>(orderQueryRepository.findOrderQueryDTOs());
    }

    @GetMapping("/api/v5/orders")
    public Result<List<OrderQueryDTO>> ordersV5() {
        return new Result<>(orderQueryRepository.findAllByDTO_optimization());
    }

    @GetMapping("/api/v6/orders")
    public Result<List<OrderQueryDTO>> ordersV6() {
        List<OrderQueryFlatDTO> dtoFlat = orderQueryRepository.findAllByDTO_flat();

        List<OrderQueryDTO> collect = dtoFlat.stream().collect(Collectors.groupingBy(OrderQueryDTO::fromOrderQueryFlatDTO,
                        Collectors.mapping(OrderItemQueryDTO::fromOrderQueryFlatDTO, Collectors.toList())
                )).entrySet().stream()
                .map(OrderQueryDTO::fromMapEntry).collect(Collectors.toList());
        return new Result<>(collect);
    }


}
