package jpabook.jpashop.order.query.domain.repository;

import jpabook.jpashop.order.command.domain.dto.OrderItemDTO;
import jpabook.jpashop.order.command.domain.entity.OrderItem;
import jpabook.jpashop.order.query.domain.dto.OrderItemQueryDTO;
import jpabook.jpashop.order.query.domain.dto.OrderQueryDTO;
import jpabook.jpashop.order.query.domain.dto.OrderQueryFlatDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

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

    // default_batch_fetch_size의 설정은 적용되지 않으니 주의해야한다.
    public List<OrderQueryDTO> findAllByDTO_optimization() {
        List<OrderQueryDTO> orders = findOrders();

        Map<Long, List<OrderItemQueryDTO>> orderItemMap = findOrderItemsMap(toOrderIds(orders));

        orders.forEach(o -> o.setOrderItems(orderItemMap.get(o.getOrderId())));

        return orders;

    }

    private Map<Long, List<OrderItemQueryDTO>>  findOrderItemsMap(List<Long> orderIdList) {
        List<OrderItemQueryDTO> orderIds = em.createQuery("select new jpabook.jpashop.order.query.domain.dto.OrderItemQueryDTO(oi.order.id,i.name,oi.orderPrice,oi.count) " +
                "from OrderItem oi " +
                "join oi.item i " +
                "where oi.order.id in :orderIds", OrderItemQueryDTO.class).setParameter("orderIds", orderIdList).getResultList();

        return orderIds.stream().collect(Collectors.groupingBy(OrderItemQueryDTO::getOrderId));
    }

    private List<Long> toOrderIds(List<OrderQueryDTO> orders) {
        List<Long> orderIdList = orders.stream().map(OrderQueryDTO::getOrderId).collect(Collectors.toList());
        return orderIdList;
    }

    public List<OrderQueryFlatDTO> findAllByDTO_flat() {
        return em.createQuery("select new " +
                "jpabook.jpashop.order.query.domain.dto.OrderQueryFlatDTO(o.id, m.name, o.orderDate, o.orderStatus, d.address, i.name, oi.orderPrice, oi.count)" +
                "from Order o " +
                "join o.member m " +
                "join o.delivery d " +
                "join o.orderItems oi " +
                "join oi.item i", OrderQueryFlatDTO.class).getResultList();
    }
}
