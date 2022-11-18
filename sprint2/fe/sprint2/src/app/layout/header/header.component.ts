import {Component, OnInit} from '@angular/core';
import {TokenStorageService} from '../../service/security/token-storage.service';
import {Router} from '@angular/router';
import {BookService} from '../../service/book.service';
import {IBook} from '../../model/book/IBook';
import {ICategory} from '../../model/book/ICategory';

@Component({
  selector: 'app-header',
  templateUrl: './header.component.html',
  styleUrls: ['./header.component.css']
})
export class HeaderComponent implements OnInit {

  private roles: string[];
  isLoggedIn = false;
  showAdminBoard = false;
  showCustomer = false;
  userName: string;

  categoryList: ICategory[] = [];

  constructor(private tokenStorageService: TokenStorageService,
              private router: Router,
              private bookService: BookService) {
  }

  ngOnInit(): void {
    this.findAllCategory();
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
  }

  logout() {
    this.tokenStorageService.signOut();
    window.location.assign('');
    this.router.navigateByUrl('');
  }

  // =======lấy dữ liệu===========
  findAllCategory() {
    this.bookService.findAllCategory().subscribe((data: ICategory[]) => {
      this.categoryList = data;
    });
  }
}
