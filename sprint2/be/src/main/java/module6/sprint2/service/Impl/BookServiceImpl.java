package module6.sprint2.service.Impl;

import module6.sprint2.entity.book.Book;
import module6.sprint2.repository.IBookRepository;
import module6.sprint2.service.IBookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BookServiceImpl implements IBookService {
    @Autowired
    IBookRepository bookRepository;


    @Override
    public List<Book> findAllBookIntro() {
        return bookRepository.findAllBookIntro();
    }

    @Override
    public List<Book> findAllBookBestSellerIntro() {
        return bookRepository.findAllBookBestSellerIntro();
    }

    @Override
    public List<Book> findAllBookBestSeller() {
        return bookRepository.findAllBookBestSeller();
    }
}
