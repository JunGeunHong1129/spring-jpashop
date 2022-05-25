package jpabook.jpashop.domain.entity;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Table(name = "order_item")
@Getter @Setter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class OrderItem {

    @Id @GeneratedValue
    @Column(name="order_item_id")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "item_id")
    private Item item;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "order_id")
    private Order order;

    private int orderPrice;
    private int count;

    /// [생성 메서드]
    // item에 따로 가격을 넣어도 되지 않나 싶지만
    // 추후 할인, 행사, 프로모션등의 비즈니스 도메인 변경 가능성이 충분하기 때문에
    // orderPrice, count를 직접 여기서 넣어줘야 한다.
    // item에는 상품의 원래 정가가 매핑되있어야한다.
    public static OrderItem createOrderItem(Item item, int orderPrice, int count){
        OrderItem orderItem = new OrderItem();
        orderItem.setItem(item);
        orderItem.setOrderPrice(orderPrice);
        orderItem.setCount(count);

        /// 주문 상품의 재고 개수 만큼 재고량을 까줘야한다.
        item.removeStock(count);
        return orderItem;
    }

    /// [비즈니스 로직]
    // 주문 취소
    public void cancel(){
        getItem().addStock(count);
    }

    /// [조회 로직]
    /**
     * 총 OrderPrice
     * @return int
     *  getOrderPrice() * getCount() 결과값이 리턴된다.
     */
    public int getOrderPrice(){
        return getOrderPrice() * getCount();
    }

}
