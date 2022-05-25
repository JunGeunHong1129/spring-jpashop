package jpabook.jpashop.domain.entity;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "orders")
@Getter @Setter
public class Order {

    @Id @GeneratedValue
    @Column(name="order_id")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "member_id")
    private Member member;

    @OneToMany(mappedBy = "order",fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    private List<OrderItem> orderItems = new ArrayList<>();

    @OneToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinColumn(name= "delivery_id")
    private Delivery delivery;

    private LocalDateTime orderDate;

    @Enumerated(EnumType.STRING)
    private OrderStatus orderStatus;

    /// 연관관계 메서드
    /// 연관관계를 맺을때 전용으로 서로에게 객체를 넣어주는 것이다.
    /// 까먹고 넣지 않는 휴먼에러를 방지 하기 위함으로 만들어주는것이 무조건 좋다.
    public void setMember (Member member){
        this.member=member;
        member.getOrders().add(this);
    }

    public void addOrderItem(OrderItem orderItem){
        orderItems.add(orderItem);
        orderItem.setOrder(this);
    }

    public void setDelivery(Delivery delivery){
        this.delivery = delivery;
        delivery.setOrder(this);
    }


    /// [생성 메서드]
    // 현재 주문 시스템이 단순해서 orderItem 리스트를 그냥 넘기지만
    // 실무에서는 DTO가 넘어오고 OrderItem을 직접 파싱해서 생성하는 등 많이 복잡해진다.
    public static Order createOrder(Member member, Delivery delivery, OrderItem... orderItems){

        Order order = new Order();
        order.setMember(member);
        order.setDelivery(delivery);
        for (OrderItem orderItem : orderItems) {
            order.addOrderItem(orderItem);
        }
        order.setOrderStatus(OrderStatus.ORDER);
        order.setOrderDate(LocalDateTime.now());

        return order;

    }
    /// [비즈니스 로직]
    // 주문 취소
    public void cancel(){
        if(delivery.getDeliveryStatus() == DeliveryStatus.COMP){
            throw new IllegalStateException("이미 배송완료된 상품은 취소가 불가능 합니다.");
        }
        this.setOrderStatus(OrderStatus.CANCEL);
        orderItems.forEach(
                (item)->{
                    item.cancel();
                }
        );
    }

    /// [조회 로직]
    /**
     * 전체 주문 가격 조회
     * @return int
     *  orderItems의 각 getOrderPrice를 sum한 결과
     */
    public int getTotalPrice(){
        return orderItems.stream().mapToInt(OrderItem::getOrderPrice).sum();
    }

}
