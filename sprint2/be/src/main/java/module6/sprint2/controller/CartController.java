package module6.sprint2.controller;

import module6.sprint2.entity.book.Book;
import module6.sprint2.entity.cart.Cart;
import module6.sprint2.entity.cart.CartBook;
import module6.sprint2.service.ICartBookService;
import module6.sprint2.service.ICartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.List;

@RestController
@CrossOrigin
@RequestMapping("api/cart")
public class CartController {
    @Autowired
    ICartService cartService;

    @Autowired
    ICartBookService cartBookService;

//    @GetMapping("/list-cart")
//    public ResponseEntity<List<Cart>> findAllCart(@RequestParam("accountId") Long accountId) {
//        List<Cart> cartList = cartService.findAllCart(accountId);
//        if (cartList.isEmpty()) {
//            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
//        } else {
//            return new ResponseEntity<>(cartList, HttpStatus.OK);
//        }
//    }

    @GetMapping("/list-cart-book")
    public ResponseEntity<List<CartBook>> findAllCartBook(@RequestParam("accountId") Long accountId) {
        List<CartBook> cartBookList = cartBookService.findAllCartBook(accountId);
        if (cartBookList.isEmpty()) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        } else {
            return new ResponseEntity<>(cartBookList, HttpStatus.OK);
        }
    }

    @PutMapping("/update-quantity")
    public ResponseEntity<CartBook> updateQuantityCart(@RequestBody CartBook cartBook) {
        Double totalMoney = cartBook.getBookId().getBookPrice() * cartBook.getCartId().getCartQuantity()
                - cartBook.getBookId().getBookPrice() * cartBook.getCartId().getCartQuantity()
                * (cartBook.getBookId().getBookPromotionId().getPromotionPercent() / 100);
        cartBook.getCartId().setCartTotalMoney(totalMoney);
        cartService.updateQuantityCart(cartBook.getCartId().getCartQuantity(), cartBook.getCartId().getCartTotalMoney(), cartBook.getCartId().getCartId());
        return new ResponseEntity<>(cartBook, HttpStatus.CREATED);
    }

    @PutMapping("/add-book")
    public ResponseEntity<CartBook> updateQuantityCart(@RequestBody Book book) {

    }
}
