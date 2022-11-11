package module6.sprint2.controller;

import module6.sprint2.entity.book.Book;
import module6.sprint2.service.IAuthorService;
import module6.sprint2.service.IBookService;
import module6.sprint2.service.ICategoryService;
import module6.sprint2.service.IPromotionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@CrossOrigin
@RequestMapping("api/book")
public class BookController {
    @Autowired
    IBookService bookService;

    @Autowired
    IAuthorService authorService;

    @Autowired
    ICategoryService categoryService;

    @Autowired
    IPromotionService promotionService;

//    @PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_CUSTOMER')")
    @GetMapping("/book-customer/no-login/book-list-intro")
    public ResponseEntity<List<Book>> findAllBookIntro() {
        List<Book> bookList = bookService.findAllBookIntro();
        if (bookList.isEmpty()) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        } else {
            return new ResponseEntity<>(bookList, HttpStatus.OK);
        }
    }

    @GetMapping("/book-customer/no-login/book-list-best-seller-intro")
    public ResponseEntity<List<Book>> findAllBookBestSellerIntro() {
        List<Book> bookList = bookService.findAllBookBestSellerIntro();
        if (bookList.isEmpty()) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        } else {
            return new ResponseEntity<>(bookList, HttpStatus.OK);
        }
    }

    @GetMapping("/book-customer/no-login/book-list-best-seller")
    public ResponseEntity<List<Book>> findAllBookBestSeller() {
        List<Book> bookList = bookService.findAllBookBestSeller();
        if (bookList.isEmpty()) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        } else {
            return new ResponseEntity<>(bookList, HttpStatus.OK);
        }
    }

}
