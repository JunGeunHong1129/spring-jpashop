package jpabook.jpashop.item.repository;

import jpabook.jpashop.item.entity.Item;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import java.util.List;

@Repository
@RequiredArgsConstructor
public class ItemRepository {

    private final EntityManager em;

    public void save(Item item){
        if(item.getId() == null){
            // 널인 경우엔 영속성 컨텍스트에 아예 없는 객체이기 때문에 새로 영속화한다.
            em.persist(item);
        }else{
            // 널이 아닌 경우엔 영속성 컨텍스트에 이미 영속화된 객체이기 때문에 update처럼 동작시켜준다.
            em.merge(item);
        }
    }

    public Item findItemById(Long itemId){
        return em.find(Item.class, itemId);
    }

    /// TODO: paging 필요함
    public List<Item> findAllItem(){
        return em.createQuery("select i from Item i", Item.class).getResultList();
    }





}
