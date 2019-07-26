--�亯�� �Խ��� [BOARD]

--�۹�ȣ(�ڵ� �ο�)    board_no       NUMBER        - PRIMARY KEY
--�θ�۹�ȣ          parent_no      NUMBER        - FOREIGN KEY(�ڱ� ���� ����), NULLABLE
--�Խù� ����         board_subject  VARCHAR2(30)  - NOT NULL 
--�ۼ��� �̸�(�г���)  board_writer   VARCHAR2(30)  - NOT NULL
--����               board_content  VARCHAR2(300) - NOT NULL 
--�ۼ� �ð�(�ڵ� �ο�) board_time     DATE          - NOT NULL
--��й�ȣ            board_pwd      VARCHAR2(10)  - NOT NULL 

--NUMBER : ���� �� ���ϸ� number�� ǥ���Ҽ� �ִ� �ִ� ���� ����
--VARCHAR2 : �ݵ�� ����� �����������
--VARCHAR2(30) : �ѱ� 10�� ����

--�θ�۹�ȣ >o------ �۹�ȣ
--�۹�ȣ�� �θ�۹�ȣ�� �����ص� �ǰ� ���ص� �ȴ�(���� ���� o)
--�θ�۹�ȣ�� �۹�ȣ �ϳ��� ��Ī, �۹�ȣ�� ���� ���� �θ�۹�ȣ�� ���� �پ��� �����̼ǰ� ��Ī�ȴ�

CREATE TABLE board (
    board_no NUMBER CONSTRAINT board_board_no_pk PRIMARY KEY, 
    parent_no NUMBER CONSTRAINT board_parent_no_fk REFERENCES board(board_no), 
    board_subject VARCHAR2(30) NOT NULL, 
    board_writer VARCHAR2(30) NOT NULL, 
    board_content VARCHAR2(300) NOT NULL, 
    board_time DATE NOT NULL, 
    board_pwd VARCHAR2(10) NOT NULL);

INSERT INTO board VALUES(1, NULL, '����1', 'w1', 'c1', sysdate, '1');
INSERT INTO board VALUES(2, NULL, '����2', 'w2', 'c2', sysdate, '2');
INSERT INTO board VALUES(3, 2, '����2-��1', 'w3', 'c3', sysdate, '3');
INSERT INTO board VALUES(4, 1, '����1-��1', 'w4', 'c4', sysdate, '4');
INSERT INTO board VALUES(5, 4, '����1-��1-��1', 'w5', 'c5', sysdate, '5');
INSERT INTO board VALUES(6, 4, '����1-��1-��2', 'w6', 'c6', sysdate, '6');
INSERT INTO board VALUES(7, 1, '����1-��2', 'w7', 'c7', sysdate, '7');
SELECT * FROM board;

COMMIT;

--EX)
--�۹�ȣ--�θ�۹�ȣ--�Խù� ����--�̸�--����--�ۼ� �ð�--��й�ȣ
--1      NULL       ����1
--2      NULL       ����2
--3      2          ����2-��1
--4      1          ����1-��1
--5      4          ����1-��1-��1
--6      4          ����1-��1-��2
--7      1          ����1-��2

--����>��� ������ �ֱټ�
--2      NULL       ����2
--   �� 3      2          ����2-��1
--1      NULL       ����1
--   �� 7      1          ����1-��2
--   �� 4      1          ����1-��1
--     �� 6      4          ����1-��1-��2
--     �� 5      4          ����1-��1-��1

--������ ������ ��� ã��
--1) ���� ã��
SELECT *
FROM board
START WITH parent_no IS NULL    --START WITH: ������ ���� ��� ����
CONNECT BY PRIOR board_no = parent_no;
--CONNECT BY: � ������� ���� ������ ã�°�
--PRIOR board_no: ���� ���� board_no  
--parent_no: �ٸ� ���� parent_no

--�ð� �� ����
SELECT rownum, level, board.*            --level: ����Ŭ���� �����ϴ� pseudo column
FROM board
START WITH parent_no IS NULL     --START WITH: ������ ���� ��� ����
CONNECT BY PRIOR board_no = parent_no
ORDER SIBLINGS BY board_no DESC; --���� ����(����) ���̿����� ���� ����

--Ư�� ��ġ�� �ุ �˻��ϱ�
SELECT rownum, board.*
FROM board
WHERE rownum >=2 AND rownum  <=5;

--�Ѱ��� �൵ �˻����� ����
SELECT rownum, level, board.*
FROM board
WHERE rownum BETWEEN 1 AND 5
START WITH parent_no IS NULL
CONNECT BY PRIOR board_no = parent_no
ORDER SIBLINGS BY board_no DESC;
--BETWEEN�� �Ű�������1�� ������ ���� �۵������� 2���� �����ϸ� �۵� x
--�̸� �ذ��ϱ� ���� �ζ��κ並 ���� �������� �ۼ�

--SELECT���� ó�� ����
----------------SELECTION-------------|----Presentation----|
--FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY
--                                    �� ��, rownum 1 ����

--�ζ��κ�
SELECT a.*
FROM
    (SELECT rownum rn, level, board.*
    FROM board
    START WITH parent_no IS NULL
    CONNECT BY PRIOR board_no = parent_no
    ORDER SIBLINGS BY board_no DESC) a
WHERE a.rn BETWEEN 2 AND 5;

DESC board;