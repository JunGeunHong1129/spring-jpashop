package jpabook.jpashop.delivery.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jpabook.jpashop.common.vo.Address;
import jpabook.jpashop.delivery.vo.DeliveryStatus;
import jpabook.jpashop.order.command.domain.entity.Order;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Getter @Setter
public class Delivery {

    @Id @GeneratedValue
    @Column(name = "delivery_id")
    private Long id;

    @JsonIgnore
    @OneToOne(mappedBy = "delivery",fetch = FetchType.LAZY)
    private Order order;

    @Embedded
    private Address address;

    @Enumerated(EnumType.STRING)
    private DeliveryStatus deliveryStatus;

}
