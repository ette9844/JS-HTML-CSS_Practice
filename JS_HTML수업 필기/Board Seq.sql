--�۹�ȣ�� ������ ��ü ����
CREATE SEQUENCE board_seq
START WITH 11;

--���� ����� insert��
INSERT INTO board VALUES (board_seq.NEXTVAL, null, '������', 'JSTL', '�������� nextval�� ����Ͽ� �۹�ȣ�� �ڵ� ���̱�', SYSDATE, 'w8w');