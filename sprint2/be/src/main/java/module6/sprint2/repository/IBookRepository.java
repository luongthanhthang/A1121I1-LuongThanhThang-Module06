package module6.sprint2.repository;

import module6.sprint2.entity.book.Book;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional
public interface IBookRepository extends JpaRepository<Book, Long> {
    @Query(value = "select * from book where book_flag = 0 limit 6", nativeQuery = true)
    List<Book> findAllBookIntro();

    @Query(value = "select book.* from book\n" +
            "join cart_book on book.book_id = cart_book.book_id\n" +
            "join cart on cart.cart_id = cart_book.cart_id\n" +
            "group by cart_book.book_id \n" +
            "having sum(cart.cart_quantity) is not null and book.book_flag = 0\n" +
            "order by sum(cart.cart_quantity) desc limit 3;", nativeQuery = true)
    List<Book> findAllBookBestSellerIntro();

    @Query(value = "select book.* from book\n" +
            "join cart_book on book.book_id = cart_book.book_id\n" +
            "join cart on cart.cart_id = cart_book.cart_id\n" +
            "group by cart_book.book_id \n" +
            "having sum(cart.cart_quantity) is not null and book.book_flag = 0\n" +
            "order by sum(cart.cart_quantity) desc;", nativeQuery = true)
    List<Book> findAllBookBestSeller();
}
