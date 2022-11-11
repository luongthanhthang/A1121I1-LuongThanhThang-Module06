import { Component, OnInit } from '@angular/core';
import {BookService} from "../../service/book/book.service";
import {IBook} from "../../model/book/IBook";

@Component({
  selector: 'app-book-intro',
  templateUrl: './book-intro.component.html',
  styleUrls: ['./book-intro.component.css']
})
export class BookIntroComponent implements OnInit {
  bookIntroList: IBook[] = [];
  bookBestSellerSliderList: IBook[] = [];
  bookBestSeller: IBook[] = [];
  constructor(
    private bookService: BookService
  ) {
  }

  ngOnInit(): void {
    this.findAllBookIntro();
    this.findAllBookBestSellerIntro();
    this.findAllBookBestSeller();
    if (!localStorage.getItem('foo')) {
      localStorage.setItem('foo', 'no reload')
      location.reload()
    } else {
      localStorage.removeItem('foo')
    }
  }

  // +++++++++++++++lấy dữ liệu++++++++++++++++
  findAllBookIntro() {
    this.bookService.findAllBookIntro().subscribe((data: IBook[]) => {
      this.bookIntroList = data
      console.log(this.bookIntroList);
    });
  }

  findAllBookBestSellerIntro() {
    this.bookService.findAllBookBestSellerIntro().subscribe((data: IBook[]) => {
      this.bookBestSellerSliderList = data;
    });
  }

  findAllBookBestSeller() {
    this.bookService.findAllBookBestSeller().subscribe((data: IBook[]) => {
      this.bookBestSeller = data
    });
  }

}
