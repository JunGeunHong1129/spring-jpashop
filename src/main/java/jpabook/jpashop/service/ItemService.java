package jpabook.jpashop.service;

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

    public Item findItemById(Long id){
        return itemRepository.findItemById(id);
    }

}
