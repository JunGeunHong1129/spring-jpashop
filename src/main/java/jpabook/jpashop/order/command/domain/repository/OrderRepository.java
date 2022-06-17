package jpabook.jpashop.order.command.domain.repository;

import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.jpa.impl.JPAQueryFactory;
import jpabook.jpashop.member.entity.QMember;
import jpabook.jpashop.order.command.domain.dto.OrderSearchDTO;
import jpabook.jpashop.order.command.domain.entity.Order;
import jpabook.jpashop.order.command.domain.entity.QOrder;
import jpabook.jpashop.order.vo.OrderStatus;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.*;
import java.util.ArrayList;
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

    public List<Order> findAllByString(OrderSearchDTO orderSearch) {

        String jpql = "select o from Order o join o.member m";
        boolean isFirstCondition = true;

        //주문 상태 검색
        if (orderSearch.getOrderStatus() != null) {
            if (isFirstCondition) {
                jpql += " where";
                isFirstCondition = false;
            } else {
                jpql += " and";
            }
            jpql += " o.status = :status";
        }

        //회원 이름 검색
        if (StringUtils.hasText(orderSearch.getMemberName())) {
            if (isFirstCondition) {
                jpql += " where";
                isFirstCondition = false;
            } else {
                jpql += " and";
            }
            jpql += " m.name like :name";
        }

        TypedQuery<Order> query = em.createQuery(jpql, Order.class)
                .setMaxResults(1000);

        if (orderSearch.getOrderStatus() != null) {
            query = query.setParameter("status", orderSearch.getOrderStatus());
        }
        if (StringUtils.hasText(orderSearch.getMemberName())) {
            query = query.setParameter("name", orderSearch.getMemberName());
        }

        return query.getResultList();
    }

    /**
     * JPA Criteria
     */
    public List<Order> findAllByCriteria(OrderSearchDTO orderSearch) {
        CriteriaBuilder cb = em.getCriteriaBuilder();
        CriteriaQuery<Order> cq = cb.createQuery(Order.class);
        Root<Order> o = cq.from(Order.class);
        Join<Object, Object> m = o.join("member", JoinType.INNER);

        List<Predicate> criteria = new ArrayList<>();

        //주문 상태 검색
        if (orderSearch.getOrderStatus() != null) {
            Predicate status = cb.equal(o.get("status"), orderSearch.getOrderStatus());
            criteria.add(status);
        }
        //회원 이름 검색
        if (StringUtils.hasText(orderSearch.getMemberName())) {
            Predicate name =
                    cb.like(m.<String>get("name"), "%" + orderSearch.getMemberName() + "%");
            criteria.add(name);
        }

        cq.where(cb.and(criteria.toArray(new Predicate[criteria.size()])));
        TypedQuery<Order> query = em.createQuery(cq).setMaxResults(1000);
        return query.getResultList();
    }
    // 엔티티 자체를 fetch join으로 들고온다.
    public List<Order> findAllWithMemberDelivery(){
        return em.createQuery("select o from Order o " +
                "join fetch o.member m " +
                "join fetch o.delivery d", Order.class).getResultList();
    }

    /**
     * OneToMany 컬렉션을 가져와야하는 조회이다.
     *     이때 무조건 데이터 뻥튀기를 조심해야한다.
     *     그렇기 때문에 이 OneToMany를 join해서 들고올땐 항상 distinct로 중복 컬럼을 제거해줘야한다.
     *     근데 기본적으로 디비에선 distinct는 모든 컬럼이 일치해야 제거해준다.
     *     jpa에서 자체적으로 같은 아이디값인 Order를 날려주는 것이다.
     *
     *     주의 할점 !!!
     *
     *     컬렉션 패치 조인은 뻥튀기된 결과가 디비에 나오기 때문에
     *     jpa에 페이징 조건 쿼리를 추가하면 정확한 연산결과를
     *     뻥튀기된 결과를 들고 있는 디비단에서 알지 못해
     *     디비에 들어가는 쿼리단에 페이징 조건 쿼리가 들어가지 않는다!!!!!
     *     이때 jpa가 페이징을 온메모리에서 sorting해서 ordering을 해버리기 때문에
     *     쿼리 결과가 100000개이고 이 페이징을 처리하는 요청이 1000개이면
     *     요청이 들어오는 순간 Out Of Memory가 발생해버리기 십상이다.
     *
     * @return List<Order>
     */

    public List<Order> findAllWithItem(){
        return em.createQuery("select distinct o from Order o " +
                "join fetch o.member m " +
                "join fetch o.delivery d " +
                "join fetch o.orderItems oi " +
                "join fetch oi.item i", Order.class).getResultList();
    }

    // 엔티티 자체를 fetch join으로 들고온다.
    public List<Order> findAllWithMemberDeliveryLimit(int offset, int limit){
        return em.createQuery("select o from Order o " +
                "join fetch o.member m " +
                "join fetch o.delivery d", Order.class)
                .setFirstResult(offset)
                .setMaxResults(limit)
                .getResultList();
    }

    public List<Order> findAll(OrderSearchDTO orderSearchDTO){
        JPAQueryFactory query = new JPAQueryFactory(em);
        QOrder qOrder = QOrder.order;
        QMember qMember = QMember.member;

        return query.select(qOrder)
                .from(qOrder)
                .join(qOrder.member, qMember)
                .where(statusEq(orderSearchDTO.getOrderStatus()), memberNameLike(orderSearchDTO.getMemberName()))
                .limit(1000)
                .fetch();
    }

    private BooleanExpression memberNameLike(String memberName) {
        if(!StringUtils.hasText(memberName)){
            return null;
        }
        return QMember.member.name.like(memberName);
    }

    private BooleanExpression statusEq(OrderStatus status){
        if(status == null){
            return null;
        }
        return QOrder.order.orderStatus.eq(status);
    }

}
