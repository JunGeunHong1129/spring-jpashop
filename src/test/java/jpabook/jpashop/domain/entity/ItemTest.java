package jpabook.jpashop.domain.entity;

import jpabook.jpashop.item.entity.Book;
import jpabook.jpashop.common.exception.NotEnoughStockException;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class ItemTest {

    @Test
    @DisplayName("재고 삭제 예외 단위 테스트")
    void removeStock() {

        //given
        Book book = createBookData("이펙티브 자바", 20000, 100);
        int quantityVolume = 200;

        //when
        assertThrows(NotEnoughStockException.class, ()-> {
            book.removeStock(quantityVolume);
        });

        //than
//        fail("재고 수량 부족 예외 발생해야함");

    }

    private Book createBookData(String name, int price, int stockQuantity) {
        Book book = new Book();
        book.setName(name);
        book.setPrice(price);
        book.setStockQuantity(stockQuantity);
        return book;
    }
}