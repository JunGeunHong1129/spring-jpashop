package jpabook.jpashop.order.query.domain.repository;

import jpabook.jpashop.order.command.domain.entity.OrderItem;
import jpabook.jpashop.order.query.domain.dto.OrderItemQueryDTO;
import jpabook.jpashop.order.query.domain.dto.OrderQueryDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import java.util.List;

@Repository
@RequiredArgsConstructor
public class OrderQueryRepository {

    private final EntityManager em;

    public List<OrderQueryDTO> findOrderQueryDTOs() {
        List<OrderQueryDTO> orderQueryDTOS = findOrders();
        orderQueryDTOS.forEach((o) -> {
            List<OrderItemQueryDTO> orderItems = findOrderItems(o.getOrderId());
            o.setOrderItems(orderItems);
        });
        return orderQueryDTOS;
    }

    private List<OrderItemQueryDTO> findOrderItems(Long orderId) {
        return em.createQuery("select new jpabook.jpashop.order.query.domain.dto.OrderItemQueryDTO(oi.order.id,i.name,oi.orderPrice,oi.count) " +
                "from OrderItem oi " +
                "join oi.item i " +
                "where oi.order.id = :orderId", OrderItemQueryDTO.class).setParameter("orderId", orderId).getResultList();
    }

    private List<OrderQueryDTO> findOrders() {
        return em.createQuery("select new jpabook.jpashop.order.query.domain.dto.OrderQueryDTO(o.id,m.name,o.orderDate,o.orderStatus,d.address) from Order o " +
                "join o.member m " +
                "join o.delivery d", OrderQueryDTO.class).getResultList();
    }

}
