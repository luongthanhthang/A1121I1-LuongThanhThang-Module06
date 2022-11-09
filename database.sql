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
														
                                                      
INSERT INTO customer_type (customer_type_name) VALUES ('Khách hàng sỉ'),
												      ('Khách hàng lẻ'),
													  ('Nhà cung cấp');     
                                                      
INSERT INTO material_type (material_type_name) VALUES ('Bông'),
												 ('Khẩu trang');       
                                                 
INSERT INTO position (`position_name`) VALUES ('Quản lý'),
											  ('Kế toán'),
											  ('Bán hàng');        
        
        
       --  'https://firebasestorage.googleapis.com/v0/b/quan-ly-vat-tu-y-te.appspot.com/o/24-10-2022124706PM548708.png?alt=media&token=83458815-8478-45dc-baf5-adbd094d3ba8',
INSERT INTO customer (customer_name,customer_avatar, customer_code, customer_address, customer_phone, customer_email, customer_type_id) VALUES ('Nguyễn Văn A','https://firebasestorage.googleapis.com/v0/b/quan-ly-vat-tu-y-te.appspot.com/o/01-11-2022091620PM03e3d157873bfbbc852c018b3be5014f.jpg?alt=media&token=dace1f12-fb74-424f-ab2f-a1d3a759e5e6', 'MKH-001', 'Đà Nẵng', '0905111111', 'NguyenVanA@gmail.com', '1'),
																																				('Nguyễn Văn B','https://firebasestorage.googleapis.com/v0/b/quan-ly-vat-tu-y-te.appspot.com/o/01-11-2022091704PM093eba58f1420c9a6475f619f93eac89.jpg?alt=media&token=c409d57a-abe4-4fcc-aac7-24040e5ebdfd', 'MKH-002', 'Quảng Nam', '0905222222', 'NguyenVanB@gmail.com', '1'),
																																				('Nguyễn Văn C','https://firebasestorage.googleapis.com/v0/b/quan-ly-vat-tu-y-te.appspot.com/o/01-11-2022091721PManh-anime-nam-29.jpg?alt=media&token=ac03b8e0-c479-46ac-8dd6-49a97faba188', 'MKH-003', 'Đà Nẵng', '0905333333', 'NguyenVanC@gmail.com', '2'),
																																				('Nguyễn Văn D', 'https://firebasestorage.googleapis.com/v0/b/quan-ly-vat-tu-y-te.appspot.com/o/01-11-2022091826PMAnh-avatar-chibi-nam-deo-kinh.jpg?alt=media&token=6a72d6ef-b737-480b-99d2-e307252dec27','MKH-04', 'Quảng Nam', '0905444444', 'NguyenVanD@gmail.com', '2'),
																																				('Nguyễn Văn E','https://firebasestorage.googleapis.com/v0/b/quan-ly-vat-tu-y-te.appspot.com/o/01-11-2022091849PManh-avatar-cute-dep-nhat-5.jpg?alt=media&token=8f9c7454-09e8-4cd4-9edf-63aa34ae314d', 'MKH-005', 'Đà Nẵng', '0905555555', 'NguyenVanE@gmail.com', '2'),
																																				('Nguyễn Văn F','https://firebasestorage.googleapis.com/v0/b/quan-ly-vat-tu-y-te.appspot.com/o/01-11-2022091906PManh-avatar-cute-nam-1.jpg?alt=media&token=aef90ef7-0156-43ab-93ee-d1d7cc2513a4', 'MKH-006', 'Huế', '0905666666', 'NguyenVanF@gmail.com', '2'),
																																				('Công ty Lan Anh','https://firebasestorage.googleapis.com/v0/b/quan-ly-vat-tu-y-te.appspot.com/o/01-11-2022091954PMavt-cap-doi-1.jpg?alt=media&token=4b5c6c0f-0dbd-4d04-948a-c791c0a34ad7', 'MKH-007', 'Đà Nẵng', '0905777777', 'CongTyLanAnh@gmail.com', '3'),
																																				('Công ty Hải Dương','https://firebasestorage.googleapis.com/v0/b/quan-ly-vat-tu-y-te.appspot.com/o/01-11-2022092026PMf01ac0a2d04bbc96aea2d79d28587573.jpg?alt=media&token=0ae3f312-5d24-4ec0-ab8e-32678ac408be', 'MKH-008', 'Huế', '0905888888', 'CongTyHaiDuong@gmail.com', '3'),
																																				('Công ty Viết Huy','https://firebasestorage.googleapis.com/v0/b/quan-ly-vat-tu-y-te.appspot.com/o/01-11-2022092044PMhinh-avatar-nam-deo-kinh.jpg?alt=media&token=2f6c8f09-df66-47f1-9cf0-93a1ab9a6375', 'MKH-009', 'Đà Nẵng', '0905999999', 'CongTyVietHuy@gmail.com', '3'),
																																				('Công ty Thanh Thắng',null, 'MKH-010', 'Huế', '0905000000', 'CongTyThanhThang@gmail.com', '3');
                                                                                                                                                                          
INSERT INTO employee (employee_code,employee_avatar, employee_name, employee_date_of_birth, employee_gender, employee_address, employee_phone, employee_salary, employee_account_id, employee_position_id) VALUES ('MNV-001','https://cdn.chanhtuoi.com/uploads/2022/01/hinh-avatar-nam-deo-kinh.jpg', 'Lê Văn A', '1990-01-01', 'Nam', 'Quảng Nam', '0383111111', '1000', '1', '1'),
																																																  ('MNV-002',null, 'Lê Văn B', '1991-02-02', 'Nữ', 'Đà Nẵng', '0383222222', '5000', '2', '1');
																																																				--    ('MNV-003', 'Lê Văn C',  '1992-03-03', 'Khác', 'Quảng Nam', '0983333333', '3000', '3', '2'),
-- 																																																				   ('MNV-004', 'Lê Văn D',  '1993-04-04', 'Nam', 'Đà Nẵng', '0983444444', '4000', '4', '2'),
-- 																																																				   ('MNV-005', 'Lê Văn E', '1994-05-05', 'Nữ', 'Quảng Nam', '0983555555', '6000', '5', '2'),
-- 																																																				   ('MNV-006', 'Lê Văn F', '1995-06-06', 'Khác', 'Đà Nẵng', '0983666666', '7000', '6', '2'),
-- 																																																				   ('MNV-007', 'Lê Văn G',  '1996-07-07', 'Nam', 'Huế', '0983777777', '9000', '7', '3'),
-- 																																																				   ('MNV-008', 'Lê Văn H', '1997-08-08', 'Nữ', 'Đà Nẵng', '0983888888', '10000', '8', '3'),
-- 																																																				   ('MNV-009', 'Lê Văn I', '1998-09-09', 'Khác', 'Huế', '0983999999', '500', '9', '3'),
-- 																																																				   ('MNV-010', 'Lê Văn J', '1999-10-10', 'Nam', 'Đà Nẵng', '0983000000', '8500', '10', '3');
                                                                                                                                                                                                                   
INSERT INTO salary (salary_advance_payment, salary_employee_id) VALUES ('300', '1'),
																	   ('500', '2');
																	
                                                                       
                                                                       
INSERT INTO `material` (`material_code`, `material_name`, `material_price`, `material_expiridate`, `material_describe`, `material_unit`, `material_type_id`, `material_customer_id`) VALUES ('MVT-001', 'bông A', '5000', '2022-01-01',  'describe1', 'gói', '1', '7')
 ,('MVT-002', 'bông B', '4000', '2022-02-02',  'describe2', 'gói', '1', '8')
 ,('MVT-003', 'bông C', '3000', '2022-03-03', 'describe3', 'gói', '1', '9')
 ,('MVT-004', 'bông D', '2000', '2022-04-04', 'describe4', 'gói', '1', '10')
 ,('MVT-005', 'bông E', '1000', '2022-05-05', 'describe5', 'gói', '1', '7')
 ,('MVT-006', 'khẩu trang A', '5000', '2022-06-06', 'describe6', 'hộp', '2', '8')
 ,('MVT-007', 'khẩu trang B', '4000', '2022-07-07', 'describe7', 'hộp', '2', '9')
 ,('MVT-008', 'khẩu trang C', '3000', '2022-08-08', 'describe8', 'hộp', '2', '10')
 ,('MVT-009', 'khẩu trang D', '2000', '2022-09-09',  'describe9', 'hộp', '2', '7')
 ,('MVT-010', 'khẩu trang E', '1000', '2022-10-10', 'describe10', 'hộp', '2', '8');

INSERT INTO `cart_status` (`cart_status_name`) VALUES ('chưa thanh toán')
,('Đã thanh toán')
,('Trả hàng')
,('Huỷ hàng');																
                                                                                           
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
                 
UPDATE `sprint1`.`material` SET `material_name` = 'Khẩu trang 3 & 4 lớp', `material_image` = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3LDJShID36jTagclzdMmTxECuCpHV1Xq8dw&usqp=CAU,@ https://bom.so/8CaTr9,@ https://bom.so/tax5XZ', `material_describe` = 'Thanh nẹp mũi:  Nhựa PE,@Dây đeo tai: Polyester and Spandex,@Kiểu dây đeo: Vải dệt kim có tính đàn hồi,@Khẩu trang là một loại mặt nạ bảo vệ được sử dụng để bịt vùng mặt (thường là mũi, miệng) để bảo vệ người đeo khỏi bị lây nhiễm các loại vi khuẩn' WHERE (`material_id` = '3');
UPDATE `sprint1`.`material` SET `material_name` = 'Máy tạo Oxy DEDAKJ DE-2A 2-9 lít', `material_image` = 'https://vattuytesaigon.vn/wp-content/uploads/2022/04/de-2a-768x768.jpg', `material_describe` = 'Tạo 9 lít oxy nguyên chất trong vòng 1 phút,@Tạo hàm lượng ion âm đạt 6 triệu/cm3,@Hẹn giờ có thể lên tới 180 phút,@Tích hợp quạt làm mát với độ ồn thấp tối ưu, nhẹ nhàng, thoải mái.Tiết kiệm điện tốt, đạt tới 22% so với các sản phẩm tương tự khác' WHERE (`material_id` = '4');
UPDATE `sprint1`.`material` SET `material_name` = 'Máy tạo oxy 5 lít 93%', `material_image` = 'https://vattuytesaigon.vn/wp-content/uploads/2021/12/longfian0-768x768.jpg', `material_describe` = 'Máy tạo oxy 5 lít nồng độ oxy đạt từ 93 - 96%,@Có thể dùng cho 2 người cùng lúc,@Tuổi thọ máy nén lên tới 25000 giờ,@Máy tạo oxy JAY-B5W từ thương hiệu LONGFIAN – chuyên gia sản xuất máy tạo oxy và thiết bị y tế có kinh nghiệm trong nhiều năm liền' WHERE (`material_id` = '5');
UPDATE `sprint1`.`material` SET `material_name` = 'Giường bệnh viện 1 tay quay ZC02', `material_image` = 'https://vattuytesaigon.vn/wp-content/uploads/2021/08/1-tay-600x600-1.jpg', `material_describe` = 'Đầu và chân giường là bằng nhựa ABS,@Thành giường bằng hợp kim nhôm, 5 thanh chắn dọc,@Bánh xe đường kính 5″ (125mm) có khoá an toàn độc lập,@Giường bệnh viện 1 tay quay được làm từ các chất liệu an toàn và chắc chắn, tích hợp khoá an toàn ở các khớp' WHERE (`material_id` = '6');
UPDATE `sprint1`.`material` SET `material_name` = 'Máy tạo oxy 5 lít 93%', `material_image` = 'https://vattuytesaigon.vn/wp-content/uploads/2021/12/longfian0-768x768.jpg', `material_describe` = 'Máy tạo oxy 5 lít nồng độ oxy đạt từ 93 - 96%,@Có thể dùng cho 2 người cùng lúc,@Tuổi thọ máy nén lên tới 25000 giờ,@Máy tạo oxy JAY-B5W từ thương hiệu LONGFIAN – chuyên gia sản xuất máy tạo oxy và thiết bị y tế có kinh nghiệm trong nhiều năm liền' WHERE (`material_id` = '7');
UPDATE `sprint1`.`material` SET `material_name` = 'Giường bệnh viện 1 tay quay ZC02', `material_image` = 'https://vattuytesaigon.vn/wp-content/uploads/2021/08/1-tay-600x600-1.jpg', `material_describe` = 'Đầu và chân giường là bằng nhựa ABS,@Thành giường bằng hợp kim nhôm, 5 thanh chắn dọc,@Bánh xe đường kính 5″ (125mm) có khoá an toàn độc lập,@Giường bệnh viện 1 tay quay được làm từ các chất liệu an toàn và chắc chắn, tích hợp khoá an toàn ở các khớp' WHERE (`material_id` = '8');
UPDATE `sprint1`.`material` SET `material_name` = 'Máy tạo oxy 5 lít 93%', `material_image` = 'https://vattuytesaigon.vn/wp-content/uploads/2021/12/longfian0-768x768.jpg', `material_describe` = 'Máy tạo oxy 5 lít nồng độ oxy đạt từ 93 - 96%,@Có thể dùng cho 2 người cùng lúc,@Tuổi thọ máy nén lên tới 25000 giờ,@Máy tạo oxy JAY-B5W từ thương hiệu LONGFIAN – chuyên gia sản xuất máy tạo oxy và thiết bị y tế có kinh nghiệm trong nhiều năm liền' WHERE (`material_id` = '9');
UPDATE `sprint1`.`material` SET `material_name` = 'Máy tạo Oxy DEDAKJ DE-2A 2-9 lít', `material_image` = 'https://vattuytesaigon.vn/wp-content/uploads/2022/04/de-2a-768x768.jpg', `material_describe` = 'Tạo 9 lít oxy nguyên chất trong vòng 1 phút,@Tạo hàm lượng ion âm đạt 6 triệu/cm3,@Hẹn giờ có thể lên tới 180 phút,@Tích hợp quạt làm mát với độ ồn thấp tối ưu, nhẹ nhàng, thoải mái.Tiết kiệm điện tốt, đạt tới 22% so với các sản phẩm tương tự khác' WHERE (`material_id` = '10');

UPDATE `sprint1`.`employee` SET `employee_avatar` = 'https://cdn.chanhtuoi.com/uploads/2022/01/hinh-avatar-nam-deo-kinh.jpg' WHERE (`employee_id` = '1');