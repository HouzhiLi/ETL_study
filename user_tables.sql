create table sys_dept(
  dept_id number(20) primary key,
  parent_id number(20) default 0 ,
  ancestors varchar2(50) default '' ,
  dept_name varchar2(30) default '' ,
  order_num number(4) default 0 ,
  leader varchar2(20) default null ,
  phone varchar2(11) default null ,
  email varchar2(50) default null ,
  status char(1) default '0' ,
  del_flag char(1) default '0' ,
  create_by varchar2(64) default '' ,
  create_time date ,
  update_by varchar2(64) default '' ,
  update_time date
);
comment on table sys_dept is '部门信息表';
comment on column sys_dept.dept_id is '部门id ';
comment on column sys_dept.parent_id is '父部门id ';
comment on column sys_dept.ancestors is '祖级列表 ';
comment on column sys_dept.dept_name is '部门名称 ';
comment on column sys_dept.order_num is '显示顺序 ';
comment on column sys_dept.leader is '负责人 ';
comment on column sys_dept.phone is '联系电话 ';
comment on column sys_dept.email is '邮箱 ';
comment on column sys_dept.status is '部门状态（0正常 1停用） ';
comment on column sys_dept.del_flag is '删除标志（0代表存在 2代表删除';
comment on column sys_dept.create_by is '创建者 ';
comment on column sys_dept.create_time is '创建时间 ';
comment on column sys_dept.update_by is '更新者 ';
comment on column sys_dept.update_time is '更新时间 ';

create table sys_user(
  user_id number(20) primary key,
  dept_id number(20) default null ,
  login_name varchar2(30) not null ,
  user_name varchar2(30) default '' ,
  user_type varchar2(2) default '00' ,
  email varchar2(50) default '' ,
  phonenumber varchar2(11) default '' ,
  sex char(1) default '0' ,
  avatar varchar2(100) default '' ,
  password varchar2(50) default '' ,
  salt varchar2(20) default '' ,
  status char(1) default '0' ,
  del_flag char(1) default '0' ,
  login_ip varchar2(50) default '' ,
  login_date date ,
  pwd_update_date date ,
  create_by varchar2(64) default '' ,
  create_time date ,
  update_by varchar2(64) default '' ,
  update_time date ,
  remark varchar2(500) default null
);
comment on table sys_user is '用户信息表';

comment on column sys_user.user_id is '用户ID'; 
comment on column sys_user.dept_id is '部门ID'; 
comment on column sys_user.login_name is '登录账号'; 
comment on column sys_user.user_name is '用户昵称'; 
comment on column sys_user.user_type is '用户类型（00系统用户 01注册用户）'; 
comment on column sys_user.email is '用户邮箱'; 
comment on column sys_user.phonenumber is '手机号码'; 
comment on column sys_user.sex is '用户性别（0男 1女 2未知）'; 
comment on column sys_user.avatar is '头像路径'; 
comment on column sys_user.password is '密码'; 
comment on column sys_user.salt is '盐加密'; 
comment on column sys_user.status is '帐号状态（0正常 1停用）'; 
comment on column sys_user.del_flag is '删除标志（0代表存在 2代表删除）'; 
comment on column sys_user.login_ip is '最后登录IP'; 
comment on column sys_user.login_date is '最后登录时间'; 
comment on column sys_user.pwd_update_date is '密码最后更新时间'; 
comment on column sys_user.create_by is '创建者'; 
comment on column sys_user.create_time is '创建时间'; 
comment on column sys_user.update_by is '更新者'; 
comment on column sys_user.update_time is '更新时间'; 
comment on column sys_user.remark is '备注'; 



create table sys_post(
	post_id number(20) primary key ,
	post_code varchar2(64) not null ,
	post_name varchar2(50) not null ,
	post_sort number(4) not null ,
	status char(1) not null ,
	create_by varchar2(64) default '' ,
	create_time date ,
	update_by varchar2(64) default '' ,
	update_time date ,
	remark varchar2(500) default null
);
comment on table sys_post is '岗位信息表';
comment on column sys_post.post_id is '岗位ID';
comment on column sys_post.post_code is '岗位编码';
comment on column sys_post.post_name is '岗位名称';
comment on column sys_post.post_sort is '显示顺序';
comment on column sys_post.status is '状态（0正常 1停用）';
comment on column sys_post.create_by is '创建者';
comment on column sys_post.create_time is '创建时间';
comment on column sys_post.update_by is '更新者';
comment on column sys_post.update_time is '更新时间';
comment on column sys_post.remark is '备注'; 


create table sys_role(
  role_id number(20) primary key ,
  role_name varchar2(30) not null ,
  role_key varchar2(100) not null ,
  role_sort number(4) not null ,
  data_scope char(1) default '1' ,
  status char(1) not null ,
  del_flag char(1) default '0' ,
  create_by varchar2(64) default '' ,
  create_time date ,
  update_by varchar2(64) default '' ,
  update_time date ,
  remark varchar2(500) default null
);
comment on table sys_role is '角色信息表';

comment on column sys_role.role_id is '角色ID';
comment on column sys_role.role_name is '角色名称';
comment on column sys_role.role_key is '角色权限字符串';
comment on column sys_role.role_sort is '显示顺序';
comment on column sys_role.data_scope is '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）';
comment on column sys_role.status is '角色状态（0正常 1停用）';
comment on column sys_role.del_flag is '删除标志（0代表存在 2代表删除）';
comment on column sys_role.create_by is '创建者';
comment on column sys_role.create_time is '创建时间';
comment on column sys_role.update_by is '更新者';
comment on column sys_role.update_time is '更新时间';
comment on column sys_role.remark is '备注';


create table sys_menu(
  menu_id number(20) primary key,
  menu_name varchar2(50) not null ,
  parent_id number(20) default 0 ,
  order_num number(4) default 0 ,
  url varchar2(200) default '#' ,
  target varchar2(20) default '' ,
  menu_type char(1) default '' ,
  visible char(1) default 0 ,
  is_refresh char(1) default 1 ,
  perms varchar2(100) default null ,
  icon varchar2(100) default '#' ,
  create_by varchar2(64) default '' ,
  create_time date ,
  update_by varchar2(64) default '' ,
  update_time date ,
  remark varchar2(500) default '' 
);
comment on table sys_menu is '菜单表';
comment on column sys_menu.menu_id is '菜单ID';
comment on column sys_menu.menu_name is '菜单名称';
comment on column sys_menu.parent_id is '父菜单ID';
comment on column sys_menu.order_num is '显示顺序';
comment on column sys_menu.url is '请求地址';
comment on column sys_menu.target is '打开方式（menuItem页签 menuBlank新窗口）';
comment on column sys_menu.menu_type is '菜单类型（M目录 C菜单 F按钮）';
comment on column sys_menu.visible is '菜单状态（0显示 1隐藏）';
comment on column sys_menu.is_refresh is '是否刷新（0刷新 1不刷新）';
comment on column sys_menu.perms is '权限标识';
comment on column sys_menu.icon is '菜单图标';
comment on column sys_menu.create_by is '创建者';
comment on column sys_menu.create_time is '创建时间';
comment on column sys_menu.update_by is '更新者';
comment on column sys_menu.update_time is '更新时间';
comment on column sys_menu.remark is '备注';


create table sys_user_role(
	user_id   number(20) not null,
	role_id   number(20) not null 
);
comment on table sys_user_role is '用户角色关联表';
comment on column sys_user_role.user_id is '用户ID';
comment on column sys_user_role.role_id is '角色ID';


create table sys_role_menu(
	role_id   number(20) not null,
	menu_id   number(20) not null
);
comment on table sys_role_menu is '角色菜单关系表';
comment on column sys_role_menu.role_id is'角色ID';
comment on column sys_role_menu.menu_id is'菜单ID';


create table sys_role_dept(
	role_id   number(20) not null,
	dept_id   number(20) not null
);
comment on table sys_role_dept is '角色部门关联表';
comment on column sys_role_dept.role_id is '角色ID';
comment on column sys_role_dept.dept_id is '部门ID';


create table sys_user_post(
	user_id   number(20) not null,
	post_id   number(20) not null
);
comment on table sys_user_post is '用户岗位关联表';
comment on column sys_user_post.user_id is '用户ID';
comment on column sys_user_post.post_id is '岗位ID';
