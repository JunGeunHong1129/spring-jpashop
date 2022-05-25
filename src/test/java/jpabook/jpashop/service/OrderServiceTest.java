package jpabook.jpashop.service;

import jpabook.jpashop.domain.entity.*;
import jpabook.jpashop.exception.NotEnoughStockException;
import jpabook.jpashop.repository.OrderRepository;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

//import javax.persistence.Entity;
import javax.persistence.EntityManager;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
@Transactional
class OrderServiceTest {

    @Autowired
    EntityManager em;

    @Autowired
    OrderService orderService;

    @Autowired
    OrderRepository orderRepository;


    @Test
    @DisplayName("상품주문")
    void itemOrder() throws Exception {
        //given
        Member member = createMemberData();

        Book book = createBookData("이펙티브 자바", 20000, 100);

        int orderCount = 20;

        //when
        Long orderId = orderService.order(member.getId(), book.getId(), orderCount);

        //then
        Order foundOrder = orderRepository.findOrderById(orderId);

        assertThat(foundOrder.getOrderStatus()).isEqualTo(OrderStatus.ORDER);
        assertThat(1).isEqualTo(foundOrder.getOrderItems().size());
        assertThat(20000*orderCount).isEqualTo(foundOrder.getTotalPrice());
        assertThat(80).isEqualTo(book.getStockQuantity());

    }

    @Test
    @DisplayName("주문취소")
    void orderCancel() throws Exception {
        //given
        Member member = createMemberData();
        Book book = createBookData("이펙티브 자바", 20000, 100);

        int orderCount = 20;

        Long orderId = orderService.order(member.getId(), book.getId(), orderCount);

        //when
        orderService.cancelOrder(orderId);

        //then

        Order foundOrder = orderRepository.findOrderById(orderId);

        assertThat(foundOrder.getOrderStatus()).isEqualTo(OrderStatus.CANCEL);
        assertThat(book.getStockQuantity()).isEqualTo(100);

    }

    @Test
    @DisplayName("상품주문_재고수량초과")
    void itemOrderWithStockOverFlow() throws Exception {
        //given
        Member member = createMemberData();

        Book book = createBookData("이펙티브 자바", 20000, 100);

        int orderCount = 200;
        //when

        assertThrows(NotEnoughStockException.class,()->{
            orderService.order(member.getId(), book.getId(), orderCount);
        });
        //then
//        fail("재고 수량 부족 예외 발생해야한다.");

    }

    private Book createBookData(String name, int price, int stockQuantity) {
        Book book = new Book();
        book.setName(name);
        book.setPrice(price);
        book.setStockQuantity(stockQuantity);
        em.persist(book);
        return book;
    }

    private Member createMemberData() {
        Member member = new Member();
        member.setName("홍준근");
        member.setAddress(new Address("서울시","도봉구","123-123"));
        em.persist(member);
        return member;
    }

}