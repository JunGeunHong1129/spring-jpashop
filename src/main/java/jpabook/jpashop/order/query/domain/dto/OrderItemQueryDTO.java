package jpabook.jpashop.order.query.domain.dto;

import jpabook.jpashop.order.command.domain.dto.OrderItemDTO;
import jpabook.jpashop.order.command.domain.entity.OrderItem;
import lombok.Data;

@Data
public class OrderItemQueryDTO {

    private Long orderId;
    private String itemName;
    private int orderPrice;
    private int count;

    private OrderItemQueryDTO() {
    }
    // 제대로 쓸려면 원래는 아래 로직을 위에 넣는게 맞긴함
    // 그냥 예제니까 안쓴거구
    // protected를 주로 쓰는 이유는 엔티티 영속화 때문인데 뭐 단순 DTO는 private 써도 상관없당
    // JPA가 리플랙션을 활용해 클래스를 읽어 들여서 프록시를 만드는데
    // 필수요소가 빈 생성자를 통해서 프록시를 생성하기 땜시롱
    // 무조건 빈 생성자가 필요해서 그런거다.
    // 그래서 private는 쓰지 않고 protected 빈생성자를 만들어 놓고
    // 외부에서 그냥 생성 못하게 막고 정적 팩토리 메서드를 이용하게 끔 만드는 것이다.
    public OrderItemQueryDTO(Long orderId, String itemName, int orderPrice, int count) {
        this.orderId=orderId;
        this.itemName = itemName;
        this.orderPrice = orderPrice;
        this.count = count;
    }

    public static OrderItemQueryDTO fromOrderItem(OrderItem orderItem) {
        return new OrderItemQueryDTO(
                orderItem.getOrder().getId(),
                orderItem.getItem().getName(),
                orderItem.getOrderPrice(),
                orderItem.getCount()
        );
    }

}
