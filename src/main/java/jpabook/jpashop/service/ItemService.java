package jpabook.jpashop.service;

import jpabook.jpashop.domain.entity.Book;
import jpabook.jpashop.domain.entity.Item;
import jpabook.jpashop.repository.ItemRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class ItemService {

    private final ItemRepository itemRepository;

    @Transactional
    public void addItem(Item item){
        itemRepository.save(item);
    }

    public List<Item> findItemList(){
        return itemRepository.findAllItem();
    }

    /// 일반적으로 업데이트 같은 경우는 이렇게 해주는것이 정상이다.
    /// merge는 모든 필드를 다 갈아 끼움으로 널이 들어갈 가능성이 매우 높다.
    /// 이를 방지해주기 위해서 보통은 이렇게 트랜잭션이 걸려있는 서비스 계층에서
    //  find로 영속화한 객체를 들고와 여기서 더티 채킹으로 원하는 필드만 바꿔서
    //  업데이트 하도록 만드는 것이 맞다.
    /// 현재 예제에서는 병합과 변경감지의 예시를 보여주기 위해 나눠서 보여준 것이다.
    //  주의하자!
    @Transactional
    public void updateItem(Long itemId, Book itemForm){

        Book item = (Book) itemRepository.findItemById(itemId);
        item.setPrice(itemForm.getPrice());
        itemRepository.save(item);
    }

    public Item findItemById(Long id){
        return itemRepository.findItemById(id);
    }

}
