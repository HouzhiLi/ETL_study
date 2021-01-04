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
comment on table sys_dept is '������Ϣ��';
comment on column sys_dept.dept_id is '����id ';
comment on column sys_dept.parent_id is '������id ';
comment on column sys_dept.ancestors is '�漶�б� ';
comment on column sys_dept.dept_name is '�������� ';
comment on column sys_dept.order_num is '��ʾ˳�� ';
comment on column sys_dept.leader is '������ ';
comment on column sys_dept.phone is '��ϵ�绰 ';
comment on column sys_dept.email is '���� ';
comment on column sys_dept.status is '����״̬��0���� 1ͣ�ã� ';
comment on column sys_dept.del_flag is 'ɾ����־��0������� 2����ɾ��';
comment on column sys_dept.create_by is '������ ';
comment on column sys_dept.create_time is '����ʱ�� ';
comment on column sys_dept.update_by is '������ ';
comment on column sys_dept.update_time is '����ʱ�� ';

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
comment on table sys_user is '�û���Ϣ��';

comment on column sys_user.user_id is '�û�ID'; 
comment on column sys_user.dept_id is '����ID'; 
comment on column sys_user.login_name is '��¼�˺�'; 
comment on column sys_user.user_name is '�û��ǳ�'; 
comment on column sys_user.user_type is '�û����ͣ�00ϵͳ�û� 01ע���û���'; 
comment on column sys_user.email is '�û�����'; 
comment on column sys_user.phonenumber is '�ֻ�����'; 
comment on column sys_user.sex is '�û��Ա�0�� 1Ů 2δ֪��'; 
comment on column sys_user.avatar is 'ͷ��·��'; 
comment on column sys_user.password is '����'; 
comment on column sys_user.salt is '�μ���'; 
comment on column sys_user.status is '�ʺ�״̬��0���� 1ͣ�ã�'; 
comment on column sys_user.del_flag is 'ɾ����־��0������� 2����ɾ����'; 
comment on column sys_user.login_ip is '����¼IP'; 
comment on column sys_user.login_date is '����¼ʱ��'; 
comment on column sys_user.pwd_update_date is '����������ʱ��'; 
comment on column sys_user.create_by is '������'; 
comment on column sys_user.create_time is '����ʱ��'; 
comment on column sys_user.update_by is '������'; 
comment on column sys_user.update_time is '����ʱ��'; 
comment on column sys_user.remark is '��ע'; 



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
comment on table sys_post is '��λ��Ϣ��';
comment on column sys_post.post_id is '��λID';
comment on column sys_post.post_code is '��λ����';
comment on column sys_post.post_name is '��λ����';
comment on column sys_post.post_sort is '��ʾ˳��';
comment on column sys_post.status is '״̬��0���� 1ͣ�ã�';
comment on column sys_post.create_by is '������';
comment on column sys_post.create_time is '����ʱ��';
comment on column sys_post.update_by is '������';
comment on column sys_post.update_time is '����ʱ��';
comment on column sys_post.remark is '��ע'; 


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
comment on table sys_role is '��ɫ��Ϣ��';

comment on column sys_role.role_id is '��ɫID';
comment on column sys_role.role_name is '��ɫ����';
comment on column sys_role.role_key is '��ɫȨ���ַ���';
comment on column sys_role.role_sort is '��ʾ˳��';
comment on column sys_role.data_scope is '���ݷ�Χ��1��ȫ������Ȩ�� 2���Զ�����Ȩ�� 3������������Ȩ�� 4�������ż���������Ȩ�ޣ�';
comment on column sys_role.status is '��ɫ״̬��0���� 1ͣ�ã�';
comment on column sys_role.del_flag is 'ɾ����־��0������� 2����ɾ����';
comment on column sys_role.create_by is '������';
comment on column sys_role.create_time is '����ʱ��';
comment on column sys_role.update_by is '������';
comment on column sys_role.update_time is '����ʱ��';
comment on column sys_role.remark is '��ע';


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
comment on table sys_menu is '�˵���';
comment on column sys_menu.menu_id is '�˵�ID';
comment on column sys_menu.menu_name is '�˵�����';
comment on column sys_menu.parent_id is '���˵�ID';
comment on column sys_menu.order_num is '��ʾ˳��';
comment on column sys_menu.url is '�����ַ';
comment on column sys_menu.target is '�򿪷�ʽ��menuItemҳǩ menuBlank�´��ڣ�';
comment on column sys_menu.menu_type is '�˵����ͣ�MĿ¼ C�˵� F��ť��';
comment on column sys_menu.visible is '�˵�״̬��0��ʾ 1���أ�';
comment on column sys_menu.is_refresh is '�Ƿ�ˢ�£�0ˢ�� 1��ˢ�£�';
comment on column sys_menu.perms is 'Ȩ�ޱ�ʶ';
comment on column sys_menu.icon is '�˵�ͼ��';
comment on column sys_menu.create_by is '������';
comment on column sys_menu.create_time is '����ʱ��';
comment on column sys_menu.update_by is '������';
comment on column sys_menu.update_time is '����ʱ��';
comment on column sys_menu.remark is '��ע';


create table sys_user_role(
	user_id   number(20) not null,
	role_id   number(20) not null 
);
comment on table sys_user_role is '�û���ɫ������';
comment on column sys_user_role.user_id is '�û�ID';
comment on column sys_user_role.role_id is '��ɫID';


create table sys_role_menu(
	role_id   number(20) not null,
	menu_id   number(20) not null
);
comment on table sys_role_menu is '��ɫ�˵���ϵ��';
comment on column sys_role_menu.role_id is'��ɫID';
comment on column sys_role_menu.menu_id is'�˵�ID';


create table sys_role_dept(
	role_id   number(20) not null,
	dept_id   number(20) not null
);
comment on table sys_role_dept is '��ɫ���Ź�����';
comment on column sys_role_dept.role_id is '��ɫID';
comment on column sys_role_dept.dept_id is '����ID';


create table sys_user_post(
	user_id   number(20) not null,
	post_id   number(20) not null
);
comment on table sys_user_post is '�û���λ������';
comment on column sys_user_post.user_id is '�û�ID';
comment on column sys_user_post.post_id is '��λID';
