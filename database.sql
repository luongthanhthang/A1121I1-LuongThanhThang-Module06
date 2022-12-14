create database `sprint1`;
use `sprint1`;
-- drop database sprint1;

create table if not exists `account` (
	account_id bigint primary key auto_increment,
    username varchar(20) unique not null,
    `password` varchar(255) not null,
    account_flag bit(1) default 0
);

create table if not exists `role` (
	role_id bigint primary key auto_increment,
    role_name varchar(30),
    role_flag bit(1) default 0
);

create table if not exists account_role (
	account_role_id bigint primary key auto_increment,				
	account_id bigint not null,				
	role_id bigint not null,				
    account_role_flag bit(1) default 0,
	foreign key (account_id) references `account`(account_id) on update cascade,				
	foreign key (role_id) references `role`(role_id) on update cascade	 			
);

create table if not exists customer_type (
	customer_type_id bigint primary key auto_increment,
    customer_type_name varchar(50) unique not null,
    customer_type_flag bit(1) default 0
);

create table if not exists material_type (
	material_type_id bigint primary key auto_increment,
    material_type_name varchar(20) unique not null,
    material_type_flag bit(1) default 0
);

create table if not exists `position` (
	position_id bigint primary key auto_increment,
    position_name varchar(50) unique not null,
    position_flag bit(1) default 0
);

create table if not exists customer(						
	customer_id bigint primary key auto_increment,						
	customer_name varchar(50) not null,						
	customer_code varchar(10) unique not null,						
	customer_avatar varchar(255),						
	customer_address varchar(255),						
	customer_phone varchar(20) unique,						
	customer_email varchar (50) unique not null,
    customer_flag bit(1) default 0,
	customer_type_id bigint not null,						
	foreign key (customer_type_id) references customer_type (customer_type_id) on update cascade						
);	

create table if not exists employee(
	employee_id bigint primary key auto_increment,
    employee_code varchar(20) unique not null,
    employee_name varchar(50) not null,
    employee_avatar varchar(255),
    employee_date_of_birth date,
    employee_gender varchar(20), 
    employee_address varchar(60),
    employee_phone varchar(20) unique,
    employee_salary double,
    employee_flag bit(1) default 0,
    employee_account_id bigint unique,
    employee_position_id bigint not null,
    foreign key (employee_account_id) references `account` (account_id) on update cascade,
    foreign key (employee_position_id) references position (position_id) on update cascade
);

create table if not exists salary (							
	salary_id bigint primary key auto_increment,					
	salary_advance_payment double default 0,
    salary_flag bit(1) default 0,
	salary_employee_id bigint not null,					
	foreign key(salary_employee_id) references employee(employee_id) on update cascade					
);

create table if not exists material (
	material_id bigint auto_increment primary key ,
	material_code varchar(20) unique not null,
	material_name varchar(50) not null,
	material_price double not null,
	material_quantity int default 0,
	material_expiridate date not null,
    material_image varchar(255),
	material_describe varchar(255),
    material_flag bit(1) default 0,
    material_unit varchar(20) not null,
	material_type_id bigint not null,
    material_customer_id bigint not null,
	foreign key (material_type_id) references material_type(material_type_id) on update cascade,
    foreign key (material_customer_id) references customer(customer_id) on update cascade
);

create table if not exists cart_status (
	cart_status_id bigint primary key auto_increment,	
    cart_status_name varchar(50),
	cart_status_flag bit(1) default 0
);

create table if not exists cart (					
	cart_id bigint primary key auto_increment,	
    cart_code varchar(20),
	cart_quantity int not null,					
	cart_total_money double not null,					
    cart_status_id bigint,
    cart_date_create date,
	cart_account_id bigint,					
	cart_customer_id bigint,
    foreign key (cart_status_id) references cart_status(cart_status_id) on update cascade,					
    foreign key (cart_customer_id) references customer(customer_id) on update cascade,					
	foreign key (cart_account_id) references `account`(account_id) on update cascade
);

create table if not exists cart_material (					
	cart_material_id bigint primary key auto_increment,					
	cart_id bigint not null,					
    cart_material_flag bit(1) default 0,
	material_id bigint not null,	
    cart_material_reason varchar(255),
	foreign key(cart_id) references cart(cart_id) on update cascade,					
	foreign key(material_id) references material(material_id) on update cascade					
);

create table if not exists `import` (
	import_id bigint primary key auto_increment, 
	import_code varchar(20) unique not null, 
	import_start_date date,
	import_quantity int,
    import_flag bit(1) default 0,
	import_account_id bigint not null,
	import_material_id bigint not null,
	foreign key (import_account_id) references `account` (account_id) on update cascade,
	foreign key (import_material_id) references material (material_id) on update cascade
);


INSERT INTO `account` (username, `password`) VALUES ('admin', '$2a$10$lqnvHKHPyKkZWMMtBB.jy.hMuPaSNH/Nlfuj6XaHCRLB7PK.EU60K'),
													('admin1', '$2a$10$PkK1zRmB8v/Ei4cD.nuTB.8FzdTLAXVTPcgYkLACrEy5jZsvehXn6');
									
                                                    
INSERT INTO `role` (role_name) VALUES ('ROLE_ADMIN'),
									  ('ROLE_ACCOUNTANT'),
									  ('ROLE_SELL');       
                                      
INSERT INTO account_role (account_id, role_id) VALUES ('1', '1'),
													  ('2', '1');
														
                                                      
INSERT INTO customer_type (customer_type_name) VALUES ('Kh??ch h??ng s???'),
												      ('Kh??ch h??ng l???'),
													  ('Nh?? cung c???p');     
                                                      
INSERT INTO material_type (material_type_name) VALUES ('B??ng'),
												 ('Kh???u trang');       
                                                 
INSERT INTO position (`position_name`) VALUES ('Qu???n l??'),
											  ('K??? to??n'),
											  ('B??n h??ng');        
        
        
       --  'https://firebasestorage.googleapis.com/v0/b/quan-ly-vat-tu-y-te.appspot.com/o/24-10-2022124706PM548708.png?alt=media&token=83458815-8478-45dc-baf5-adbd094d3ba8',
INSERT INTO customer (customer_name,customer_avatar, customer_code, customer_address, customer_phone, customer_email, customer_type_id) VALUES ('Nguy???n V??n A','https://firebasestorage.googleapis.com/v0/b/quan-ly-vat-tu-y-te.appspot.com/o/01-11-2022091620PM03e3d157873bfbbc852c018b3be5014f.jpg?alt=media&token=dace1f12-fb74-424f-ab2f-a1d3a759e5e6', 'MKH-001', '???? N???ng', '0905111111', 'NguyenVanA@gmail.com', '1'),
																																				('Nguy???n V??n B','https://firebasestorage.googleapis.com/v0/b/quan-ly-vat-tu-y-te.appspot.com/o/01-11-2022091704PM093eba58f1420c9a6475f619f93eac89.jpg?alt=media&token=c409d57a-abe4-4fcc-aac7-24040e5ebdfd', 'MKH-002', 'Qu???ng Nam', '0905222222', 'NguyenVanB@gmail.com', '1'),
																																				('Nguy???n V??n C','https://firebasestorage.googleapis.com/v0/b/quan-ly-vat-tu-y-te.appspot.com/o/01-11-2022091721PManh-anime-nam-29.jpg?alt=media&token=ac03b8e0-c479-46ac-8dd6-49a97faba188', 'MKH-003', '???? N???ng', '0905333333', 'NguyenVanC@gmail.com', '2'),
																																				('Nguy???n V??n D', 'https://firebasestorage.googleapis.com/v0/b/quan-ly-vat-tu-y-te.appspot.com/o/01-11-2022091826PMAnh-avatar-chibi-nam-deo-kinh.jpg?alt=media&token=6a72d6ef-b737-480b-99d2-e307252dec27','MKH-04', 'Qu???ng Nam', '0905444444', 'NguyenVanD@gmail.com', '2'),
																																				('Nguy???n V??n E','https://firebasestorage.googleapis.com/v0/b/quan-ly-vat-tu-y-te.appspot.com/o/01-11-2022091849PManh-avatar-cute-dep-nhat-5.jpg?alt=media&token=8f9c7454-09e8-4cd4-9edf-63aa34ae314d', 'MKH-005', '???? N???ng', '0905555555', 'NguyenVanE@gmail.com', '2'),
																																				('Nguy???n V??n F','https://firebasestorage.googleapis.com/v0/b/quan-ly-vat-tu-y-te.appspot.com/o/01-11-2022091906PManh-avatar-cute-nam-1.jpg?alt=media&token=aef90ef7-0156-43ab-93ee-d1d7cc2513a4', 'MKH-006', 'Hu???', '0905666666', 'NguyenVanF@gmail.com', '2'),
																																				('C??ng ty Lan Anh','https://firebasestorage.googleapis.com/v0/b/quan-ly-vat-tu-y-te.appspot.com/o/01-11-2022091954PMavt-cap-doi-1.jpg?alt=media&token=4b5c6c0f-0dbd-4d04-948a-c791c0a34ad7', 'MKH-007', '???? N???ng', '0905777777', 'CongTyLanAnh@gmail.com', '3'),
																																				('C??ng ty H???i D????ng','https://firebasestorage.googleapis.com/v0/b/quan-ly-vat-tu-y-te.appspot.com/o/01-11-2022092026PMf01ac0a2d04bbc96aea2d79d28587573.jpg?alt=media&token=0ae3f312-5d24-4ec0-ab8e-32678ac408be', 'MKH-008', 'Hu???', '0905888888', 'CongTyHaiDuong@gmail.com', '3'),
																																				('C??ng ty Vi???t Huy','https://firebasestorage.googleapis.com/v0/b/quan-ly-vat-tu-y-te.appspot.com/o/01-11-2022092044PMhinh-avatar-nam-deo-kinh.jpg?alt=media&token=2f6c8f09-df66-47f1-9cf0-93a1ab9a6375', 'MKH-009', '???? N???ng', '0905999999', 'CongTyVietHuy@gmail.com', '3'),
																																				('C??ng ty Thanh Th???ng',null, 'MKH-010', 'Hu???', '0905000000', 'CongTyThanhThang@gmail.com', '3');
                                                                                                                                                                          
INSERT INTO employee (employee_code,employee_avatar, employee_name, employee_date_of_birth, employee_gender, employee_address, employee_phone, employee_salary, employee_account_id, employee_position_id) VALUES ('MNV-001','https://cdn.chanhtuoi.com/uploads/2022/01/hinh-avatar-nam-deo-kinh.jpg', 'L?? V??n A', '1990-01-01', 'Nam', 'Qu???ng Nam', '0383111111', '1000', '1', '1'),
																																																  ('MNV-002',null, 'L?? V??n B', '1991-02-02', 'N???', '???? N???ng', '0383222222', '5000', '2', '1');
																																																				--    ('MNV-003', 'L?? V??n C',  '1992-03-03', 'Kh??c', 'Qu???ng Nam', '0983333333', '3000', '3', '2'),
-- 																																																				   ('MNV-004', 'L?? V??n D',  '1993-04-04', 'Nam', '???? N???ng', '0983444444', '4000', '4', '2'),
-- 																																																				   ('MNV-005', 'L?? V??n E', '1994-05-05', 'N???', 'Qu???ng Nam', '0983555555', '6000', '5', '2'),
-- 																																																				   ('MNV-006', 'L?? V??n F', '1995-06-06', 'Kh??c', '???? N???ng', '0983666666', '7000', '6', '2'),
-- 																																																				   ('MNV-007', 'L?? V??n G',  '1996-07-07', 'Nam', 'Hu???', '0983777777', '9000', '7', '3'),
-- 																																																				   ('MNV-008', 'L?? V??n H', '1997-08-08', 'N???', '???? N???ng', '0983888888', '10000', '8', '3'),
-- 																																																				   ('MNV-009', 'L?? V??n I', '1998-09-09', 'Kh??c', 'Hu???', '0983999999', '500', '9', '3'),
-- 																																																				   ('MNV-010', 'L?? V??n J', '1999-10-10', 'Nam', '???? N???ng', '0983000000', '8500', '10', '3');
                                                                                                                                                                                                                   
INSERT INTO salary (salary_advance_payment, salary_employee_id) VALUES ('300', '1'),
																	   ('500', '2');
																	
                                                                       
                                                                       
INSERT INTO `material` (`material_code`, `material_name`, `material_price`, `material_expiridate`, `material_describe`, `material_unit`, `material_type_id`, `material_customer_id`) VALUES ('MVT-001', 'b??ng A', '5000', '2022-01-01',  'describe1', 'g??i', '1', '7')
 ,('MVT-002', 'b??ng B', '4000', '2022-02-02',  'describe2', 'g??i', '1', '8')
 ,('MVT-003', 'b??ng C', '3000', '2022-03-03', 'describe3', 'g??i', '1', '9')
 ,('MVT-004', 'b??ng D', '2000', '2022-04-04', 'describe4', 'g??i', '1', '10')
 ,('MVT-005', 'b??ng E', '1000', '2022-05-05', 'describe5', 'g??i', '1', '7')
 ,('MVT-006', 'kh???u trang A', '5000', '2022-06-06', 'describe6', 'h???p', '2', '8')
 ,('MVT-007', 'kh???u trang B', '4000', '2022-07-07', 'describe7', 'h???p', '2', '9')
 ,('MVT-008', 'kh???u trang C', '3000', '2022-08-08', 'describe8', 'h???p', '2', '10')
 ,('MVT-009', 'kh???u trang D', '2000', '2022-09-09',  'describe9', 'h???p', '2', '7')
 ,('MVT-010', 'kh???u trang E', '1000', '2022-10-10', 'describe10', 'h???p', '2', '8');

INSERT INTO `cart_status` (`cart_status_name`) VALUES ('ch??a thanh to??n')
,('???? thanh to??n')
,('Tr??? h??ng')
,('Hu??? h??ng');																
                                                                                           
INSERT INTO `cart` (`cart_code`, `cart_date_create`, `cart_quantity`, `cart_status_id`, `cart_total_money`, `cart_account_id`, `cart_customer_id`) VALUES ('HDX-001','2022-01-01', '1', '1', '1000', '1', '1')
 ,('HDX-002', '2022-02-02', '2', '2', '2000', '2', '2')
 ,('HDX-003', '2022-03-03', '3', '3', '3000', '1', '3')
 ,('HDX-004', '2022-04-04', '4', '4', '4000', '2', '4')
 ,('HDX-005', '2022-05-05', '5', '4', '5000', '1', '5');
INSERT INTO `cart` (`cart_code`, `cart_date_create`, `cart_quantity`, `cart_status_id`, `cart_total_money`, `cart_customer_id`) VALUES ('HDB-001', '2022-08-08', '5', '4', '5000', '6')
,('HDB-002', '2022-06-06', '4', '4', '4000', '1')
,('HDB-003', '2022-06-06', '3', '3', '3000', '2')
,('HDB-004', '2022-07-07', '2', '2', '2000', '3')
,('HDB-005', '2022-08-08', '1', '1', '1000', '4');
																						

                                                                                           
INSERT INTO cart_material (cart_id, material_id) VALUES ('1', '1'),
														('2', '2'),
														('3', '3'),
														('4', '4'),
														('5', '5'),
														('6', '1'),
														('7', '2'),
														('8', '3'),
														('9', '4'),
														('10', '5');  
                                                        
INSERT INTO `import` (import_code, import_start_date, import_quantity, import_account_id, import_material_id) VALUES ('HDN-001', '2022-01-01', '5', '1', '1'),
																													  ('HDN-002', '2022-02-02', '4', '2', '2'),
																													  ('HDN-003', '2022-03-03', '3', '1', '3'),
																													  ('HDN-004', '2022-04-04', '2', '2', '4'),
																													  ('HDN-005', '2022-05-05', '1', '1', '5'),
																													  ('HDN-006', '2022-06-06', '1', '2', '6'),
																													  ('HDN-007', '2022-07-07', '2', '1', '7'),
																													  ('HDN-008', '2022-08-08', '3', '2', '8'),
																													  ('HDN-009', '2022-09-09', '4', '1', '9'),
																													  ('HDN-010', '2022-10-10', '5', '2', '10');
                                                                                                                      
UPDATE `sprint1`.`cart` SET `cart_quantity` = '1', `cart_total_money` = '4000' WHERE (`cart_id` = '2');
UPDATE `sprint1`.`cart` SET `cart_quantity` = '1' WHERE (`cart_id` = '3');
UPDATE `sprint1`.`cart` SET `cart_quantity` = '1', `cart_total_money` = '2000' WHERE (`cart_id` = '4');
UPDATE `sprint1`.`cart` SET `cart_quantity` = '4', `cart_total_money` = '4000' WHERE (`cart_id` = '5');
UPDATE `sprint1`.`cart` SET `cart_quantity` = '1' WHERE (`cart_id` = '6');
UPDATE `sprint1`.`cart` SET `cart_quantity` = '1' WHERE (`cart_id` = '7');
UPDATE `sprint1`.`cart` SET `cart_quantity` = '6', `cart_total_money` = '18000' WHERE (`cart_id` = '8');
UPDATE `sprint1`.`cart` SET `cart_quantity` = '1' WHERE (`cart_id` = '9');
UPDATE `sprint1`.`cart` SET `cart_quantity` = '3', `cart_total_money` = '15000' WHERE (`cart_id` = '1');
UPDATE `sprint1`.`cart` SET `cart_quantity` = '3', `cart_total_money` = '3000' WHERE (`cart_id` = '10');
                 
UPDATE `sprint1`.`material` SET `material_name` = 'Kh???u trang 3 & 4 l???p', `material_image` = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3LDJShID36jTagclzdMmTxECuCpHV1Xq8dw&usqp=CAU,@ https://bom.so/8CaTr9,@ https://bom.so/tax5XZ', `material_describe` = 'Thanh n???p m??i:  Nh???a PE,@D??y ??eo tai: Polyester and Spandex,@Ki???u d??y ??eo: V???i d???t kim c?? t??nh ????n h???i,@Kh???u trang l?? m???t lo???i m???t n??? b???o v??? ???????c s??? d???ng ????? b???t v??ng m???t (th?????ng l?? m??i, mi???ng) ????? b???o v??? ng?????i ??eo kh???i b??? l??y nhi???m c??c lo???i vi khu???n' WHERE (`material_id` = '3');
UPDATE `sprint1`.`material` SET `material_name` = 'M??y t???o Oxy DEDAKJ DE-2A 2-9 l??t', `material_image` = 'https://vattuytesaigon.vn/wp-content/uploads/2022/04/de-2a-768x768.jpg', `material_describe` = 'T???o 9 l??t oxy nguy??n ch???t trong v??ng 1 ph??t,@T???o h??m l?????ng ion ??m ?????t 6 tri???u/cm3,@H???n gi??? c?? th??? l??n t???i 180 ph??t,@T??ch h???p qu???t l??m m??t v???i ????? ???n th???p t???i ??u, nh??? nh??ng, tho???i m??i.Ti???t ki???m ??i???n t???t, ?????t t???i 22% so v???i c??c s???n ph???m t????ng t??? kh??c' WHERE (`material_id` = '4');
UPDATE `sprint1`.`material` SET `material_name` = 'M??y t???o oxy 5 l??t 93%', `material_image` = 'https://vattuytesaigon.vn/wp-content/uploads/2021/12/longfian0-768x768.jpg', `material_describe` = 'M??y t???o oxy 5 l??t n???ng ????? oxy ?????t t??? 93 - 96%,@C?? th??? d??ng cho 2 ng?????i c??ng l??c,@Tu???i th??? m??y n??n l??n t???i 25000 gi???,@M??y t???o oxy JAY-B5W t??? th????ng hi???u LONGFIAN ??? chuy??n gia s???n xu???t m??y t???o oxy v?? thi???t b??? y t??? c?? kinh nghi???m trong nhi???u n??m li???n' WHERE (`material_id` = '5');
UPDATE `sprint1`.`material` SET `material_name` = 'Gi?????ng b???nh vi???n 1 tay quay ZC02', `material_image` = 'https://vattuytesaigon.vn/wp-content/uploads/2021/08/1-tay-600x600-1.jpg', `material_describe` = '?????u v?? ch??n gi?????ng l?? b???ng nh???a ABS,@Th??nh gi?????ng b???ng h???p kim nh??m, 5 thanh ch???n d???c,@B??nh xe ???????ng k??nh 5??? (125mm) c?? kho?? an to??n ?????c l???p,@Gi?????ng b???nh vi???n 1 tay quay ???????c l??m t??? c??c ch???t li???u an to??n v?? ch???c ch???n, t??ch h???p kho?? an to??n ??? c??c kh???p' WHERE (`material_id` = '6');
UPDATE `sprint1`.`material` SET `material_name` = 'M??y t???o oxy 5 l??t 93%', `material_image` = 'https://vattuytesaigon.vn/wp-content/uploads/2021/12/longfian0-768x768.jpg', `material_describe` = 'M??y t???o oxy 5 l??t n???ng ????? oxy ?????t t??? 93 - 96%,@C?? th??? d??ng cho 2 ng?????i c??ng l??c,@Tu???i th??? m??y n??n l??n t???i 25000 gi???,@M??y t???o oxy JAY-B5W t??? th????ng hi???u LONGFIAN ??? chuy??n gia s???n xu???t m??y t???o oxy v?? thi???t b??? y t??? c?? kinh nghi???m trong nhi???u n??m li???n' WHERE (`material_id` = '7');
UPDATE `sprint1`.`material` SET `material_name` = 'Gi?????ng b???nh vi???n 1 tay quay ZC02', `material_image` = 'https://vattuytesaigon.vn/wp-content/uploads/2021/08/1-tay-600x600-1.jpg', `material_describe` = '?????u v?? ch??n gi?????ng l?? b???ng nh???a ABS,@Th??nh gi?????ng b???ng h???p kim nh??m, 5 thanh ch???n d???c,@B??nh xe ???????ng k??nh 5??? (125mm) c?? kho?? an to??n ?????c l???p,@Gi?????ng b???nh vi???n 1 tay quay ???????c l??m t??? c??c ch???t li???u an to??n v?? ch???c ch???n, t??ch h???p kho?? an to??n ??? c??c kh???p' WHERE (`material_id` = '8');
UPDATE `sprint1`.`material` SET `material_name` = 'M??y t???o oxy 5 l??t 93%', `material_image` = 'https://vattuytesaigon.vn/wp-content/uploads/2021/12/longfian0-768x768.jpg', `material_describe` = 'M??y t???o oxy 5 l??t n???ng ????? oxy ?????t t??? 93 - 96%,@C?? th??? d??ng cho 2 ng?????i c??ng l??c,@Tu???i th??? m??y n??n l??n t???i 25000 gi???,@M??y t???o oxy JAY-B5W t??? th????ng hi???u LONGFIAN ??? chuy??n gia s???n xu???t m??y t???o oxy v?? thi???t b??? y t??? c?? kinh nghi???m trong nhi???u n??m li???n' WHERE (`material_id` = '9');
UPDATE `sprint1`.`material` SET `material_name` = 'M??y t???o Oxy DEDAKJ DE-2A 2-9 l??t', `material_image` = 'https://vattuytesaigon.vn/wp-content/uploads/2022/04/de-2a-768x768.jpg', `material_describe` = 'T???o 9 l??t oxy nguy??n ch???t trong v??ng 1 ph??t,@T???o h??m l?????ng ion ??m ?????t 6 tri???u/cm3,@H???n gi??? c?? th??? l??n t???i 180 ph??t,@T??ch h???p qu???t l??m m??t v???i ????? ???n th???p t???i ??u, nh??? nh??ng, tho???i m??i.Ti???t ki???m ??i???n t???t, ?????t t???i 22% so v???i c??c s???n ph???m t????ng t??? kh??c' WHERE (`material_id` = '10');

UPDATE `sprint1`.`employee` SET `employee_avatar` = 'https://cdn.chanhtuoi.com/uploads/2022/01/hinh-avatar-nam-deo-kinh.jpg' WHERE (`employee_id` = '1');