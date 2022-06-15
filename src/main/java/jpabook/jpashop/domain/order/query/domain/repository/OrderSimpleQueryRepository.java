package jpabook.jpashop.domain.order.query.domain.repository;

import jpabook.jpashop.domain.order.query.domain.dto.SimpleOrderDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import java.util.List;

@Repository
@RequiredArgsConstructor
public class OrderSimpleQueryRepository {

    private final EntityManager em;

    // new 연산자로 DTO를 바로 생성해서 반환한다.
    // 이 방식은 네트워크상의 이점을 들고 가는 이점은 있지만 사실 text 몇백줄 정도는 네트워크를 얼마 먹지도 않는다. 그래서 해봐야 미비한 수준이다.
    // 단점으로는 1) 논리적인 네트워크 계층이 깨진다. 2) DTO에 딱 맞춰지기 때문에 재사용성이 확 떨어진다.
    // 게다가, 이 DTO를 사용하는 클라이언트에서의 스펙변경이 일어나면 리포지터리를 뜯어 고쳐야하는 상황이 오기 때문에
    // TPS, 초당 동시 요청 수, 네트워크 상태등등을 따져 서비스의 전체적인 퀄리티에 문제가 존재 하겠다는 가능성이 매우 커서
    // 얘라도 좀 손봐야겠다 싶으면 그때 도입해야하는 방식이다.
    public List<SimpleOrderDTO> findOrderDTOs(){
        return em.createQuery("select new jpabook.jpashop.domain.order.query.domain.dto.SimpleOrderDTO(o.id,o.orderDate,m.name,o.orderStatus,d.address) " +
                "from Order o " +
                "join o.member m " +
                "join o.delivery d", SimpleOrderDTO.class).getResultList();
    }

}
