package jpabook.jpashop.service;

import jpabook.jpashop.domain.entity.*;
import jpabook.jpashop.repository.ItemRepository;
import jpabook.jpashop.repository.MemberRepository;
import jpabook.jpashop.repository.OrderRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class OrderService {

    private final OrderRepository orderRepository;
    private final MemberRepository memberRepository;
    private final ItemRepository itemRepository;


    /**
     * 주문
     * @param memberId
     * @param itemId
     * @param count
     *      생성 메서드를 통해 생성한 주문 객체
     * @return Long
     *      생성한 Order의 Id
     */
    @Transactional
    public Long order(Long memberId, Long itemId, int count){

        // 엔티티 조회
        Member member = memberRepository.findMemberById(memberId);
        Item item = itemRepository.findItemById(itemId);

        // 배송정보 생성
        // 실제로는 파라미터로(DTO 등등) 엔드 유저가 직접 적은 배송지 정보를 받는게 맞다.
        Delivery delivery = new Delivery();
        delivery.setAddress(member.getAddress());

        // 주문 상품 생성
        // 단순한 프로젝트라 현재 단순하게 주문상품을 하나만 넘기고 있다.
        // 만약 뷰 자체를 여러개를 선택 가능하게 구현한다면 그렇게도 가능하다.
        /// TODO: 주문 여러개를 넘기도록 뷰와 함께 수정
        OrderItem orderItem = OrderItem.createOrderItem(item, item.getPrice(), count);
        Order order = Order.createOrder(member, delivery, orderItem);

        //주문 저장
        // cascade옵션 덕분에 배송정보, 주문상품 레포지터리 연결후 각각 영속화 하지 않고
        // 주문 영속화를 통해 한번에 영속화한다.
        // 이 cascade 옵션은 정확히 이 엔티티에서만 사용한다! 라는 조건이 있는 경우에만 사용해야하는 옵션이다.
        // 이것을 명심하자
        orderRepository.save(order);

        return order.getId();

    }

    /**
     * 주문 취소
     * @param orderId
     */
    @Transactional
    public void cancelOrder(Long orderId){
        // 주문 엔티티 조회
        Order order = orderRepository.findOrderById(orderId);

        // 주문 취소
        order.cancel();
    }

    // 검색
//    public List<Order> findOrderList(OrderSearch orderSearch){
//            return orderRepository.findOrderByOrderSearchDTO();
//    }

}