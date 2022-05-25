package jpabook.jpashop.repository;

import jpabook.jpashop.domain.entity.Order;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import java.util.List;

@Repository
@RequiredArgsConstructor
public class OrderRepository {

    private final EntityManager em;

    public void save(Order order){
        em.persist(order);
    }

    public List<Order> findAllOrderList(){
        return em.createQuery("select o from Order o", Order.class).getResultList();
    }

    public Order findOrderById(Long orderId){
        return em.find(Order.class,orderId);
    }

//    public Order findOrderByOrderSearchDTO(OrderSeach orderSeach){
//
//    }

}
