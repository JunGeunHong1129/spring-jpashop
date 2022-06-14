package jpabook.jpashop.domain.delivery.entity;

import jpabook.jpashop.common.vo.Address;
import jpabook.jpashop.domain.delivery.vo.DeliveryStatus;
import jpabook.jpashop.domain.order.entity.Order;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Getter @Setter
public class Delivery {

    @Id @GeneratedValue
    @Column(name = "delivery_id")
    private Long id;

    @OneToOne(mappedBy = "delivery",fetch = FetchType.LAZY)
    private Order order;

    @Embedded
    private Address address;

    @Enumerated(EnumType.STRING)
    private DeliveryStatus deliveryStatus;

}
