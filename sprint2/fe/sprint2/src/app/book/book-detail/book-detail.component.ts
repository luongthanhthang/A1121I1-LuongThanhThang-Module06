import {Component, OnInit} from '@angular/core';
import {BookService} from '../../service/book.service';
import {ActivatedRoute, Router} from '@angular/router';
import {IBook} from '../../model/book/IBook';
import {TokenStorageService} from '../../service/security/token-storage.service';

@Component({
  selector: 'app-book-detail',
  templateUrl: './book-detail.component.html',
  styleUrls: ['./book-detail.component.css']
})
export class BookDetailComponent implements OnInit {
  id: number;
  bookById: IBook = null;
  slideConfig = {slidesToShow: 4, slidesToScroll: 4};
  bookAuthorList: IBook[] = [];
  pageBookAuthorList = 0;

  private roles: string[];
  isLoggedIn = false;
  showAdminBoard = false;
  showCustomer = false;
  userName: string;


  constructor(
    private tokenStorageService: TokenStorageService,
    private bookService: BookService,
    private router: Router,
    private activatedRoute: ActivatedRoute
  ) {
  }

  ngOnInit(): void {
    this.topFunction();

    if (!localStorage.getItem('foo')) {
      localStorage.setItem('foo', 'no reload');
      location.reload();
    } else {
      localStorage.removeItem('foo');
    }

    this.activatedRoute.paramMap.subscribe((param) => {
      this.id = +(param.get('id'));
    }, () => {
    }, () => {
    });

    // kiểm tra đăng nhập
    this.isLoggedIn = !!this.tokenStorageService.getToken();
    if (this.isLoggedIn) {
      this.userName = this.tokenStorageService.getUser().account.username;
      this.roles = this.tokenStorageService.getUser().account.roles[0].roleName;
      // kiểm tra role
      this.showAdminBoard = this.roles.includes('ROLE_ADMIN');
      this.showCustomer = this.roles.includes('ROLE_CUSTOMER');

      console.log('roles: ' + this.roles);
    }

    this.findAllBookAuthor();
  }

  findAllBookAuthor() {
    this.bookService.findBookById(this.id).subscribe((data: IBook) => {
      this.bookById = data;
    }, () => {
    }, () => {
      this.bookService.findAllBookAuthor(this.bookById.bookAuthorId.authorId, this.id).subscribe((data: IBook[]) => {
        this.bookAuthorList = data;
        console.log(this.bookAuthorList);
      }, (error) => {
        console.log(error);
      });
    });
  }

  backBookIntro() {
    if (this.pageBookAuthorList >= 4) {
      this.pageBookAuthorList -= 4;
      return this.pageBookAuthorList;
    } else {
      this.pageBookAuthorList = 0;
      return 0;
    }
  }

  nextBookIntro() {
    if (this.pageBookAuthorList > this.bookAuthorList.length) {
      this.pageBookAuthorList = 0;
      return 0;
    }
    this.pageBookAuthorList += 4;
    return this.pageBookAuthorList;
  }

  topFunction() {
    document.body.scrollTop = 0;
    document.documentElement.scrollTop = 200;
  }
}
